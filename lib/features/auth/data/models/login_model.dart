class LoginModel {
  final String email;
  final String password;

  LoginModel({required this.email, required this.password});

  // toJson
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
