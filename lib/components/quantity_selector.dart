import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.value,
    required this.onChange,
    this.min = 1,
    this.max,
  });

  final int value;
  final Function(int) onChange;
  final int min;
  final int? max;

  void onIncrement() {
    if (max == null || value < max!) {
      onChange(value + 1);
    }
  }

  void onDecrement() {
    if (value > min) {
      onChange(value - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: Text('-', style: Theme.of(context).textTheme.labelLarge),
          ),
          SizedBox(
            width: 20,
            child: Center(
              child: Text(
                '$value',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
          GestureDetector(
            onTap: onIncrement,
            child: Text('+', style: Theme.of(context).textTheme.labelLarge),
          ),
        ],
      ),
    );
  }
}
