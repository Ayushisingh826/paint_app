class UserProfile {
  final String id;
  final String userId;
  final String fullName;
  final String phone;
  final String email;
  final int coinsEarned;
  final String dob;
  final String address;
  final String pinCode;
  final String state;
  final String country;
  final bool isPanVerified;
  final bool isAadharVerified;
  final String accountNumber;
  final String accountHolderName;
  final String bankName;
  final String ifscCode;
  final String passbookPhoto;
  final String panNumber;
  final String aadharNumber;
  final bool isPassbookVerified;
  final List<dynamic> productsQrScanned;
  final String createdAt;
  final String updatedAt;

  UserProfile({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.coinsEarned,
    required this.dob,
    required this.address,
    required this.pinCode,
    required this.state,
    required this.country,
    required this.isPanVerified,
    required this.isAadharVerified,
    required this.accountNumber,
    required this.accountHolderName,
    required this.bankName,
    required this.ifscCode,
    required this.passbookPhoto,
    required this.panNumber,
    required this.aadharNumber,
    required this.isPassbookVerified,
    required this.productsQrScanned,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      coinsEarned: json['coinsEarned'] ?? 0,
      dob: json['dob'] ?? '',
      address: json['address'] ?? '',
      pinCode: json['pinCode'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      isPanVerified: json['isPanVerified'] ?? false,
      isAadharVerified: json['isAadharVerified'] ?? false,
      accountNumber: json['accountNumber'] ?? '',
      accountHolderName: json['accountHolderName'] ?? '',
      bankName: json['bankName'] ?? '',
      ifscCode: json['ifscCode'] ?? '',
      passbookPhoto: json['passbookPhoto'] ?? '',
      panNumber: json['panNumber'] ?? '',
      aadharNumber: json['aadharNumber'] ?? '',
      isPassbookVerified: json['isPassbookVerified'] ?? false,
      productsQrScanned: json['productsQrScanned'] ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
