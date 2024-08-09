import 'package:flutter/material.dart';
import 'package:to_do_list/service/onboarding_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OnboardingService _onboardingService = OnboardingService();

  @override
  void initState() {
    super.initState();
    _checkAndNavigate();
  }

  Future<void> _checkAndNavigate() async {
    await Future.delayed(const Duration(milliseconds: 2000));

    final bool isFirstTime = await _onboardingService.isFirstTimeUser();

    if (mounted) {
      _onboardingService.navigateToNextScreen(context, isFirstTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/to_do.png'),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'To-Do List\n',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  TextSpan(
                    text: 'Organize Your Day, Achieve Your Dreams.',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(height: 4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
