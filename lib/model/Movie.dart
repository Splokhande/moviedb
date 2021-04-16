import 'package:moviedb/model/credit.dart';
import 'package:moviedb/model/review.dart';
import 'package:moviedb/model/synops.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Movie {
  bool adult;
  String backdropPath;
  List<dynamic> genreId;
  String genre;
  int id;
  String ogLanguage;
  String ogTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  Synopsis synopsis;
  Credits credits;
  List<Review> reviewList;
  List<Movie> similarMovies;
  Movie(
      {this.adult,
      this.backdropPath,
      this.genreId,
      this.genre,
      this.id,
      this.ogLanguage,
      this.ogTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.synopsis,
      this.voteCount});

  factory Movie.fromMap(Map<String, dynamic> json, String genre) {

    return Movie(
      id: json["id"],
      title: json["title"],
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreId: json["genre_ids"],
      ogLanguage: json["original_language"],
      ogTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      video: json["video"],
      voteAverage:(json["vote_average"].toDouble()),
      voteCount: json["vote_count"],
      genre: genre
    );
  }

  Future<String> genreFromSp(List<dynamic> key)async{
    String genre = ",";
    SharedPreferences sp =await SharedPreferences.getInstance();
    for(int i=0; i<key.length;i++){
      genre = genre+", "+sp.getString(key[i].toString());
    }
    if(genre.length >3) {
      genre = genre.substring(3);
    }else{
      genre = "";
    }
    return genre;
  }

}
