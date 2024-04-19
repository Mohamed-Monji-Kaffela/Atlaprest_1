class Client {
  Object? id;
  String? civilite;
  String? nom;
  String? prenom;
  Object? raisonSocial;
  Object? numeroContact1;
  Object? numeroContact2;
  String? codeDepartement;

  Client({
    required this.id,
    required this.civilite,
    required this.nom,
    required this.prenom,
    required this.raisonSocial,
    required this.numeroContact1,
    required this.numeroContact2,
    required this.codeDepartement,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['_id'],
      civilite: json['Civilite'],
      nom: json['Nom'],
      prenom: json['Prenom'],
      raisonSocial: json['RaisonSocial'],
      numeroContact1: json['NumeroContact1'],
      numeroContact2: json['NumeroContact2'],
      codeDepartement: json['CodeDepartement'],
    );
  }
}