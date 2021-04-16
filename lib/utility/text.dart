
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb/constants.dart';
class AppBarTitle extends StatelessWidget {
  final String title;
  AppBarTitle({this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
       color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold, fontSize: 15.sp
    ),);
  }
}

class ActiveTabText extends StatelessWidget {
  final String title;
  ActiveTabText({this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title, style: TextStyle(
        color: Constants.activeGrey,
        fontWeight: FontWeight.w700,
        fontSize: 12.sp
    ),);
  }
}

class InActiveTabText extends StatelessWidget {
  final String title;
  InActiveTabText({this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
        color: Constants.inactiveGrey,
        fontWeight: FontWeight.w700,
         fontSize: 12.sp
    ),);
  }
}

class MovieTitle extends StatelessWidget {
  final String title;
  MovieTitle({this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
        color: Constants.titleGrey,
        fontSize: 12.sp
    ),
      maxLines: 1,
      softWrap: true,
      overflow: TextOverflow.ellipsis,

    );
  }
}

class MovieSubTitle extends StatelessWidget {
  final String title;
  MovieSubTitle({this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
        color: Constants.darkGrey,
        fontWeight: FontWeight.bold, fontSize: 12.sp
    ),
    );
  }
}



