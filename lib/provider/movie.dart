



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moviedb/api/api.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/model/Movie.dart';
import 'package:moviedb/model/credit.dart';
import 'package:moviedb/model/review.dart';
import 'package:moviedb/model/synops.dart';
import 'package:shared_preferences/shared_preferences.dart';

var movieProvider = ChangeNotifierProvider<MovieProvider>((ref) => MovieProvider(ref));


class MovieProvider extends ChangeNotifier{
  ProviderReference ref;
  String region = "IN";
  String language = "en-US";
  int page = 1;
  int nextPage = 1;
  int totalPage = 1;
  API api = API();
  Movie movie = Movie();
  List<Movie> movieList = [];
  List<Movie> similarList = [];
  MovieProvider(this.ref);
  Credits credits =Credits();
  List<Review> reviewList = [];
  Synopsis synopsis = Synopsis();
  String id = "";
  bool serviceEnabled;
  LocationPermission permission;

  getSynopsis()async{
    if(synopsis == null) {
      synopsis =Synopsis();
    }

    String url = "movie/${movie.id}?api_key=${Constants.key}&language=$language";
    var res = await api.getData("$url");
    var body = jsonDecode(res.body);
    synopsis = synopsis.fromMap(body);
    return synopsis;
  }

  getCredit()async{
    if(credits == null) {
      credits = Credits();
    }
    String url = "movie/${movie.id}/credits?api_key=${Constants.key}&language=$language";
    var res = await api.getData("$url");
    var body = jsonDecode(res.body);
    credits = credits.fromMap(body);
    return credits;
  }

  getReview()async{
    String url = "movie/${movie.id}/reviews?api_key=${Constants.key}&language=$language&page=$nextPage";
    var res = await api.getData("$url");
    var body = jsonDecode(res.body);
    totalPage = body["total_pages"];
    for(int i=0; i<body["results"].length; i++){
      Review review = Review.fromMap(body["results"][i]);
      reviewList.add(review);
    }
    return reviewList;
  }

  getSimilarMovies()async{
    String url = "movie/${movie.id}/similar?api_key=${Constants.key}&language=$language&page=$nextPage";
    var res = await api.getData("$url");
    var body = jsonDecode(res.body);
    movieList = await getMovieList(body);
    return movieList;
  }

  getNowPlaying()async{
    movieList.clear();
    String url = "movie/now_playing?api_key=${Constants.key}";
    if(language != null) {
      if(!url.endsWith("&"))
      url = url+"&" + "language=$language";
    }
    else{
      url = url + "language=$language";
    }
    if(nextPage != null) {
      !url.endsWith("&")? url = url+"&" + "page=$nextPage":url = url + "page=$nextPage";
    }

    if(region != null) {
      !url.endsWith("&") ? url = url + "&" + "region=$region" : url =  url + "region=$region";
    }

    if(url.endsWith("?")) {
      url.substring(0, url.length - 1);
    }
    if(nextPage <= totalPage){
      print("nextPage $nextPage");
      var res = await api.getData("$url");
      var body = jsonDecode(res.body);
      movieList = await getMovieList(body);
    }
    return movieList;
  }



  getGenre()async{
    var res = await api.getData("genre/movie/list?api_key=${Constants.key}&language=en-US");
    var body = jsonDecode(res.body);
    for(int i=0; i<body["genres"].length; i++){
      initSp(body["genres"][i]["id"].toString(), body["genres"][i]["name"]);
    }
    getCountryName();

    return body["genres"];
  }

  getGenreAndLoc()async{
    Map<String, dynamic> genre ;
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(!sp.containsKey("28")){
      genre = getGenre();
    }

    if(!sp.containsKey("country")){
      getCountryName();
    }

    return genre;

  }

  initSp(String id, String name)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(!sp.containsKey(id.toString()))
    sp.setString(id.toString(), name);
  }

  Future<List<Movie>>getMovieList(body)async{
    totalPage = body["total_pages"];
    for (int i = 0; i < body["results"].length; i++) {
      movie.genre = await movie.genreFromSp(body["results"][i]["genre_ids"]);
      movieList.add(Movie.fromMap(body["results"][i], movie.genre));
    }
    return movieList;
  }

  Future fetchMovieDetails()async{
    movie.synopsis = await getSynopsis();
    movie.credits = await getCredit();
    movie.reviewList = await getReview();
    movie.similarMovies = await getSimilarMovies();
}

   getCountryName() async {
     getPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first.countryName;
    await getRegion(first);
  }

  getRegion(String country)async{
    var res = await api.getData("watch/providers/regions?api_key=f68b4d828882f35d89d44484edfbf40b&language=en_US");
    var body = jsonDecode(res.body);
    for(int i=0; i<body["results"].length; i++){
      if(body["results"][i]["english_name"] == country) {
        initSp("country", body["results"][i]["english_name"]);
        initSp("reg", body["results"][i]["iso_3166_1"]);
        region = body["results"][i]["iso_3166_1"];
      }
    }
    return "Success";
  }


  Future<Position> getPermission() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // return await Geolocator.getCurrentPosition();
  }

}