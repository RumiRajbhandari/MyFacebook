class User {
  int id;
  String name;
  String imageUrl;

  User({this.id, this.name, this.imageUrl});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        imageUrl = json['imageUrl'];
}
