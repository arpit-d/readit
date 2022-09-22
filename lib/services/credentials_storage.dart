import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:readit/models/access_token_response_model.dart';

class CredentialsStorage {
  final FlutterSecureStorage _storage;
  CredentialsStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? FlutterSecureStorage();

  AccessTokenResponseModel? _cachedAccessTokenCredentials;
  static const _key = 'accesstoken_credentials';

  Future<AccessTokenResponseModel?> read() async {
    if (_cachedAccessTokenCredentials != null) {
      log('Fetching credentials from cache');
      return _cachedAccessTokenCredentials;
    }
    try {
      final json = await _storage.read(
        key: _key,
        wOptions: WindowsOptions(),
        aOptions: AndroidOptions(),
      );

      if (json == null) return null;
      log('Fetching credentials from local storage');
      return _cachedAccessTokenCredentials =
          AccessTokenResponseModel.fromJson(json);
    } catch (e, stacktrace) {
      print('platformException occured' + e.toString() + stacktrace.toString());
    }
    return null;

    // try {

    // } catch (e, stacktrace) {
    //   print('in error');
    //   print(e.toString());
    //   print(stacktrace.toString());
    //   return null;
    // }
  }

  Future<void> save(AccessTokenResponseModel accessTokenCredentials) async {
    log('Saving credentials in cache as well as storage');
    _cachedAccessTokenCredentials = accessTokenCredentials;

    return await _storage.write(
        key: _key, value: accessTokenCredentials.toJson());
  }

  Future<void> delete() async {
    log('Deleting credentials in cache as well as storage');
    _cachedAccessTokenCredentials = null;
    return await _storage.delete(key: _key);
  }
}
