import 'package:flutter/material.dart';

class RattinCheckbox extends StatelessWidget {
  const RattinCheckbox({
    super.key,
    required this.number,
    required this.value,
    required this.onChanged,
  });

  final int number;
  final bool value;
  final Function(bool?) onChanged;

  Widget getCheckBoxIcon() {
    if (value) {
      return const Icon(Icons.check_circle, color: Colors.black);
    }

    return Icon(Icons.circle, color: Colors.grey[300]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: List.generate(
                number,
                (index) => Icon(
                  Icons.star_rate_rounded,
                  color: Colors.yellow[700],
                ),
              ),
            ),
            getCheckBoxIcon(),
          ],
        ),
      ),
    );
  }
}
