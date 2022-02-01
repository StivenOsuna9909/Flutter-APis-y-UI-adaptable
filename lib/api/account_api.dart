import 'package:interfaz_/data/authentication_client.dart';
import 'package:interfaz_/helpers/http.dart';
import 'package:interfaz_/helpers/http_response.dart';
import 'package:interfaz_/models/user.dart';

class AccountAPI {
  final Http _http;
  final AuthenticationClient _authenticationClient;

  AccountAPI(this._http, this._authenticationClient);

  Future<HttpResponse<User>?> getUserInfo() async {
    try {
      final token = await _authenticationClient.accessToken;
      if (token == null) {
        return null;
      }
      return _http.request(
        '/api/v1/user-info',
        method: 'GET',
        headers: {
          'token': token,
        },
        parser: (data) {
          return User.fromJson(data);
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
