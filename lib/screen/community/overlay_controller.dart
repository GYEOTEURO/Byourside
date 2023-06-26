import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverlayController extends GetxController {
  OverlayEntry? overlayEntry;

  void controlOverlay(entry) {
    if(overlayEntry != null && entry == null){
      overlayEntry!.remove();
    }
    overlayEntry = entry;
  }
}
