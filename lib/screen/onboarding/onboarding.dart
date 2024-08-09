import 'package:flutter/material.dart';
import 'package:to_do_list/model/onboarding_data.dart';
import 'package:to_do_list/service/onboarding_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_list/style/color_constant.dart';
import 'package:to_do_list/widget/onboarding_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController pageController;
  bool isLoading = false;
  int currentPage = 0;

  final OnboardingService _onboardingService = OnboardingService();

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    pageController.addListener(() {
      int newPage = pageController.page!.round();
      if (currentPage != newPage) {
        setState(() {
          currentPage = newPage;
        });
      }
    });
  }

  Future<void> _completeOnboarding() async {
    await _onboardingService.setFirstTimeUserCompleted();

    bool isFirstTime = await _onboardingService.isFirstTimeUser();

    if (mounted) {
      _onboardingService.navigateToNextScreen(context, isFirstTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              controller: pageController,
              children: [
                OnboardingImage(
                  pageData: const PageContent.first(),
                  isLoading: isLoading,
                  title: 'Welcome to ToDo List',
                  subtitle:
                      'Manage your tasks effectively with our easy-to-use app.',
                ),
                OnboardingImage(
                  pageData: const PageContent.second(),
                  isLoading: isLoading,
                  title: 'Add Tasks',
                  subtitle:
                      'Easily add new tasks and keep track of what needs to be done.',
                ),
                OnboardingImage(
                  pageData: const PageContent.third(),
                  isLoading: isLoading,
                  title: 'Edit and Delete',
                  subtitle: 'Edit or delete tasks with a simple swipe or tap.',
                ),
                OnboardingImage(
                  pageData: const PageContent.fourth(),
                  isLoading: isLoading,
                  title: 'Track Your Progress',
                  subtitle:
                      'Mark tasks as completed and track your progress over time.',
                ),
              ],
            ),
            if (currentPage < 3)
              Align(
                alignment: const Alignment(0, 0.8),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  onDotClicked: (index) {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 40,
                    activeDotColor: ColorPalette.primary,
                    dotColor: Colors.white,
                  ),
                ),
              ),
            if (currentPage == 3)
              Positioned(
                bottom: 60,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                        onTap: () {
                          _completeOnboarding();
                        },
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
              )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.removeListener(() {});
    pageController.dispose();
    super.dispose();
  }
}
