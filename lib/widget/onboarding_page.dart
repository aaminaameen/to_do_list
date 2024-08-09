import 'package:flutter/material.dart';
import 'package:to_do_list/model/onboarding_data.dart';
import 'package:to_do_list/style/style_constant.dart';

class OnboardingImage extends StatelessWidget {
  const OnboardingImage({
    required this.pageData,
    required this.isLoading,
    super.key,
    required this.title,
    required this.subtitle,
  });
  final PageContent pageData;
  final String title;
  final String subtitle;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              pageData.image,
            ),
            kHeight50,
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
