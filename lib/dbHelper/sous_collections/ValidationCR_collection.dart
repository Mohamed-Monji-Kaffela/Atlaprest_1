class ValidationCR{
  bool? incoherent;
  String? typeInstallationDeclareTechnicien;

  ValidationCR({required this.incoherent, required this.typeInstallationDeclareTechnicien});

  factory ValidationCR.fromJson(Map<String, dynamic> json) {
    return ValidationCR(
      incoherent: json["Incoherent"],
      typeInstallationDeclareTechnicien: json["TypeInstallationDeclareTechnicien"],
    );
  }
}