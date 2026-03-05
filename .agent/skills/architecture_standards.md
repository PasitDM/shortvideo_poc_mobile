---
name: Architecture Standards
description: Core architectural rules and coding standards for the Flippy Mobile project.
---

# Architecture Standards

Follow these rules to maintain consistency, performance, and scalability across the project.

## 0. Development Workflow

### Use `fvm flutter`
**Rule**: Always use `fvm flutter` when running commands (e.g., `fvm flutter pub get`, `fvm flutter run`) instead of just `flutter`.
**Why**: Ensures that the local machine uses the project-specific Flutter version defined in `.fvm/fvm_config.json`, preventing version mismatch issues.

### Verify Code with `fvm flutter analyze`
**Rule**: Always run `fvm flutter analyze` after making code changes or creating new files.
**Why**: Catches static analysis errors and lint warnings early, ensuring code quality and preventing build issues.

## 1. State Management (Bloc & Cubit)

### Prefer `BlocSelector`
**Rule**: Use `BlocSelector` by default for building UI parts that depend on state changes.
**Why**: better performance. It prevents unnecessary rebuilds of the entire widget tree when unrelated parts of the state change.
**Usage**:
```dart
// ✅ DO THIS
BlocSelector<MyCubit, MyState, bool>(
  selector: (state) => state.isLoading,
  builder: (context, isLoading) {
    if (isLoading) return const LoadingIndicator();
    return const SizedBox();
  }
)

// ⚠️ AVOID THIS (unless you strictly need full state access)
BlocBuilder<MyCubit, MyState>(
  builder: (context, state) { ... }
)
```

### State Mutation Helper Methods
**Rule**: Define helper methods in your `State` class (`loading()`, `success()`, `failure()`) and use them in your Cubit.
**Why**: Reduces boilerplate `copyWith` calls in business logic and enforces consistent state transitions.
**Usage**:
In **State**:
```dart
MyState loading() => copyWith(status: MyStatus.loading);
MyState success(Data data) => copyWith(status: MyStatus.success, data: data);
MyState failure(AppError error) => copyWith(status: MyStatus.failure, error: error);
```
In **Cubit**:
```dart
emit(state.loading());
// ...
emit(state.success(data));
```

### Error Handling in Cubits
**Rule**: Cubit functions that call Repositories or UseCases using the `Result` pattern should **not** use `try-catch` blocks.
**Why**: Detailed error handling (wrapping exceptions into `Failure` objects) is delegated to the Repository layer. The Cubit should simply `switch` on the result. Only use `try-catch` in Cubits for non-data-layer logic (e.g., local file operations or complex UI logic) that might throw.

## 2. Navigation & Routing

### Screen Arguments
- **Dedicated Arguments Class**: When passing data between screens, create a dedicated `Arguments` class in a `arguments` folder within the feature's screen directory (e.g., `lib/presentation/screens/feature_name/arguments/feature_name_screen_arguments.dart`).
- **Pass Arguments Object**: Pass the entire arguments object to the screen widget, rather than unpacking individual fields in the router.
  ```dart
  // Correct
  final arguments = state.extra as CropProfileImageScreenArguments;
  return CropProfileImageScreen(arguments: arguments);

  // Incorrect
  final args = state.extra as EpisodePlayerScreenArguments;
  return EpisodePlayerScreen(
    episodes: args.episodes,
    initialIndex: args.initialIndex,
  );
  ```

## 3. Data Flow & Result Pattern

### Return `Future<Result<T>>`
**Rule**: Repositories and UseCases must return `Future<Result<T>>`.
**Why**: Forces explicit handling of both Success and Failure cases.
**Usage**:
```dart
// Repository
Future<Result<User>> getUser();
```

### Use `switch` for Result Handling
**Rule**: Use `switch` statement to handle `Result` in Cubits. Avoid `.when` callback hell.
**Why**: Safer and more readable.
**Usage**:
```dart
final result = await _useCase();
switch (result) {
  case Success(:final value):
    emit(state.success(value));
  case Failure(:final error):
    emit(state.failure(error));
}
```

### UseCase Usage
**Rule**: Avoid creating "pass-through" UseCases.
**Why**: If a UseCase has no business logic other than calling a single repository method, the Cubit should call the repository directly to reduce boilerplate. Create a UseCase only when you need to:
- Combine multiple repositories.
- Perform complex business logic/data transformation.
- Reuse a specific logic across multiple Cubits.

### Repository Error Handling
**Rule**: Repositories **must** wrap all data source calls in `try-catch` blocks and return a `Failure(AppError.from(e))` on exception.
**Why**: Ensures that exceptions from the network or parsing layers are captured and converted into a standard `AppError` format before reaching the business logic.

### Data Source Parsing
**Rule**: Remote Data Sources should parse the nested `data` object from API responses (`response.data['data']`) if the API follows the project's standard wrapper. However, if a specific API returns data directly in the root or uses a different structure, parse it according to the actual response.
**Why**: While most project APIs use a standard wrapper, flexibility is required to support legacy endpoints or third-party integrations that do not follow this convention. Always verify the response structure during implementation.

## 4. UI & Styling

### Semantic Colors
**Rule**: Access colors via `context.appColors`. Do NOT use `AppPalette` directly in UI widgets.
**Why**: Supports theming (Dark/Light mode) automatically.
**Usage**:
```dart
// ✅ DO THIS
color: context.appColors.textPrimary

// ❌ AVOID THIS
color: AppPalette.neutralLevel100
```

### Material in Overlays
**Rule**: Wrap widgets in `Material(color: Colors.transparent)` if they are used in Overlays (e.g., `Stack` over `Scaffold`, Dialogs).
**Why**: Prevents "Red/Yellow" default text styling when a Scaffold context is missing.

### Use `AppTextStyle`
**Rule**: Use `AppTextStyle` instead of raw `TextStyle`.
**Why**: Ensures consistent typography across the app. If a design requires a slight variation, start with the closest `AppTextStyle` and use `.copyWith()`.
**Usage**:
```dart
// ✅ DO THIS
style: AppTextStyle.body1Regular,
style: AppTextStyle.body1Regular.copyWith(color: Colors.red),

// ❌ AVOID THIS
style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
```

### Use `DefaultAppBar`
**Rule**: Use `DefaultAppBar` instead of the standard `AppBar`.
**Why**: Ensures consistent App Bar styling (back button, title style, elevation) across the app. `DefaultAppBar` supports standard properties like `title`, `actions`, and `leading`, plus custom ones like `autoImplyLeading`.
**Usage**:
```dart
// ✅ DO THIS
appBar: DefaultAppBar(
  title: 'My Screen',
  onTapBack: () => context.pop(),
),

// ❌ AVOID THIS
appBar: AppBar(
  title: const Text('My Screen'),
  leading: IconButton(...),
),
```

### Localization
**Rule**: All UI text must be externalized using `.arb` files and accessed via `AppLocalizations` (e.g., `context.l10n`). Hardcoded strings in UI widgets are strictly prohibited.
**Why**: Supports multi-language requirements and maintainability.
**Usage**:
```dart
// ✅ DO THIS
Text(context.l10n.saveButtonLabel)

// ❌ AVOID THIS
Text('Save')
```

## 5. View Structure

### Separate `_buildScaffold`
**Rule**: Extract the `Scaffold` widget into a separate `_buildScaffold` method.
**Why**: Keeps the main `build` method clean for BlocListeners/Providers and clearly separates the visual layout code.
**Usage**:
```dart
@override
Widget build(BuildContext context) {
  return BlocListener<...>(
    child: _buildScaffold(context),
  );
}

Widget _buildScaffold(BuildContext context) {
  return Scaffold(...);
}
```

### State Initialization
**Rule**: Initialize state/data in the `initState` of the View (StatefulWidget), not in the `create` closure of `BlocProvider` (e.g., `..initialize()`).
**Why**: Ensures the build context is fully available and keeps the Provider declaration clean. Use a `StatefulWidget` for the `View` if initialization is needed.
**Usage**:
```dart
// ✅ DO THIS
class MyScreenView extends StatefulWidget { ... }

class _MyScreenViewState extends State<MyScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<MyCubit>().initialize();
  }
}

// ❌ AVOID THIS
BlocProvider(
  create: (context) => MyCubit()..initialize(),
  child: const MyScreenView(),
)
```

## 6. UI Components

### Loading State
**Rule**: Use `LoadingOverlay` for full-screen loading states (e.g., submitting forms, fetching initial data). Do NOT use loading buttons unless it's a very minor inline action.
**Why**: Prevents user interaction with the entire screen and provides a consistent loading experience.
**Usage**:
```dart
return LoadingOverlay(
  isLoading: state.status.isLoading,
  child: Scaffold(...),
);
```

### Bottom Sheet
**Rule**: Use `AppBottomSheet` for all bottom sheets.
**Why**: Consistent styling (border radius, background color, grab handle).

### Text Input
**Rule**: Use `CustomTextField` for all text inputs.
**Why**: Consistent styling, validation display, and behavior.

### Spacing (Gap)
**Rule**: Use the `Gap` widget from `lib/presentation/widgets/gap.dart` instead of `SizedBox(height: ...)` or `SizedBox(width: ...)` for adding space between widgets.
**Why**: `Gap(size)` uses a simplified syntax that reduces boilerplate and improves readability, automatically applying the dimension as a square `SizedBox`.
**Usage**:
```dart
// ✅ DO THIS
Column(
  children: [
    Text('Title'),
    const Gap(12),
    Text('Subtitle'),
  ],
)

// ❌ AVOID THIS
Column(
  children: [
    Text('Title'),
    const SizedBox(height: 12),
    Text('Subtitle'),
  ],
)
```

### Toast / SnackBar
**Rule**: Use `AppToast` for the notification.
**Why**: Consistent styling and behavior.

### Image Assets
**Rule**: Use `Assets.gen` (flutter_gen) for local images instead of hardcoded strings.
**Why**: Type safety and compile-time verification of asset paths.
**Usage**:
```dart
// ✅ DO THIS
Assets.images.home.logoHome.svg()
Assets.images.common.placeholder.image()

// ❌ AVOID THIS
Image.asset('assets/images/home/logo_home.svg')
```

### Network Images
**Rule**: Use `AppImageNetwork` for all network images. Do NOT use `Image.network` directly.
**Why**: Handles caching, error states, and placeholders consistently across the app.
**Usage**:
```dart
// ✅ DO THIS
AppImageNetwork(
  imageUrl,
  width: 100,
  height: 100,
  fit: BoxFit.cover,
)

// ❌ AVOID THIS
Image.network(imageUrl)
```

## 7. Models & Data Classes

### Use `Equatable` and Manual JSON Parsing
**Rule**: All models must extend `Equatable` and implement `fromJson` and `toJson` methods manually. Do NOT use `json_serializable` or `freezed` for models.
**Why**: Reduces reliance on code generation, keeps models simple, and ensures explicit control over serialization/deserialization logic.
**Usage**:
```dart
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;

  const User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };

  @override
  List<Object?> get props => [id, name];
}
```

## 8. Dependency Injection (GetIt)

### Registration Rules
**Rule**: All dependency injections must be registered in `lib/app/initializers/dependencies_initializer.dart`. Use the following lifetimes:
- **`registerSingleton` / `registerLazySingleton`**: Use for Data Sources, Repositories, Services, and global state (e.g., `AppStorage`, `SessionCubit`). Repositories should generally be LazySingletons unless immediately needed.
- **`registerFactory`**: Use for UseCases and screen-level Cubits/Blocs. This ensures a fresh instance is created every time it's injected (e.g., when a user navigates to a screen).

**Why**: Consistently scoping dependencies prevents memory leaks (from keeping unused Cubits alive) and ensures data freshness.

**Usage**:
```dart
// Singleton for global dependencies
getIt.registerSingleton<AppStorage>(storage);

// LazySingleton for Repositories and Data Sources
getIt.registerLazySingleton<UserRepository>(
  () => UserRepositoryImpl(UserRemoteDataSource(apiClient)),
);

// Factory for UseCases
getIt.registerFactory<GetUserUseCase>(
  () => GetUserUseCase(userRepository: getIt()),
);

// Factory for Screen Cubits (if injected)
getIt.registerFactory<HomeScreenCubit>(
  () => HomeScreenCubit(getIt()),
);
```

### Injection Usage
**Rule**: Prefer injecting dependencies via constructors rather than calling `getIt()` inside the business logic class itself.
**Why**: Making dependencies explicit in the constructor makes the class easier to mock and test.
**Usage**:
```dart
// ✅ DO THIS: Explicit dependencies in constructor
class GetUserUseCase {
  final UserRepository userRepository;
  GetUserUseCase({required this.userRepository});
}

// ❌ AVOID THIS: Hidden dependencies
class GetUserUseCase {
  final UserRepository userRepository = getIt<UserRepository>();
}
```
