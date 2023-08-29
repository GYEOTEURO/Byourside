import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  ImageSlider({super.key, required this.images, required this.imgInfos});

  List<String> images;
  List<String> imgInfos;

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
                  width: MediaQuery.of(context).size.width * 0.87,
                    child: Semantics(
                        label: widget.imgInfos[index],
                        child: Image.network(widget.images[index])));
              }),
              options: CarouselOptions(
                  //height: MediaQuery.of(context).size.width * 0.87,
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
        label: '현재 보이는 사진 순서 표시',
        child: CarouselIndicator(
          count: widget.images.length,
          index: _current,
          color: Colors.black26,
          activeColor: colors.textColor,
        ),
      ),
    ]);
  }
}
