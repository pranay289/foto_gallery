// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:foto_gallery/app/controllers/foto_gallery_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class FotoHeroWidget extends StatefulWidget {
  int selectedImageIndex;
  List<String> imageList;
  String image;

  FotoHeroWidget({
    Key? key,
    required this.image,
    required this.imageList,
    required this.selectedImageIndex,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<FotoHeroWidget> createState() => _FotoHeroWidgetState();
}

class _FotoHeroWidgetState extends State<FotoHeroWidget> {
  // To get instance of controller.
  FotoGalleryController fotoGalleryController =
      Get.put(FotoGalleryController());
  @override
  void initState() {
    super.initState();
    fotoGalleryController.listIndex.value = widget.selectedImageIndex;
    // image = Get.parameters['url'];
    if (widget.imageList.isNotEmpty) {
      fotoGalleryController.imageList.value = widget.imageList;
    } else {
      fotoGalleryController.imageList.value = [];
    }
    //for keyboard focus
    WidgetsBinding.instance?.addPostFrameCallback(
        (_) => FocusScope.of(context).requestFocus(_focusNode));
  }

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double screensizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.9),
        body: screensizeWidth > 800
            ? RawKeyboardListener(
                focusNode: _focusNode,
                onKey: _handleKeyEvent,
                child: Obx(
                  () => Stack(children: [
                    Positioned(
                        top: 20,
                        left: 20,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            child: const Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 35,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        )),
                    Hero(
                      tag: widget.image,
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: double.infinity,
                            maxHeight: double.infinity,
                          ),
                          child: InteractiveViewer(
                            minScale: 0.5,
                            maxScale: 2,
                            child: Image.network(
                              fotoGalleryController.imageList[
                                  fotoGalleryController.listIndex.value],
                              width: screensizeWidth / 1.5,
                              height: 700,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: fotoGalleryController.listIndex.value != 0
                          ? MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  fotoGalleryController.moveBackward();
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withAlpha(128),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      height: 35,
                                      width: 35,
                                      child: const Center(
                                        child: Icon(
                                          Icons.navigate_before,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              ),
                            )
                          : const SizedBox(),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: fotoGalleryController.listIndex.value !=
                              fotoGalleryController.imageList.length - 1
                          ? MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  fotoGalleryController.moveForward();
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withAlpha(128),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      height: 35,
                                      width: 35,
                                      child: const Center(
                                        child: Icon(
                                          Icons.navigate_next,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ]),
                ),
              )
            : MobileFotoHeroWidget(
                image: widget.image,
                selectedImageIndex: widget.selectedImageIndex,
                imageList: widget.imageList,
              ));
  }

  //These boolean variables are to know if the button is pressed or released
  //We are using this because flutter calls the below function 2 times on one button press
  //and we want to execute code only when the button is pressed and not released
  bool rightPressed = false;
  bool leftPressed = false;
  bool escapePressed = false;
  void _handleKeyEvent(RawKeyEvent event) {
    //checking if the key pressed is Right arrow key
    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      if (!rightPressed) {
        fotoGalleryController.moveForward();
        rightPressed = true;
      } else {
        rightPressed = false;
      }
    }
    //checking if the key pressed is Left arrow key
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      if (!leftPressed) {
        fotoGalleryController.moveBackward();
        leftPressed = true;
      } else {
        leftPressed = false;
      }
    }
    //checking if the key pressed is Escape key
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      if (!escapePressed) {
        Navigator.pop(context);
        escapePressed = true;
      } else {
        escapePressed = false;
      }
    }
  }
}

// ignore: must_be_immutable
class MobileFotoHeroWidget extends StatefulWidget {
  int selectedImageIndex;
  List<String>? imageList;
  String image;

  MobileFotoHeroWidget(
      {Key? key,
      required this.image,
      this.imageList,
      required this.selectedImageIndex})
      : super(key: key);

  @override
  State<MobileFotoHeroWidget> createState() =>
      // ignore: no_logic_in_create_state
      _MobileFotoHeroWidgetState();
}

class _MobileFotoHeroWidgetState extends State<MobileFotoHeroWidget> {
  _MobileFotoHeroWidgetState();

  /// To get instance of fotoGalleryController
  final fotoGalleryController = Get.find<FotoGalleryController>();
  @override
  void initState() {
    super.initState();
    fotoGalleryController.listIndex.value = widget.selectedImageIndex;
    if (widget.imageList != null) {
      fotoGalleryController.imageList.value = widget.imageList!;
    } else {
      fotoGalleryController.imageList.value = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    double screensizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.9),
        body: Obx(
          () => Stack(children: [
            Positioned(
                top: 20,
                left: 20,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: const Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 35,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                )),
            Hero(
              tag: widget.image,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: screensizeWidth < 800
                        ? double.infinity
                        : screensizeWidth / 1.75,
                    maxHeight: screensizeWidth < 800
                        ? screensizeWidth / 1.75
                        : screensizeWidth / 1.75,
                  ),
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 5,
                    child: Image.network(
                      fotoGalleryController
                          .imageList[fotoGalleryController.listIndex.value],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: fotoGalleryController.listIndex.value != 0
                  ? GestureDetector(
                      onTap: () {
                        fotoGalleryController.moveBackward();
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(128),
                                borderRadius: BorderRadius.circular(50)),
                            height: 35,
                            width: 35,
                            child: const Center(
                              child: Icon(
                                Icons.navigate_before,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    )
                  : const SizedBox(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: fotoGalleryController.listIndex.value !=
                      fotoGalleryController.imageList.length - 1
                  ? GestureDetector(
                      onTap: () {
                        fotoGalleryController.moveForward();
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(128),
                                borderRadius: BorderRadius.circular(50)),
                            height: 35,
                            width: 35,
                            child: const Center(
                              child: Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    )
                  : const SizedBox(),
            ),
          ]),
        ));
  }
}
