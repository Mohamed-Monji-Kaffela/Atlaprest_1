class DiagnosticWifi{
  bool? diagnosticWifiInclus;
  bool? diagnosticWifiRealise;

  DiagnosticWifi({
    required this.diagnosticWifiInclus,
    required this.diagnosticWifiRealise,
  });

  factory DiagnosticWifi.fromJson(Map<String, dynamic>? json) {
    return DiagnosticWifi(
      diagnosticWifiRealise: json?["DiagnosticWifiRealise"],
      diagnosticWifiInclus: json?["DiagnosticWifiInclus"],
    );
  }
}