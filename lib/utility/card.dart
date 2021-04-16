import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviedb/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb/model/Movie.dart';
import 'package:moviedb/utility/imageBox.dart';
import 'package:moviedb/utility/text.dart';
class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String subtitle;
  final String title;
  final double imgHeight;
  final double imgWidth;
  MovieCard({this.imageUrl, this.subtitle, this.title,this.imgHeight, this.imgWidth});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          imageUrl == null?
          Container(
            width:  imgWidth?? 1.sw,
            height:imgHeight?? 0.25.sh,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              shape: BoxShape.rectangle,
            ),
            child:  Image.asset("asset/noimg.png"),
          )
         : CachedNetworkImage(
            imageUrl: Constants.imageAPI+imageUrl,
            width: imgWidth ?? 1.sw,
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) =>
                Container(
                  width:  imgWidth?? 1.sw,
                  height:imgHeight?? 0.25.sh,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            placeholder: (context, url) =>
                Container(
                    width:  imgWidth?? 1.sw,
                    height:imgHeight?? 0.25.sh,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(child: CupertinoActivityIndicator())),
            errorWidget: (context, url, error) =>
                Icon(Icons.error),
          ),

          MovieTitle(title: title,),
          MovieSubTitle(title: subtitle)
        ],
      ),
    );
  }
}


class MovieDetailCard extends StatelessWidget {
  Movie movie;
  final String imageUrl;
  MovieDetailCard({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 0.15.sh,
      child: Column(
        children: [
          imageUrl == null?
          Container(
            width:  1.sw,
            height: 0.25.sh,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              shape: BoxShape.rectangle,
            ),
            child:  Image.asset("asset/noimg.png"),
          )
              : CachedNetworkImage(
            imageUrl: Constants.imageAPI+imageUrl,
            width: 1.sw,
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) =>
                Container(
                  width:  1.sw,
                  height: 0.25.sh,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            placeholder: (context, url) =>
                Center(child: Container(
                    width:  1.sw,
                    height: 0.25.h,
                    child: Center(child: CupertinoActivityIndicator()))),
            errorWidget: (context, url, error) =>
                Icon(Icons.error),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MovieSubTitle(title:"Language"),
                  MovieTitle(title: movie.ogLanguage,)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MovieSubTitle(title: "Popularity",),
                  RatingBar.builder(
                    initialRating: movie.popularity,
                    minRating: 1,
                    updateOnDrag: false,
                    tapOnlyMode: false,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },

                  )],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MovieSubTitle(),
                  MovieTitle()
                ],
              ),

            ],
          )
        ],
      ),
    );
  }
}


class PaginationCard extends StatelessWidget {
  final int page;
  final bool isActive;
  PaginationCard({this.isActive, this.page});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.08.sh,
      width: 0.1.sh,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text("$page",style: TextStyle(
          fontSize: 15.sp,
          fontWeight: isActive? FontWeight.w800 : FontWeight.normal,
          color: isActive? Colors.black : Constants.activeGrey
        ),),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String image;
  final String name;
  final String review;
  ReviewCard({this.review, this.image, this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            leading: ImageBox(imagePath: image,),
            title: MovieSubTitle(title: name,),
            subtitle: MovieTitle(
              title: review,
            ),
          ),
        ),
      ),
    );
  }
}

