import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:interfaz_/api/authentication_api.dart';
import 'package:interfaz_/models/authentication_response.dart';
import 'package:interfaz_/models/session.dart';
import 'package:interfaz_/utils/logs.dart';

class AuthenticationClient {
  final FlutterSecureStorage _secureStorage;
  final AuthenticationAPI _authenticationAPI;

  late Completer _completer;

  AuthenticationClient(this._secureStorage, this._authenticationAPI);

  Future<String?> get accessToken async {
    if (_completer != null) {
      await _completer.future;
    }

    _completer = Completer();

    final data = await _secureStorage.read(key: 'SESSION');
    if (data != null) {
      final session = Session.fromJson(jsonDecode(data));

      final DateTime currentDate = DateTime.now();
      final DateTime createdAt = session.createdAt;
      final int expiresIn = session.expiresIn;
      final int diff = currentDate.difference(createdAt).inSeconds;

      Logs.p.i('Session life time ${expiresIn - diff}');

      if (expiresIn - diff >= 60) {
        _completer.complete();
        return session.token;
      }
      final response = await _authenticationAPI.refreshToken(session.token);
      if (response.data != null) {
        await saveSession(response.data!);
        _completer.complete();
        return response.data!.token;
      }
      _completer.complete();

      return null;
    }
    _completer.complete();
    return null;
  }

  Future<void> saveSession(
      AuthenticationResponse authenticationResponse) async {
    final Session session = Session(
      token: authenticationResponse.token,
      expiresIn: authenticationResponse.expiresIn,
      createdAt: DateTime.now(),
    );

    final data = jsonEncode(session.toJson());
    await _secureStorage.write(key: 'SESSION', value: data);
  }

  Future<void> signOut() async {
    await _secureStorage.deleteAll();
  }
}
