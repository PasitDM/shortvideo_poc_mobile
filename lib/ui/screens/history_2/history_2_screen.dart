import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/initializers/dependencies_initializer.dart';
import '../../extensions/build_context_extension.dart';
import '../../styles/index.dart';
import 'cubit/history_2_cubit.dart';
import 'cubit/history_2_state.dart';
import 'widgets/history_2_body.dart';

class History2Screen extends StatelessWidget {
  const History2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => History2ScreenCubit(repository: getIt()),
      child: const _History2ScreenView(),
    );
  }
}

class _History2ScreenView extends StatefulWidget {
  const _History2ScreenView();

  @override
  State<_History2ScreenView> createState() => _History2ScreenViewState();
}

class _History2ScreenViewState extends State<_History2ScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<History2ScreenCubit>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.backgroundPrimary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: BlocSelector<History2ScreenCubit, History2ScreenState, bool>(
          selector: (state) => state.isEditMode,
          builder: (context, isEditMode) {
            return isEditMode ? _buildEditModeAppBar(context) : _buildNormalAppBar(context);
          },
        ),
      ),
      body: const SafeArea(
        child: History2Body(),
      ),
    );
  }

  Widget _buildNormalAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.appColors.backgroundPrimary,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: context.appColors.iconPrimary,
          size: 20,
        ),
        onPressed: () => context.pop(),
      ),
      title: Text(
        'ประวัติการรับชม',
        style: AppTextStyle.body1Regular.copyWith(
          color: context.appColors.textPrimary,
        ),
      ),
      centerTitle: true,
      actions: [
        BlocSelector<History2ScreenCubit, History2ScreenState, bool>(
          selector: (state) => state.status == History2ScreenStatus.ready && state.items.isNotEmpty,
          builder: (context, showEditButton) {
            if (!showEditButton) return const SizedBox.shrink();
            return IconButton(
              icon: Icon(
                Icons.edit_outlined,
                color: context.appColors.iconPrimary,
              ),
              onPressed: () => context.read<History2ScreenCubit>().toggleEditMode(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEditModeAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.appColors.backgroundPrimary,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Select All button
          GestureDetector(
            onTap: () => context.read<History2ScreenCubit>().selectAll(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocSelector<History2ScreenCubit, History2ScreenState, bool>(
                  selector: (state) => state.selectedItemIds.length == state.items.length && state.items.isNotEmpty,
                  builder: (context, allSelected) {
                    return Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: allSelected ? context.appColors.buttonPrimary : context.appColors.borderSecondary,
                          width: 1.5,
                        ),
                        color: allSelected ? context.appColors.buttonPrimary : Colors.transparent,
                      ),
                      child: allSelected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
                    );
                  },
                ),
                const SizedBox(width: 16),
                Text(
                  'เลือกทั้งหมด',
                  style: AppTextStyle.body1Regular.copyWith(
                    color: context.appColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // Cancel button
          GestureDetector(
            onTap: () => context.read<History2ScreenCubit>().toggleEditMode(),
            child: Text(
              'ยกเลิก',
              style: AppTextStyle.body1Regular.copyWith(
                color: context.appColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
