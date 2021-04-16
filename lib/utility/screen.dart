
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:moviedb/UI/movieDetail.dart';
import 'package:moviedb/model/Movie.dart';
import 'package:moviedb/model/review.dart';
import 'package:moviedb/provider/movie.dart';
import 'package:moviedb/utility/card.dart';

class MovieList extends HookWidget{

  bool isActive = true;
  final PagingController<int, Movie> _pagingController =
  PagingController(firstPageKey: 1);
  List<Movie> newList = [];
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final movie = useProvider(movieProvider);
    // controller.addListener(() {
    //   if (controller.position.atEdge) {
    //     if (controller.position.pixels ==
    //         controller.position.maxScrollExtent)
    //       print('List scroll at bottom');
    //     movie.getNowPlaying();
    //   }
    // });

    _pagingController.addPageRequestListener((pageKey) async{
      try {
        newList = await movie.getNowPlaying();
        if (movie.nextPage == movie.totalPage) {
          _pagingController.appendLastPage(newList);
        } else {
          movie.nextPage =  movie.nextPage + 1;
          _pagingController.appendPage(newList, movie.nextPage );
        }
      }
      catch(e){
        _pagingController.error = e;
      }
    });

    return Container(
      height: 0.8.sh,
      child: isActive
          ? FutureBuilder(
          future: movie.getNowPlaying(),
          builder: (_, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.done) {
              if (movie.movieList.length > 0) {
                return PagedGridView(
                    pagingController: _pagingController,
                    shrinkWrap: true,

                    builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (_,item,i){
                   return Padding(
                      padding:
                      const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          movie.movie = item;
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=> MovieDetailScreen(movie: item,)));
                        },
                        child: MovieCard(
                            imageUrl: item.posterPath,
                            title: item.title,
                            subtitle: item.genre),
                      ),
                    );
                  }
                ),

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 0.01.sh,
                        crossAxisSpacing: 0.02.sw,
                        crossAxisCount: 2,
                        // childAspectRatio: 0.2.sw/0.125.sh
                        mainAxisExtent: 0.32.sh
                    ),
                );
              }
              else {
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
            }
            else {
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
          })
          : FutureBuilder(builder: (_, i) {
            return Container();
      }),
    );
  }

}
class HoriontalMovieList extends HookWidget{

  bool isActive = true;
  final PagingController<int, Movie> _pagingController =
  PagingController(firstPageKey: 1);
  List<Movie> newList = [];
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final movie = useProvider(movieProvider);
    // controller.addListener(() {
    //   if (controller.position.atEdge) {
    //     if (controller.position.pixels ==
    //         controller.position.maxScrollExtent)
    //       print('List scroll at bottom');
    //     movie.getNowPlaying();
    //   }
    // });

    _pagingController.addPageRequestListener((pageKey) async{
      try {
        newList = await movie.getNowPlaying();
        if (movie.nextPage == movie.totalPage) {
          _pagingController.appendLastPage(newList);
        } else {
          movie.nextPage =  movie.nextPage + 1;
          _pagingController.appendPage(newList, movie.nextPage );
        }
      }
      catch(e){
        _pagingController.error = e;
      }
    });

    return Container(
      height: 0.35.sh,
      child:FutureBuilder(
          future: movie.getSimilarMovies(),
          builder: (_, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.done) {
              if (movie.movieList.length > 0) {
                return PagedListView(
                    pagingController: _pagingController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (_,item,i){
                   return Padding(
                      padding:
                      const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          movie.movie = item;
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> MovieDetailScreen(movie: item,)));

                        },
                        child: MovieCard(
                            imageUrl: item.posterPath,
                            title: item.title,
                            subtitle: item.genre,
                            imgHeight: 0.2.sh,
                          imgWidth: 0.3.sw,
                        ),
                      ),
                    );
                  }
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
          }),

    );
  }

}


class ReviewList extends HookWidget{

  ReviewList();

  bool isActive = true;
  final PagingController<int, Review> _pagingController =
  PagingController(firstPageKey: 1);
  List<Review> newList = [];
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final movie = useProvider(movieProvider);
    // controller.addListener(() {
    //   if (controller.position.atEdge) {
    //     if (controller.position.pixels ==
    //         controller.position.maxScrollExtent)
    //       print('List scroll at bottom');
    //     movie.getNowPlaying();
    //   }
    // });

    _pagingController.addPageRequestListener((pageKey) async{
      try {
        newList = await movie.getReview();
        if (movie.nextPage == movie.totalPage) {
          _pagingController.appendLastPage(newList);
        } else {
          movie.nextPage =  movie.nextPage + 1;
          _pagingController.appendPage(newList, movie.nextPage );
        }
      }
      catch(e){
        _pagingController.error = e;
      }
    });

    return Container(
      height: 0.7.sh,
      child: PagedListView(
      pagingController: _pagingController,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (_,item,i){
            return Padding(
                padding:
                const EdgeInsets.all(8.0),
                child: ReviewCard(
                  image: item.authorDetail.avatar,
                  name: item.authorDetail.name,
                  review: item.content,
                )
            );
          }
      ),

      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     mainAxisSpacing: 0.01.sh,
      //     crossAxisSpacing: 0.02.sw,
      //     crossAxisCount: 2,
      //     // childAspectRatio: 0.2.sw/0.125.sh
      //     mainAxisExtent: 0.32.sh
      // ),
    )
      // FutureBuilder(
      //     future: movie.getReview(),
      //     builder: (_, snapshot) {
      //       if (snapshot.connectionState ==
      //           ConnectionState.done) {
      //         if (movie.reviewList.length > 0) {
      //           return PagedListView(
      //             pagingController: _pagingController,
      //             shrinkWrap: true,
      //             scrollDirection: Axis.vertical,
      //             builderDelegate: PagedChildBuilderDelegate(
      //                 itemBuilder: (_,item,i){
      //                   return Padding(
      //                     padding:
      //                     const EdgeInsets.all(8.0),
      //                     child: ReviewCard(
      //                       image: item.authorDetail.avatar,
      //                       name: item.authorDetail.name,
      //                       review: item.content,
      //                     )
      //                   );
      //                 }
      //             ),
      //
      //             // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //             //     mainAxisSpacing: 0.01.sh,
      //             //     crossAxisSpacing: 0.02.sw,
      //             //     crossAxisCount: 2,
      //             //     // childAspectRatio: 0.2.sw/0.125.sh
      //             //     mainAxisExtent: 0.32.sh
      //             // ),
      //           );
      //         }
      //         else {
      //           return Center(
      //             child: Container(
      //               height: 0.1.sh,
      //               width: 0.5.sw,
      //               child: AlertDialog(
      //                 content: Center(
      //                   child: CupertinoActivityIndicator(),
      //                 ),
      //               ),
      //             ),
      //           );
      //         }
      //       }
      //       else {
      //         return Center(
      //           child: Container(
      //             height: 0.1.sh,
      //             width: 0.5.sw,
      //             child: AlertDialog(
      //               content: Center(
      //                 child: CupertinoActivityIndicator(),
      //               ),
      //             ),
      //           ),
      //         );
      //       }
      //     }),

    );
  }

}