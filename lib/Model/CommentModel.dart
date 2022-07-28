import 'package:untitled/Model/UserModel.dart';

class CommentModel {
  int? idComment;
  User user= new User();
  String comment="";
  String? date;
  CommentModel({this.idComment, this.date});
  CommentModel.fromJson(Map<String, dynamic> json) {
    idComment = json['idComment'];
    user = new User.fromJson(json['user']) ;
    comment = json['comment'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idComment'] = this.idComment;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['comment'] = this.comment;
    data['date'] = this.date;
    return data;
  }
}

class User {
  int? id;
  String? email;
  bool? active;
  String? password;
  String nom="";
  String prenom="";
  String? role;
  String? cin;
  String? telephone;
  Null? imm;

  User(
      {this.id,
        this.email,
        this.active,
        this.password,
        this.role,
        this.cin,
        this.telephone,
        this.imm});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    active = json['active'];
    password = json['password'];
    nom = json['nom'];
    prenom = json['prenom'];
    role = json['role'];
    cin = json['cin'];
    telephone = json['telephone'];
    imm = json['imm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['active'] = this.active;
    data['password'] = this.password;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['role'] = this.role;
    data['cin'] = this.cin;
    data['telephone'] = this.telephone;
    data['imm'] = this.imm;
    return data;
  }
}
