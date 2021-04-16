class Credits {
  int id;
  List<Casts> casts;

  Credits({this.id, this.casts});

  fromMap(json) {
    List<Casts> list = [];
    for (int i = 0; i < json["cast"].length; i++) {
      Casts cast = Casts.fromMap(json["cast"][i]);
      list.add(cast);
    }
    id = json["id"];
    casts = list;
    Credits credits = Credits(id: id,casts: casts);
    return credits;
  }
}

class Casts {
  bool adult;
  int gender;
  int id;
  String department;
  String name;
  String ogName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  Casts(
      {this.adult,
      this.gender,
      this.id,
      this.department,
      this.name,
      this.ogName,
      this.popularity,
      this.profilePath,
      this.castId,
      this.character,
      this.creditId,
      this.order});

  factory Casts.fromMap(json) {
    return Casts(
      adult: json["adult"],
      id: json["id"],
      castId: json["cast_id"],
      character: json["character"],
      creditId: json["credit_id"],
      department: json["known_for_department"],
      gender: json["gender"],
      name: json["name"],
      ogName: json["original_name"],
      order: json["order"],
      popularity: json["popularity"],
      profilePath: json["profile_path"],
    );
  }
}
