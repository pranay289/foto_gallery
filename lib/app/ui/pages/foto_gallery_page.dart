// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:foto_gallery/app/ui/widgets/foto_gallery_hero_widget.dart';

//This widget is present in the Listview of the last section of University-Info_page and it contains the actual Image
// ignore: must_be_immutable
class FotoGallery extends StatelessWidget {
  int index;
  List<String> imageList;
  String image;
  FilterQuality filterQuality;
  ImageFrameBuilder? frameBuilder;
  String? semanticLabel;
  ImageErrorWidgetBuilder? errorWidgetBuilder;
  bool excludeFromSemantics;
  double? width;
  double? height;
  Animation<double>? opacity;
  BlendMode? blendMode;
  Color? color;
  BoxFit? fit;
  Alignment alignment;
  ImageRepeat imageRepeat;
  Rect? centerSlice;
  bool matchTextDirection;
  bool gaplessPlayback;
  bool isAntiAlias;
  int? cacheHeight;
  int? cacheWidth;
  ImageLoadingBuilder? loadingBuilder;
  Map<String, String>? headers;
  String imgurl;
  double scale;
  FotoGallery(
      {Key? key,
      required this.image,
      required this.imageList,
      required this.index,
      this.filterQuality = FilterQuality.low,
      this.frameBuilder,
      this.errorWidgetBuilder,
      this.semanticLabel,
      this.excludeFromSemantics = false,
      this.width,
      this.height,
      this.color,
      this.opacity,
      this.blendMode,
      this.fit,
      this.alignment = Alignment.center,
      this.imageRepeat = ImageRepeat.noRepeat,
      this.matchTextDirection = false,
      this.gaplessPlayback = false,
      this.centerSlice,
      this.isAntiAlias = false,
      this.cacheHeight,
      this.cacheWidth,
      this.headers,
      this.loadingBuilder,
      this.scale = 1.0,
      required this.imgurl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                opaque: false,
                maintainState: true,
                pageBuilder: (__, _, ____) => FotoHeroWidget(
                      selectedImageIndex: index,
                      imageList: imageList,
                      image: image,
                    )));
      },
      child: Image.network(
        imgurl,
        fit: fit,
        frameBuilder: frameBuilder,
        errorBuilder: errorWidgetBuilder,
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
        width: width,
        height: height,
        color: color,
        opacity: opacity,
        colorBlendMode: blendMode,
        alignment: alignment,
        repeat: imageRepeat,
        centerSlice: centerSlice,
        matchTextDirection: matchTextDirection,
        gaplessPlayback: gaplessPlayback,
        isAntiAlias: isAntiAlias,
        filterQuality: filterQuality,
        cacheHeight: cacheHeight,
        cacheWidth: cacheWidth,
        headers: headers,
        key: key,
        loadingBuilder: loadingBuilder,
        scale: scale,
      ),
    );
  }
}
