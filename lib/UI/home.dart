import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/utility/screen.dart';
import 'package:moviedb/utility/tab.dart';
import 'package:moviedb/utility/text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isActive = true;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Row(
            children: [
              AppBarTitle(
                title: "MOVIES",
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size(1.sw, 0.05.sh),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Constants.activeTab),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TabBarButton(
                        onTap: () {
                          if (!isActive) {
                            setState(() {
                              isActive = !isActive;
                            });
                          }
                        },
                        isActive: isActive,
                        text: "Now Showing",
                      ),
                    ),
                    Expanded(
                      child: TabBarButton(
                        onTap: () {
                          if (isActive)
                            setState(() {
                              isActive = !isActive;
                            });
                        },
                        isActive: !isActive,
                        text: "Coming Soon",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Consumer(
            builder: (BuildContext context, watch, Widget child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  MovieList()
                ],
              );
            },
          ),
        ));
  }
}
