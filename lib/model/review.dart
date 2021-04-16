class Review {
  String author;
  AuthorDetail authorDetail;
  String content;
  String id;
  String url;
  String createdAt;
  String updatedAt;

  Review(
      {this.author,
        this.authorDetail,
      this.content,
      this.id,
      this.url,
      this.createdAt,
      this.updatedAt});

  factory Review.fromMap(json) {
    return Review(
      id: json["id"],
      author: json["author"],
      authorDetail: AuthorDetail.fromMap(json["author_details"]),
      content: json["content"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      url: json["url"],
    );
  }
}

class AuthorDetail {
  String name;
  String username;
  String avatar;
  double rating;

  AuthorDetail({this.name, this.username, this.avatar, this.rating});

  factory AuthorDetail.fromMap(json) {
    return AuthorDetail(
      name: json["name"],
      username: json["username"],
      avatar: json["avatar_path"],
      rating: json["rating"],
    );
  }
}
