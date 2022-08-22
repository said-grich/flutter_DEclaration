class UserModel {
  int? id;
  String? email;
  bool? active;
  String? password;
  String? nom;
  String? prenom;
  String? role;
  String? cin;
  String? telephone;
  String? imm;

  UserModel({
    this.id,
    this.email,
    this.active,
    this.password,
    this.nom,
    this.prenom,
    this.role,
    this.cin,
    this.telephone,
    this.imm,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
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
