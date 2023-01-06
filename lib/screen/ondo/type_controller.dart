import 'package:get/get.dart';

class OndoTypeController extends GetxController {
  List<String>? type = [];

  void filtering(List<String>? selectedType) {
    type = selectedType;
  }
}
