import 'package:e_commerce/components/onboarding/onboarding.dart';
import 'package:e_commerce/components/onboarding/onboarding_page_content.dart';
import 'package:e_commerce/pages/sign_up_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  void onboardingEnd(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Onboarding(
      onOnboardingEnd: () => onboardingEnd(context),
      pages: [
        OnboardingPageContent(
          imagePath: 'assets/images/onboarding_1.jpeg',
          title: 'page.onboarding.title_1'.tr(),
          body: 'page.onboarding.body_1'.tr(),
        ),
        OnboardingPageContent(
          imagePath: 'assets/images/onboarding_2.jpeg',
          title: 'page.onboarding.title_2'.tr(),
          body: 'page.onboarding.body_2'.tr(),
        ),
        OnboardingPageContent(
          imagePath: 'assets/images/onboarding_3.jpeg',
          title: 'page.onboarding.title_3'.tr(),
          body: 'page.onboarding.body_3'.tr(),
        )
      ],
    );
  }
}
