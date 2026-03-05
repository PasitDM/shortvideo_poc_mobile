import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/build_context_extension.dart';
import '../../styles/index.dart';
import 'cubit/history_cubit.dart';
import 'cubit/history_state.dart';
import 'widgets/history_body.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit()..fetchHistory(),
      child: const _HistoryScreenView(),
    );
  }
}

class _HistoryScreenView extends StatelessWidget {
  const _HistoryScreenView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: context.appColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: context.appColors.iconPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text('ประวัติการรับชม', style: AppTextStyle.largeTitleRegular.copyWith(color: context.appColors.textPrimary)),
        centerTitle: true,
        actions: [
          BlocBuilder<HistoryCubit, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoaded && state.items.isNotEmpty) {
                return IconButton(
                  icon: state.isEditMode
                      ? Text('ยกเลิก', style: AppTextStyle.body1Medium.copyWith(color: context.appColors.textPrimary))
                      : Icon(Icons.edit_outlined, color: context.appColors.iconPrimary),
                  onPressed: () => context.read<HistoryCubit>().toggleEditMode(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ], 
      ),
      body: const SafeArea(
        child: HistoryBody(),
      ),
    );
  }
}
