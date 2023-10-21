import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({
    super.key,
    required this.sizes,
    required this.onSelected,
  });

  final List<String> sizes;
  final Function(String) onSelected;

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selectedIndex = 1;

  void onPageChanged(int index, _) {
    setState(() => selectedIndex = index);
    widget.onSelected(widget.sizes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 45,
      child: CarouselSlider(
        items: List.generate(
          widget.sizes.length,
          (index) => SelectorCircle(
            widget.sizes[index],
            selected: index == selectedIndex,
          ),
        ),
        options: CarouselOptions(
          initialPage: 1,
          viewportFraction: 0.35,
          onPageChanged: onPageChanged,
        ),
      ),
    );
  }
}

class SelectorCircle extends StatelessWidget {
  const SelectorCircle(this.body, {super.key, required this.selected});

  final String body;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 0.75),
        color: selected ? Colors.black : Colors.transparent,
      ),
      child: Center(
        child: Text(
          body,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.grey,
              ),
        ),
      ),
    );
  }
}
