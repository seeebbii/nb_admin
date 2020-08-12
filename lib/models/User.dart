class User{
  String id;
  String name;
  String email;
  String imageUrl;

  User(this.id, this.name, this.email, this.imageUrl);

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    email = json['email'];
    name = json['name'];
    imageUrl = json['image'];
  }
}

