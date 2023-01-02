import 'package:get/get.dart';

class OndoTypeController extends GetxController {
  List<String> type = ["발달장애", "뇌병변장애"].obs;

   void filtering(String? selectedType) {
      if(selectedType != null) { type = [selectedType]; }
      else { type = ["발달장애", "뇌병변장애"]; }
   }

}