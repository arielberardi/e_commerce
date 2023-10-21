import 'package:e_commerce/components/brand_logo.dart';
import 'package:e_commerce/components/buttons/primary_button.dart';
import 'package:e_commerce/components/buttons/secondary_button.dart';
import 'package:e_commerce/pages/onboarding_page.dart';
import 'package:e_commerce/pages/sign_in_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void onSignUp(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const OnboardingPage()),
    );
  }

  void onSignIn(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_2.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.colorBurn),
          ),
        ),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [BrandLogo()],
              ),
            ),
            PrimaryButton(
              text: 'sign_in'.tr(),
              onPressed: () => onSignIn(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: const BorderSide(width: 2, color: Colors.white),
              ),
            ),
            const SizedBox(height: 25.0),
            SecondaryButton(
              text: 'sign_up'.tr(),
              onPressed: () => onSignUp(context),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                side: const BorderSide(width: 2, color: Colors.white),
              ),
            ),
            const SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}
