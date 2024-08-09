import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/screen/home/home_screen.dart';
import 'package:to_do_list/screen/onboarding/onboarding.dart';

class OnboardingService {
  Future<bool> isFirstTimeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTime') ?? true;
  }

  
  Future<void> setFirstTimeUserCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
  }

  
  void navigateToNextScreen(BuildContext context, bool isFirstTime) {
    final Widget nextScreen = isFirstTime ? const OnBoardingScreen() : const HomeScreen();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }
}
