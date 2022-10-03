import 'dart:convert';

import 'package:readit/models/user_data_model.dart';
import 'package:readit/services/user_data_service.dart';

import '../core/locator.dart';

class UserDataRepository {
  final UserDataService _userDataService;

  UserDataRepository({UserDataService? userDataService})
      : _userDataService = userDataService ?? locator.get<UserDataService>();
  Future<UserDataModel> getUserData() async {
    try {
      final userData = _userDataService.getUserData();
      // final userData = _userDataService.getUserData().then(
      //   (value) {
      //     log(value);
      //     return UserDataModel.fromJson(
      //         jsonDecode(value) as Map<String, dynamic>);
      //   },
      // );
      return UserDataModel.fromJson(
          jsonDecode(await userData) as Map<String, dynamic>);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
