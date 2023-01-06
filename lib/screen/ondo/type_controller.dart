import 'package:get/get.dart';

class OndoTypeController extends GetxController {
  List<String>? type = ["발달장애", "뇌병변장애"].obs;

  void filtering(List<String>? selectedType) {
    // [] 일 때도 모두 선택해서 보내기
    // if (selectedType != null) {
    //   type = selectedType;
    // } else {
    //   type = ["발달장애", "뇌병변장애"];
    // }
    type = selectedType;
  }
}
