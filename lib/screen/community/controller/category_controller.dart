import 'package:get/get.dart';

class CommunityCategoryController extends GetxController {
  String? category;

  void changeCategory(String? selectedCategory) {
    category = selectedCategory;
  }
}
