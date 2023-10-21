import 'package:e_commerce/components/page_indicator_dots.dart';
import 'package:e_commerce/components/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class OnboardingBottomBar extends StatelessWidget {
  const OnboardingBottomBar({
    super.key,
    required this.length,
    required this.currentIndex,
    required this.onNextPage,
  });

  final int length;
  final int currentIndex;
  final VoidCallback onNextPage;

  Widget getIndicatorWidget() {
    if (length > 1) {
      return PageIndicatorDots(
        length: length,
        currentIndex: currentIndex,
      );
    }

    return const SizedBox(width: 1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getIndicatorWidget(),
            PrimaryButton(
              width: 110,
              height: 60,
              onPressed: onNextPage,
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
