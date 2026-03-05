import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/initializers/dependencies_initializer.dart';
import 'cubit/history1_cubit.dart';
import 'history1_screen_view.dart';

class History1Screen extends StatelessWidget {
  const History1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => History1Cubit(getIt())..loadHistory(),
      child: const History1ScreenView(),
    );
  }
}
