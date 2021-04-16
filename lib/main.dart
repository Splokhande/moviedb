import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moviedb/UI/splashScreen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => MaterialApp(
        title: 'Movie DB',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: MaterialColor(0xFFfc335a, {
              50:Color.fromRGBO(252, 51, 90, .1),
              100:Color.fromRGBO(252, 51, 90, .2),
              200:Color.fromRGBO(252, 51, 90, .3),
              300:Color.fromRGBO(252, 51, 90, .4),
              400:Color.fromRGBO(252, 51, 90, .5),
              500:Color.fromRGBO(252, 51, 90, .6),
              600:Color.fromRGBO(252, 51, 90, .7),
              700:Color.fromRGBO(252, 51, 90, .8),
              800:Color.fromRGBO(252, 51, 90, .9),
              900:Color.fromRGBO(252, 51, 90, 1),
            }
          ),
          primaryColor: Color(0xFFfc335a),
          backgroundColor: Colors.white,
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home:SplashScreen(),
      ),
    );
  }
}
