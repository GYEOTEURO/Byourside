import 'package:byourside/constants/colors.dart' as colors;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, required this.images, required this.imgInfos});

  final List<String> images;
  final List<String> imgInfos;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _current = 0; // 현재 이미지 인덱스

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
              items: List.generate(widget.images.length, (index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  //height: MediaQuery.of(context).size.width * 0.9,
                    child: Semantics(
                        label: widget.imgInfos[index],
                        child: Image.network(widget.images[index])));
              }),
              options: CarouselOptions(
                  initialPage: 0,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  aspectRatio: 2.0,
                  onPageChanged: (idx, reason) {
                    setState(() {
                      _current = idx;
                    });
                  })),
                  const SizedBox(height: 12),
      Semantics(
        label: '$_current번째 사진',
        child: DotsIndicator(
          dotsCount: widget.images.length,
          position: _current,
          decorator: const DotsDecorator(
            color: colors.bgrColor,
            activeColor: colors.textColor,
          ),
        ),
      ),
    ]);
  }
}
