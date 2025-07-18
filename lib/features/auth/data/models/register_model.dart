import 'dart:io';

import 'package:flutter/material.dart';

class RegisterModel {
  // singleton
  static final RegisterModel _singleton = RegisterModel._internal();

  factory RegisterModel() => _singleton;

  RegisterModel._internal();

  // feilds
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController licensePlateController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationalId = TextEditingController(text: '1234567890');
  String gender = 'Male';
  File? image;
  String? avatar;

  Map<String, dynamic> toJson() => {
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'license_plate': licensePlateController.text,
        'car_model': carModelController.text,
        'phone_number': phoneController.text,
        'gender': gender,
        'national_id': nationalId.text,
        'username': firstNameController.text,
        // 'image': MultipartFile.fromFileSync(image?.path ?? '')
      };

  // Map<String, dynamic> toJson() => {
  //       'first_name': 'Mostafa',
  //       'last_name': "Mohamed",
  //       'email': "Mostafa@gmail.com",
  //       'password': "123456789",
  //       'license_plate': 'ABC123',
  //       'car_model': 'Toyota Camry',
  //       'phone_number': '0123456789',
  //       'gender': 'Male',
  //       'national_id': '1234567890',
  //       'username': 'Mostafa',
  //       // 'image': MultipartFile.fromFileSync(image?.path ?? ''),
  //     };

  // // form data
  // FormData formData() => FormData.fromMap(
  //       {
  //         'first_name': firstNameController.text,
  //         'last_name': lastNameController.text,
  //         'email': emailController.text,
  //         'password': passwordController.text,
  //         'license_plate': licensePlateController.text,
  //         'car_model': carModelController.text,
  //         'phone_number': phoneController.text,
  //         'gender': gender,
  //         'national_id': nationalId.text,
  //         'username': firstNameController.text,
  //         'image': MultipartFile.fromFileSync(image?.path ?? '')
  //       },
  //     );

  // clear
  void clear() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    licensePlateController.clear();
    carModelController.clear();
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    licensePlateController.dispose();
    carModelController.dispose();
  }
}
