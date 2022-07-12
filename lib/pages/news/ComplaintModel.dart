class ComlaintModel {
  int? id;
  String? dateDecl;
  String? content;
  int? longitude;
  int? latitude;
  String? adresse;
  Null? etatD;
  Photo? photo;
  String? categ;

  ComlaintModel(
      {this.id,
        this.dateDecl,
        this.content,
        this.longitude,
        this.latitude,
        this.adresse,
        this.etatD,
        this.photo,
        this.categ});

  ComlaintModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateDecl = json['dateDecl'];
    content = json['content'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    adresse = json['adresse'];
    etatD = json['etatD'];
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    categ = json['categ'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dateDecl'] = this.dateDecl;
    data['content'] = this.content;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['adresse'] = this.adresse;
    data['etatD'] = this.etatD;
    if (this.photo != null) {
      data['photo'] = this.photo!.toJson();
    }
    data['categ'] = this.categ;
    return data;
  }
}

class Photo {
  String? id;
  String? name;
  String? type;
  Null? declaration;
  String? data;

  Photo({this.id, this.name, this.type, this.declaration, this.data});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    declaration = json['declaration'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['declaration'] = this.declaration;
    data['data'] = this.data;
    return data;
  }
}
