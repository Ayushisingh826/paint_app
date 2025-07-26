class KycStatus {
  final String panPhoto;
  final String panVerificationStatus;
  final String kycStatus;
  final bool kycRequestCreated;

  KycStatus({
    required this.panPhoto,
    required this.panVerificationStatus,
    required this.kycStatus,
    required this.kycRequestCreated,
  });

  factory KycStatus.fromJson(Map<String, dynamic> json) {
    return KycStatus(
      panPhoto: json['panPhoto'] ?? '',
      panVerificationStatus: json['panVerificationStatus'] ?? '',
      kycStatus: json['kycStatus'] ?? '',
      kycRequestCreated: json['kycRequestCreated'] ?? false,
    );
  }
}
