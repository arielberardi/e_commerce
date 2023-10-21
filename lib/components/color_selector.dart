import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({
    super.key,
    required this.colors,
    required this.onChange,
  });

  final Map<String, int> colors;
  final Function(String) onChange;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  int currentColor = 1;

  void onPageChanged(int index, _) {
    setState(() => currentColor = index);
    widget.onChange(widget.colors.entries.elementAt(index).key);
  }

  Widget generateCheckMark(int index, int value) {
    if (currentColor != index) {
      return Container();
    }

    Color defaultColor = Colors.white;
    if (Color(value) == defaultColor) {
      defaultColor = Colors.black;
    }

    return Icon(Icons.check, color: defaultColor, size: 15);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 120,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: CarouselSlider(
        items: List.generate(widget.colors.length, (index) {
          final entry = widget.colors.entries.elementAt(index);

          return Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(entry.value),
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            child: generateCheckMark(index, entry.value),
          );
        }),
        options: CarouselOptions(
          initialPage: 1,
          viewportFraction: 0.35,
          onPageChanged: onPageChanged,
        ),
      ),
    );
  }
}
