import 'package:flutter/material.dart';

class PageIndicatorDots extends StatelessWidget {
  const PageIndicatorDots({
    super.key,
    required this.length,
    required this.currentIndex,
  }) : assert(length >= 1, 'Lenght must be greater than 0');

  final int length;
  final int currentIndex;

  Widget selectedWidget() {
    return Container(
      width: 20,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget unselectedWidget() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (length <= 1) {
      return Container();
    }

    return SizedBox(
      width: 75,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(
          length,
          (int index) {
            return index == currentIndex
                ? selectedWidget()
                : unselectedWidget();
          },
        ),
      ),
    );
  }
}
