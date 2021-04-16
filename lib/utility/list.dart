
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/model/Movie.dart';
import 'package:moviedb/utility/card.dart';



class NowPlayingMovieGridView extends StatefulWidget {
  final List<Movie> movies;
  final dynamic onTap;
  NowPlayingMovieGridView({this.movies, this.onTap});
  @override
  _NowPlayingMovieGridViewState createState() => _NowPlayingMovieGridViewState();
}

class _NowPlayingMovieGridViewState extends State<NowPlayingMovieGridView> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels ==
          controller.position.maxScrollExtent) {
           widget.onTap();
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification){
        if (notification is ScrollEndNotification) {
          // movie.nextPage +=1;
         print("End");
         widget.onTap();
          return true;
        }
        return false;
      },
      child: GridView.builder(
        shrinkWrap: true,
        controller: controller,
        semanticChildCount: 2,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0.01.sh,
            crossAxisSpacing: 0.02.sw,
            crossAxisCount: 2,
            // childAspectRatio: 0.2.sw/0.125.sh
            mainAxisExtent: 0.32.sh
        ),
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.movies.length, itemBuilder: (BuildContext context, int i) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: MovieCard(
              imageUrl: widget.movies[i].posterPath,
              title: widget.movies[i].title,
              subtitle: widget.movies[i].genre
          ),
        );
      },
      ),
    );
  }
}
