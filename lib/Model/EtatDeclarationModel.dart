class EtatDeclarationModel {
  int? idEtatD;
  Etat? etat;
  DateTime? dateEtat;

  EtatDeclarationModel({this.idEtatD, this.etat, this.dateEtat});

  EtatDeclarationModel.fromJson(Map<String, dynamic> json) {
    idEtatD = json['id_etatD'];
    etat = json['etat'] != null ? new Etat.fromJson(json['etat']) : null;
    dateEtat = DateTime.parse(json['dateEtat']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_etatD'] = this.idEtatD;
    if (this.etat != null) {
      data['etat'] = this.etat!.toJson();
    }
    data['dateEtat'] = this.dateEtat;
    return data;
  }
}

class Etat {
  int? idEt;
  String? libelle;

  Etat({this.idEt, this.libelle});

  Etat.fromJson(Map<String, dynamic> json) {
    idEt = json['id_et'];
    libelle = json['libelle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_et'] = this.idEt;
    data['libelle'] = this.libelle;
    return data;
  }
}
