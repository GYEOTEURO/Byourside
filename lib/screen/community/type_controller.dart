import 'package:get/get.dart';

class CommunityTypeController extends GetxController {
  List<String>? type = [];

  void filtering(List<String>? selectedType) {
    type = selectedType;
  }
}
