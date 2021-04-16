import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moviedb/api/api.dart';

var movieDetailProvider = ChangeNotifierProvider((ref) => MovieDetailsProvider(ref));

class MovieDetailsProvider extends ChangeNotifier{
  ProviderReference ref;

  int page = 1;
  int nextPage = 1;
  int totalPage = 1;
  API api = API();
  String region = "IN";
  String language = "en-US";
  MovieDetailsProvider(this.ref);

}