import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as custom_icons;

class AutoInfoImage extends StatefulWidget {
  const AutoInfoImage({super.key, required this.imageUrls});

  final List<String> imageUrls;
  @override
  State<AutoInfoImage> createState() => _AutoInfoImageState();
}

class _AutoInfoImageState extends State<AutoInfoImage> {
  List<String>? _downloadUrls;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _downloadImage(widget.imageUrls);
  }

  Future _downloadImage(List<String> imageUrls) async {
    List<String> downloadUrls = [];
    for (String imageUrl in imageUrls) {
      Reference storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
      debugPrint('*****************$storageRef');

      try {
        String downloadUrl = await storageRef.getDownloadURL();
        downloadUrls.add(downloadUrl);
      } catch (e) {
        debugPrint('****************Error downloading image: $e');
      }
    }
    setState(() {
      _downloadUrls = downloadUrls;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_downloadUrls != null) {
      return Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            CarouselSlider(
                items: List.generate(_downloadUrls!.length, (index) {
                  return Container(
                      child: Semantics(
                          label: widget.imageUrls[index],
                          child: Image.network(
                            _downloadUrls![0],
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.width,
                          )));
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
            if (_downloadUrls!.isNotEmpty)
              Semantics(
                label: '현재 보이는 사진 순서 표시',
                child: Container(
                    alignment: Alignment.bottomCenter,
                    child: CarouselIndicator(
                      count: _downloadUrls!.length,
                      index: _current,
                      color: Colors.white30,
                      activeColor: colors.primaryColor,
                    )),
              ),
          ]));
    } else {
      return const CircularProgressIndicator();
    }
  }
}
