import 'package:interfaz_/helpers/http.dart';
import 'package:interfaz_/helpers/http_response.dart';
import 'package:interfaz_/models/authentication_response.dart';

class AuthenticationAPI {
  late final Http _http;
  //la de abajo fue la solución que por error no tuve en cuenta pero que fue la creación del constructor que hizo vsc para el tutorial
  //AuthenticationAPI(this._http);
  //personalmente la inicializacion del constructor http me gustó mas fue la solucion que generó el otro dev del grupo de telegram
  AuthenticationAPI(final Http http) : this._http = http;

  Future<HttpResponse<AuthenticationResponse>> register({
    required String username,
    required String email,
    required String password,
  }) {
    return _http.request<AuthenticationResponse>(
      '/api/v1/register',
      method: 'POST',
      data: {
        "username": username,
        "email": email,
        "password": password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

//duplicado del codigo register

  Future<HttpResponse<AuthenticationResponse>> login({
    required String email,
    required String password,
  }) async {
    return _http.request<AuthenticationResponse>(
      '/api/v1/login',
      method: 'POST',
      data: {
        "email": email,
        "password": password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

  Future<HttpResponse<AuthenticationResponse>> refreshToken(
      String expiredToken) {
    return _http.request<AuthenticationResponse>(
      '/api/v1/refresh-token',
      headers: {
        'token': expiredToken,
      },
      method: 'POST',
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }
}
