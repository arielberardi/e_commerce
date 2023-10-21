import 'package:flutter/material.dart';

class ThatBottomBarItemWidget extends StatelessWidget {
  const ThatBottomBarItemWidget({
    super.key,
    required this.icon,
    required this.name,
    required this.onTap,
    this.selected = false,
    required this.duration,
  });

  final IconData icon;
  final String name;
  final VoidCallback onTap;
  final bool selected;
  final Duration duration;

  Widget createText(BuildContext context) {
    final Widget textContainer = Container(
      padding: const EdgeInsets.fromLTRB(35.0, 5.0, 10.0, 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Text(
        name,
        textAlign: TextAlign.end,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );

    return AnimatedSize(
      duration: duration,
      curve: Curves.linear,
      alignment: Alignment.topRight,
      child: selected ? textContainer : const SizedBox(height: 56),
    );
  }

  Widget createIcon() {
    return AnimatedContainer(
      duration: duration,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Icon(
        icon,
        color: selected ? Colors.white : Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          createText(context),
          createIcon(),
        ],
      ),
    );
  }
}
