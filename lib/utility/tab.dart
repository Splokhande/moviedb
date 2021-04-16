
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/utility/text.dart';

class TabBarButton extends StatelessWidget {
  final bool isActive;
  final String text;
  final Function onTap;
  TabBarButton({this.isActive,  this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
   BoxDecoration isDecorationActive =BoxDecoration(
      color: Constants.activeTab,
      borderRadius: BorderRadius.circular(10),
    );
    BoxDecoration isDecorationInactive = BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration:isActive ? isDecorationActive : isDecorationInactive,
        // width: 0.42.sw,
        height: 0.05.sh,
        child: Padding(
          padding: EdgeInsets.all(0.008.sw),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isActive ?ActiveTabText(title: text,): InActiveTabText(title: text,)
            ],
          ),
        ),
      ),
    );
  }
}