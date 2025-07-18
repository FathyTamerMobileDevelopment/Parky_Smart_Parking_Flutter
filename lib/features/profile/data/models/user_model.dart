class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? nationality;
  String? profilePicture;
  String? gender;
  String? phoneNumber;
  String? image;

  UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.nationality,
    this.profilePicture,
    this.gender,
    this.phoneNumber,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'] as String?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        nationality: json['nationality'] as String?,
        profilePicture: json['profile_picture'] as String?,
        gender: json['gender'] as String?,
        phoneNumber: json['phone_number'] as String?,
        image: json['profile_picture'] as String?,
      );
}

class AllUsersModel {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? profilePicture;
  dynamic phoneNumber;
  String? gender;
  String? nationalId;
  String? nationality;
  String? subscriptionType;
  String? licenseId;
  bool? isSuperuser;
  bool? isActive;

  AllUsersModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.profilePicture,
    this.phoneNumber,
    this.gender,
    this.nationalId,
    this.nationality,
    this.subscriptionType,
    this.licenseId,
    this.isSuperuser,
    this.isActive,
  });

  factory AllUsersModel.fromJson(Map<String, dynamic> json) => AllUsersModel(
        id: json['id'] as int?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        username: json['username'] as String?,
        email: json['email'] as String?,
        profilePicture: json['profile_picture'] as String?,
        phoneNumber: json['phone_number'] as dynamic,
        gender: json['gender'] as String?,
        nationalId: json['national_id'] as String?,
        nationality: json['nationality'] as String?,
        subscriptionType: json['subscription_type'] as String?,
        licenseId: json['license_id'] as String?,
        isSuperuser: json['is_superuser'] as bool?,
        isActive: json['is_active'] as bool?,
      );
}
