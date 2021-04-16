import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moviedb/UI/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb/provider/movie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context,
          T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
        final movie = watch(movieProvider);
        return Container(
            height: 1.sh,
            width: 1.sw,
            child: FutureBuilder(
                future: movie.getGenre(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      Timer(
                          Duration(milliseconds: 2000),
                          () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (route) => false));
                      return Container();
                    }
                    else{
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("asset/splash.png"),
                          SizedBox(
                            height: 0.05.sh,
                          ),
                          CupertinoActivityIndicator()
                        ],
                      );
                    }
                  }
                  else{
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("asset/splash.png"),
                        SizedBox(
                          height: 0.05.sh,
                        ),
                        CupertinoActivityIndicator()
                      ],
                    );
                  }

                }));
      },
    );
  }
}
