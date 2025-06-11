import 'dart:io';

import 'package:daily_bite/core/constants/app_const_service.dart';
import 'package:daily_bite/models/user_model/user_model.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:dio/dio.dart';

class AccountsApiService {
  final dio = getIt<Dio>();
  final String baseUrl = AppConstService.baseUrl;

  Future<UserModel> getUserInfo(String token) async {
    final response = await dio.get(
      '$baseUrl/api/accounts/info/',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> updateProfile({
    String? name,
    File? photo,
  }) async {
    final Map<String, dynamic> formMap = {};

    if (name != null) {
      formMap['name'] = name;
    }

    if (photo != null) {
      formMap['photo'] = await MultipartFile.fromFile(
        photo.path,
        filename: photo.path.split('/').last,
      );
    }

    final formData = FormData.fromMap(formMap);

    final response = await dio.put(
      '$baseUrl/accounts/info/',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return UserModel.fromJson(response.data);
  }
}
