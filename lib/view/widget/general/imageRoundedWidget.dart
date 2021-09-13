import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class ImageRoundedWidget extends StatelessWidget {
  String img;
  double height;
  double width;
  BoxFit fit;

  ImageRoundedWidget({this.img,this.height,this.width,this.fit});


  @override
  Widget build(BuildContext context) {
    return Image.network(
      img,
      height: height,
      width: width,
      fit: fit,
      filterQuality: FilterQuality.high,
      errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
        return Image.asset(GeneralString.imgLocal+"logo.png",width: width,height: height,);
      },
      frameBuilder: (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          child: child,
          opacity: 1,
          duration: const Duration(seconds: 3),
          curve: Curves.easeOut,
        );
      },
      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null ?
          loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes: null,
        );
      },
    );
  }
}
