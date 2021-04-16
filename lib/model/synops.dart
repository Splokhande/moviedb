class Synopsis {
  bool adult;
  List<SpokenLanguage> language;
  int runTime;
  String releasedDate;
  String status;
  String tagline;
  int revenue;
  List<ProductionCountry> productionCountry;
  List<dynamic> productionCompany;
  String imdbId;
  List<Genres> genre;

  Synopsis(
      {this.productionCountry,
      this.language,
      this.status,
      this.adult,
      this.releasedDate,
      this.revenue,
      this.runTime,
      this.imdbId,
      this.genre,
      this.productionCompany,
      this.tagline});

  fromMap(Map<String, dynamic> json) {
    return Synopsis(
        adult: json["adult"],
        language: getSpokenLangList(json["spoken_languages"]),
        runTime: json["runtime"],
        releasedDate: json["release_date"],
        status: json["status"],
        tagline: json["tagline"],
        revenue: json["revenue"],
        productionCountry: getProductionCounntryList(json["production_countries"]),
        productionCompany: json["production_companies"],
        genre:getGenreList(json["genres"]),
        imdbId: json["imdb_id"]);
  }

  getSpokenLangList(json) {
    List<SpokenLanguage> list = [];
    for (int i = 0; i < json.length; i++) {
      list.add(SpokenLanguage(
          englishName: json[i]["isoCode"],
          isoCode: json[i]["iso_639_1"],
          name: json[i]["name"]));
    }
    return list;
  }

  getProductionCounntryList(json) {
    List<ProductionCountry> country = [];
    for (int i = 0; i < json.length; i++) {
      country.add(ProductionCountry(
        cc: json[i]["isoCode"],
        countryName: json[i]["iso_639_1"],
      ));
    }
    return country;
  }
  getGenreList(json) {
    List<Genres> genre = [];
    for (int i = 0; i < json.length; i++) {
      genre.add(
        Genres(
          id: json[i]["isoCode"],
          name: json[i]["iso_639_1"],
        )
      );
    }
    return genre;
  }
}

class ProductionCountry {
  String cc; //Country Iso Code
  String countryName;
  ProductionCountry({this.cc, this.countryName});
  factory ProductionCountry.fromMap(Map<String, dynamic> json) {
    return ProductionCountry(cc: json["iso_3166_1"], countryName: json["name"]);
  }
}

class Genres {
  int id;
  String name;

  Genres({this.id, this.name});

  factory Genres.fromMap(Map<String, dynamic> json) {
    return Genres(
      id: json["id"],
      name: json["name"],
    );
  }
}

class SpokenLanguage {
  String englishName;
  String isoCode;
  String name;

  SpokenLanguage({this.name, this.englishName, this.isoCode});

  fromMap(Map<String, dynamic> json) {}
}
