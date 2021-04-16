import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/model/Movie.dart';
import 'package:moviedb/provider/movie.dart';
import 'package:moviedb/utility/imageBox.dart';
import 'package:moviedb/utility/screen.dart';
import 'package:moviedb/utility/text.dart';

class MovieDetailScreen extends StatefulWidget {
  Movie movie;

  MovieDetailScreen({this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: AppBarTitle(
            title: widget.movie.title,
          ),
          leading: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
            size: 15.sp,
          ),
        ),
        body: Consumer(
          builder: (BuildContext context,
              T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
            var movie = watch(movieProvider);
            return FutureBuilder(
                future: movie.fetchMovieDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (movie.movieList.length > 0) {
                      return Container(
                        height: 1.sh,
                        width: 1.sw,
                        color: Theme.of(context).backgroundColor,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,

                          children: [
                            Container(
                              height: 0.65.sh,
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      // movie.movie.backdropPath == null
                                      //     ? Container(
                                      //         width: 1.sw,
                                      //         height: 0.25.sh,
                                      //         decoration: BoxDecoration(
                                      //           borderRadius:
                                      //               BorderRadius.circular(5),
                                      //           shape: BoxShape.rectangle,
                                      //         ),
                                      //         child: Image.asset(
                                      //             "asset/noimg.png"),
                                      //       )
                                      //     : CachedNetworkImage(
                                      //         imageUrl: Constants.imageAPI +
                                      //             movie.movie.backdropPath,
                                      //         width: 1.sw,
                                      //         fit: BoxFit.cover,
                                      //         imageBuilder:
                                      //             (context, imageProvider) =>
                                      //                 Container(
                                      //           width: 1.sw,
                                      //           height: 0.25.sh,
                                      //           decoration: BoxDecoration(
                                      //             // borderRadius: BorderRadius.circular(5),
                                      //             shape: BoxShape.rectangle,
                                      //             image: DecorationImage(
                                      //               image: imageProvider,
                                      //               fit: BoxFit.cover,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         placeholder: (context, url) =>
                                      //             Container(
                                      //                 width: 1.sw,
                                      //                 height: 0.25.sh,
                                      //                 decoration: BoxDecoration(
                                      //                   borderRadius:
                                      //                       BorderRadius
                                      //                           .circular(5),
                                      //                   shape:
                                      //                       BoxShape.rectangle,
                                      //                 ),
                                      //                 child: Center(
                                      //                     child:
                                      //                         CupertinoActivityIndicator())),
                                      //         errorWidget:
                                      //             (context, url, error) =>
                                      //                 Icon(Icons.error),
                                      //       ),
                                      ImageBox(imagePath: movie.movie.backdropPath ,),
                                      Positioned(
                                          bottom: 10,
                                          right: 10,
                                          child: Row(
                                            children: [
                                              Text(
                                                "${movie.movie.genre}      ${movie.movie.synopsis.runTime} Minutes",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w800,
                                                    color: Theme.of(context)
                                                        .backgroundColor),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 1.sw,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [

                                        SizedBox(
                                          width:0.3.sw,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                               // SizedBox(
                                              //   height: 0.01.sh,
                                              // ),
                                              ImageBox(imagePath: movie.movie.posterPath,width: 0.3.sw,height: 0.25.sh ,customFit: BoxFit.fitHeight,),
                                              MovieSubTitle(title: "${movie.movie.title}"),
                                              MovieSubTitle(title: "Language: ${ movie.movie.ogLanguage. toUpperCase()}"),




                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 0.01.sw,),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [


                                            MovieSubTitle(title:"Overview"),
                                            SizedBox(
                                              width: 0.55.sw,
                                              child: ExpandableText(
                                                movie.movie.overview,
                                                maxLines: 6,
                                                expandText: 'show more',
                                                collapseText: 'show less',
                                                linkColor: Colors.blue,

                                                style: TextStyle(
                                                  fontSize: 15.sp
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 0.01.sh,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    MovieSubTitle(
                                                      title: "Popularity",
                                                    ),

                                                    RatingBar.builder(
                                                      initialRating:
                                                      movie.movie.popularity,
                                                      minRating: 1,
                                                      updateOnDrag: false,
                                                      tapOnlyMode: false,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 12.sp,
                                                      // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                      itemBuilder: (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 5,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width: 0.15.sw,),
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    MovieTitle(
                                                      title: "Genre",
                                                    ),

                                                    SizedBox(
                                                      width: 0.3.sw,
                                                      child: ExpandableText(
                                                        movie.movie.genre,
                                                        maxLines: 5,
                                                        expandText: 'show more',
                                                        collapseText: 'show less',
                                                        linkColor: Colors.blue,
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w800,
                                                            color: Constants.titleGrey
                                                        ),
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 0.01.sh,),
                                            Row(
                                              children: [

                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    MovieSubTitle(
                                                      title: "Critic's ratings",
                                                    ),
                                                    RatingBar.builder(
                                                      initialRating:
                                                      movie.movie.popularity,
                                                      minRating: 1,
                                                      updateOnDrag: false,
                                                      tapOnlyMode: false,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 12.sp,
                                                      // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                      itemBuilder: (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 5,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width: 0.1.sw,),
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    MovieTitle(
                                                      title: "Duration",
                                                    ),
                                                    MovieTitle(
                                                      title: "${movie.synopsis.runTime} Minutes",
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),


                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text("Cast", style: TextStyle(
                                    color: Constants.darkGrey,
                                    fontWeight: FontWeight.bold, fontSize: 15.sp
                                ),),

                                  Container(
                                    height: 0.22.sh,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: movie.credits.casts.length,
                                        itemBuilder: (_,i){
                                            return SizedBox(
                                              width: 0.35.sw,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  ImageBox(
                                                    customFit: BoxFit.fill,
                                                    width: 0.3.sw,
                                                    height: 0.12.sh,
                                                    imagePath:movie.credits.casts[i].profilePath ,
                                                  ),
                                                  Expanded(
                                                    child: Column(

                                                      children: [
                                                        Text(" ${movie.credits.casts[i].department}"),
                                                        Text("${movie.credits.casts[i].name}",maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                      // Text("Original Name: ${movie.credits.casts[i].ogName}"),

                                                        Expanded(child: Text("As ${movie.credits.casts[i].character}")),
                                                    ],),
                                                  )
                                                ],
                                              ),
                                            );
                                    }),
                                  )

                                ],
                              ),
                            ),

                          Container(
                            height: 0.4.sh,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Similar Movies", style: TextStyle(
                            color: Constants.darkGrey,
                                fontWeight: FontWeight.bold, fontSize: 15.sp
                            ),),
                                SizedBox(
                                  width: 0.8.sw,
                                  child: Divider(
                                    thickness: 0.2,
                                    color: Constants.activeGrey,
                                  ),
                                ),

                                HoriontalMovieList(),
                              ],
                            ),
                          ),
                          Container(
                            height: 0.8.sh,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Reviews", style: TextStyle(
                            color: Constants.darkGrey,
                                fontWeight: FontWeight.bold, fontSize: 15.sp
                            ),),
                                SizedBox(
                                  width: 0.8.sw,
                                  child: Divider(
                                    thickness: 0.2,
                                    color: Constants.activeGrey,
                                  ),
                                ),

                               ReviewList(),
                              ],
                            ),
                          ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(
                          height: 0.1.sh,
                          width: 0.5.sw,
                          child: AlertDialog(
                            content: Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: Container(
                        height: 0.1.sh,
                        width: 0.5.sw,
                        child: AlertDialog(
                          content: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                      ),
                    );
                  }
                });
          },
        ));
  }
}
