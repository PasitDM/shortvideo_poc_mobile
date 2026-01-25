import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../extensions/build_context_extension.dart';
import '../../styles/index.dart';
import 'cubit/onboarding_screen_cubit.dart';
import 'cubit/onboarding_screen_state.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return OnboardingScreenCubit();
      },
      child: const OnboardingScreenView(),
    );
  }
}

class OnboardingScreenView extends StatefulWidget {
  const OnboardingScreenView({super.key});

  @override
  State<OnboardingScreenView> createState() => _OnboardingScreenViewState();
}

class _OnboardingScreenViewState extends State<OnboardingScreenView> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> _onboardingData = [
    {
      'title': "Capture Life's Moments in a Flash",
      'image': 'assets/images/onboarding_1.png', // Placeholder
    },
    {
      'title': 'Your Stories, Our Stage: Short, Sweet, and Stunning!',
      'image': 'assets/images/onboarding_2.png', // Placeholder
    },
    {
      'title': 'Instant Entertainment, Endless Inspiration!',
      'image': 'assets/images/onboarding_3.png', // Placeholder
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.neutralLevel00,
      body: BlocBuilder<OnboardingScreenCubit, OnboardingScreenState>(
        builder: (context, state) {
          return Stack(
            children: [
              // PageView for Background Images
              PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  context.read<OnboardingScreenCubit>().setPageIndex(index);
                },
                itemBuilder: (context, index) {
                  return _buildPageImage(index);
                },
              ),

              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.1),
                        Colors.black.withValues(alpha: 0.8),
                        Colors.black,
                      ],
                      stops: const [0.0, 0.4, 0.7, 1.0],
                    ),
                  ),
                ),
              ),

              // Bottom Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildBottomContent(context, state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPageImage(int index) {
    // Using Container with colored background as placeholder if image fails
    // In real app, use Image.asset or Image.network
    return Container(
      color: index == 0
          ? Colors.blueGrey
          : index == 1
          ? Colors.teal
          : Colors.deepPurple,
      child: const Center(
        child: Icon(Icons.image, size: 100, color: Colors.white24),
      ),
    );
  }

  Widget _buildBottomContent(BuildContext context, OnboardingScreenState state) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            _onboardingData[state.pageIndex]['title']!,
            textAlign: TextAlign.center,
            // Using Header 1 - 32px Semibold
            style: AppTextStyle.w600(32).copyWith(
              color: AppPalette.white, // Always white on dark background
              height: 1.25,
            ),
          ),
          const SizedBox(height: 60),

          // Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingData.length,
              (index) => _buildIndicator(context, index, state.pageIndex),
            ),
          ),
          const SizedBox(height: 60),

          // Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (state.pageIndex < _onboardingData.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // Navigate to Get Started or Auth
                  context.go(AppRoutes.getStarted);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appColors.buttonPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 0,
              ),
              child: Text(
                state.pageIndex == _onboardingData.length - 1 ? 'Get Started' : 'Next',
                style: AppTextStyle.w600(14).copyWith(color: AppPalette.white),
              ),
            ),
          ),
          // const SizedBox(height: 20), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildIndicator(BuildContext context, int index, int currentIndex) {
    final bool isActive = index == currentIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 32 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? context.appColors.buttonPrimary : context.appColors.backgroundThirdary,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
