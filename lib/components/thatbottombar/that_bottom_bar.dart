import 'package:e_commerce/components/thatbottombar/that_bottom_bar_item.dart';
import 'package:e_commerce/components/thatbottombar/that_bottom_bar_item_widget.dart';
import 'package:flutter/material.dart';

class ThatBottomBar extends StatelessWidget {
  const ThatBottomBar({
    super.key,
    required this.items,
    required this.onChange,
    required this.selectedIndex,
    this.height = 76,
    this.color = Colors.white,
    this.borderRadius = 35.0,
    this.duration = const Duration(milliseconds: 200),
  });

  final List<ThatBottomBarItem> items;
  final Function(int) onChange;
  final double height;
  final Color color;
  final double borderRadius;
  final Duration duration;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          items.length,
          (index) => ThatBottomBarItemWidget(
            name: items[index].name,
            icon: items[index].icon,
            selected: selectedIndex == index,
            duration: duration,
            onTap: () => onChange(index),
          ),
        ),
      ),
    );
  }
}
