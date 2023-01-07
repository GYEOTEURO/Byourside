import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverlayController extends GetxController {
  OverlayEntry? overlayEntry = null;

  void controlOverlay(entry) {
    if(entry == null){
      overlayEntry!.remove();
    }
    overlayEntry = entry;
  }
}