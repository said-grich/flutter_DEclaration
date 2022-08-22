
class CommentModel {
  int? idComment;
  User user = User();
  String comment = "";
  String? date;
  CommentModel({this.idComment, this.date});
  CommentModel.fromJson(Map<String, dynamic> json) {
    idComment = json['idComment'];
    user = User.fromJson(json['user']);
    comment = json['comment'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idComment'] = idComment;
    // it can't be null
    data['user'] = user.toJson();
    data['comment'] = comment;
    data['date'] = date;
    return data;
  }
}

class User {
  int? id;
  String? email;
  bool? active;
  String? password;
  String nom = "";
  String prenom = "";
  String? role;
  String? cin;
  String? telephone;

  Null imm;

  User({
    this.id,
    this.email,
    this.active,
    this.password,
    this.role,
    this.cin,
    this.telephone,
    this.imm,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['active'] = active;
    data['password'] = password;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['role'] = role;
    data['cin'] = cin;
    data['telephone'] = telephone;
    data['imm'] = imm;
    return data;
  }
}
