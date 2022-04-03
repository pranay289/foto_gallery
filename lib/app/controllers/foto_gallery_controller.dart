// ignore_for_file: file_names
import 'package:get/get.dart';

class FotoGalleryController extends GetxController {
  /// To get instance of FotoGalleryController.
  static final FotoGalleryController instance = Get.find();

  /// To get List of Images.
  RxList<String> imageList = RxList<String>();

  /// To get index.
  RxInt listIndex = 0.obs;

  /// To display next image till the last image Index
  void moveForward() {
    if (listIndex.value < imageList.length - 1) {
      listIndex++;
    }
  }

  /// To display previous image till the first image Index
  void moveBackward() {
    if (listIndex.value > 0) {
      listIndex--;
    }
  }
}
