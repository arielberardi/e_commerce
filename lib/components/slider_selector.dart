import 'package:e_commerce/components/buttons/category_button.dart';
import 'package:flutter/material.dart';

class SliderSelector extends StatefulWidget {
  const SliderSelector({
    super.key,
    required this.items,
    required this.onSelected,
  });

  final List<String> items;
  final Function(int) onSelected;

  @override
  State<SliderSelector> createState() => _SliderSelectorState();
}

class _SliderSelectorState extends State<SliderSelector> {
  int indexSelected = 0;
  final listViewScrollController = ScrollController();

  void onTap(index) {
    setState(() => indexSelected = index);
    widget.onSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: listViewScrollController,
        itemCount: widget.items.length,
        itemBuilder: (context, index) => CategoryButton(
          name: widget.items[index],
          selected: indexSelected == index,
          onTap: () => onTap(index),
        ),
      ),
    );
  }
}
