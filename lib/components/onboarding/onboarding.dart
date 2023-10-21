import 'package:e_commerce/components/onboarding/onboarding_body.dart';
import 'package:e_commerce/components/onboarding/onboarding_bottom_bar.dart';
import 'package:e_commerce/components/onboarding/onboarding_page_content.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({
    super.key,
    required this.pages,
    required this.onOnboardingEnd,
  });

  final List<OnboardingPageContent> pages;
  final VoidCallback onOnboardingEnd;

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController pageController = PageController();
  int pageIndex = 0;

  void goToNextPage(BuildContext context) {
    if (pageIndex == widget.pages.length - 1) {
      widget.onOnboardingEnd();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          onPageChanged: (index) => setState(() => pageIndex = index),
          controller: pageController,
          itemCount: widget.pages.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: OnboardingBody(page: widget.pages[index]),
          ),
        ),
      ),
      bottomNavigationBar: OnboardingBottomBar(
        currentIndex: pageIndex,
        length: widget.pages.length,
        onNextPage: () => goToNextPage(context),
      ),
    );
  }
}
