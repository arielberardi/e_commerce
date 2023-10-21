import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RattingStars extends StatelessWidget {
  const RattingStars({
    super.key,
    required this.ratting,
    required this.reviews,
    this.size = 15,
  });

  final double ratting;
  final int reviews;
  final double size;

  IconData getIconFromRatting(int value) {
    if (ratting >= value) {
      return Icons.star_rate_rounded;
    } else if (ratting < value && ratting > (value - 1)) {
      return Icons.star_half_rounded;
    }

    return Icons.star_border_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(getIconFromRatting(1), color: Colors.yellow[700], size: size),
        Icon(getIconFromRatting(2), color: Colors.yellow[700], size: size),
        Icon(getIconFromRatting(3), color: Colors.yellow[700], size: size),
        Icon(getIconFromRatting(4), color: Colors.yellow[700], size: size),
        Icon(getIconFromRatting(5), color: Colors.yellow[700], size: size),
        const SizedBox(width: 5),
        Text(
          'component.ratting_stars.body'.tr(args: [reviews.toString()]),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
        ),
      ],
    );
  }
}
