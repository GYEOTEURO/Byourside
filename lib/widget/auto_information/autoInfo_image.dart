import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AutoInfoImage extends StatefulWidget {
  const AutoInfoImage({super.key, required this.imageUrls});

  final List<String> imageUrls;
  @override
  State<AutoInfoImage> createState() => _AutoInfoImageState();
}

class _AutoInfoImageState extends State<AutoInfoImage> {
  List<String>? _downloadUrls;

  @override
  void initState() {
    super.initState();
    _downloadImage(widget.imageUrls);
  }

  Future<void> _downloadImage(List<String> imageUrls) async {
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
    _downloadUrls = downloadUrls;
  }

  @override
  Widget build(BuildContext context) {
    if (_downloadUrls != null) {
      return Image.network(_downloadUrls![0], fit: BoxFit.fill);
    } else {
      return const CircularProgressIndicator();
    }
  }
}
