import 'package:get/get.dart';

class NanumTypeController extends GetxController {
  List<String>? type = [];

  void filtering(List<String>? selectedType) {
    type = selectedType;
  }
}
