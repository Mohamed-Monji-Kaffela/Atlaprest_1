class Forfait{
  Object? statut;
  Object? valide;
  bool? appelClient;
  bool? contacterApres;

  Forfait({
    required this.statut,
    required this.valide,
    required this.appelClient,
    required this.contacterApres,
  });

  factory Forfait.fromJson(Map<String, dynamic> json) {
    return Forfait(
      statut: json['Statut'],
      valide: json['Valide'],
      appelClient: json['AppelClient'],
      contacterApres: json['ContacterApres'],
    );
  }
}