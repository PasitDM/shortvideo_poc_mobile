import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/<FTName | snakecase>_screen_cubit.dart';
import 'cubit/<FTName | snakecase>_screen_state.dart';

class <FTName | pascalcase>Screen extends StatelessWidget {
  const <FTName | pascalcase>Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return <FTName | pascalcase>ScreenCubit();
      },
      child: const <FTName | pascalcase>ScreenView(),
    );
  }
}

class <FTName | pascalcase>ScreenView extends StatefulWidget {
  const <FTName | pascalcase>ScreenView({super.key});

  @override
  State<<FTName | pascalcase>ScreenView> createState() => _<FTName | pascalcase>ScreenViewState();
}

class _<FTName | pascalcase>ScreenViewState extends State<<FTName | pascalcase>ScreenView> {
  late final <FTName | pascalcase>ScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<<FTName | pascalcase>ScreenCubit>();
  }

  void _listener(BuildContext context, <FTName | pascalcase>ScreenState state) {
    switch (state.status) {
      case <FTName | pascalcase>ScreenStatus.initial:
      case <FTName | pascalcase>ScreenStatus.loading:
      case <FTName | pascalcase>ScreenStatus.ready:
        break;

      case <FTName | pascalcase>ScreenStatus.failure:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<<FTName | pascalcase>ScreenCubit, <FTName | pascalcase>ScreenState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _listener,
      child: _buildScaffold(),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('<FTName | pascalcase>'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('<FTName | pascalcase>'),
      ),
    );
  }
}
