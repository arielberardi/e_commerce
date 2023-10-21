import 'package:flutter/material.dart';
import 'package:e_commerce/components/page_indicator_dots.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentIndex = 0;
  final pageViewController = PageController();

  int getCurrentIndex() {
    if (widget.imageUrls.length <= 1) {
      return 0;
    }

    return pageViewController.page!.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: pageViewController,
          scrollDirection: Axis.horizontal,
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index) => Image.network(
            widget.imageUrls[index],
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 100,
          left: 150,
          right: 150,
          child: PageIndicatorDots(
            length: widget.imageUrls.length,
            currentIndex: getCurrentIndex(),
          ),
        )
      ],
    );
  }
}
