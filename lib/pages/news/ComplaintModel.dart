
class ComplaintModel {
  int id=0;
  String dateDecl="";
  String content="";
  String title="";
  double? longitude;
  String photoUri="";

  double? latitude;
  String adresse="";
  String categ="";
  List? listEtat;

  ComplaintModel(
      {required this.id,
        required this.dateDecl,
        required this.content,
        required this.title,
        this.longitude,
        this.latitude,
        required this.adresse,
        required this.categ});

  ComplaintModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateDecl = json['dateDecl'];
    content = json['content'];
    title = json['title'];
    longitude = json['longitude'];
    photoUri = json['photoUri'];
    latitude = json['latitude'];
    adresse = json['adresse'];
    categ = json['categ'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dateDecl'] = this.dateDecl;
    data['content'] = this.content;
    data['title'] = this.title;
    data['photoUri'] = this.photoUri;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['adresse'] = this.adresse;
    data['categ'] = this.categ;
    return data;
  }
}

class Photo {
  String? id;
  String? name;
  String? type;
  Null? declaration;
  String data="";

  Photo({this.id, this.name, this.type, this.declaration, required this.data});

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
