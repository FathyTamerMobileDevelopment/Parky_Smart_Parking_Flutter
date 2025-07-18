import 'package:dio/dio.dart';
import 'package:parky/features/profile/data/models/user_model.dart';

import '../../../../core/api/dio_consumer.dart';

class ProfileRemoteDataSource {
  final _dioConsumer = DioConsumer(dio: Dio());

  Future<List<AllUsersModel>> getAllUsers() async {
    List<dynamic> response = await _dioConsumer.get(path: '/api/users/');
    List<AllUsersModel> users = [];
    for (var element in response) {
      users.add(AllUsersModel.fromJson(element));
    }
    return users;
  }

  // get profile
  Future<UserModel> getProfile() async {
    var response = await _dioConsumer.get(path: '/api/profile/');
    return UserModel.fromJson(response);
  }
}
