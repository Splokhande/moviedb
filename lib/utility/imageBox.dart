
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb/constants.dart';

class ImageBox extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final BoxFit customFit;
  ImageBox({this.imagePath, this.width, this.height, this.customFit});

  @override
  Widget build(BuildContext context) {
    return    imagePath == null
        ? Container(
      width: width ?? 1.sw,
      height: height ?? 0.25.sh,
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(5),
        shape: BoxShape.rectangle,
      ),
      child: Image.asset(
          "asset/noimg.png"),
    )
        : CachedNetworkImage(
      imageUrl: Constants.imageAPI +
          imagePath,
      width: width ?? 1.sw,
      fit: BoxFit.cover,
      imageBuilder:
          (context, imageProvider) =>
          Container(
            width:width ??  1.sw,
            height:height ?? 0.25.sh,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(5),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: imageProvider,
                fit:  customFit ?? BoxFit.cover,
              ),
            ),
          ),
      placeholder: (context, url) =>
          Container(
              width:width ??  1.sw,
              height:height ?? 0.25.sh,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius
                    .circular(5),
                shape:
                BoxShape.rectangle,
              ),
              child: Center(
                  child:
                  CupertinoActivityIndicator())),
      errorWidget:
          (context, url, error) =>
          Icon(Icons.error),
    );
  }
}


