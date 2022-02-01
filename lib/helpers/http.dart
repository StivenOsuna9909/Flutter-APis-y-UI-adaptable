import 'package:dio/dio.dart';
import 'package:interfaz_/helpers/http_response.dart';
import 'package:interfaz_/utils/logs.dart';

class Http {
  late Dio _dio;

  late bool _logsEnabled;
  Http({
    required Dio dio,
    required bool logsEnabled,
  }) {
    _dio = dio;

    _logsEnabled = logsEnabled;
  }

  Future<HttpResponse<T>> request<T>(
    String path, {
    String method = 'GET',
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Function(dynamic data)? parser,
  }) async {
    try {
      final response = await _dio.request(
        path,
        options: Options(
          method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: data,
      );
      Logs.p.i(response.data);

      if (parser != null) {
        return HttpResponse.success<T>(parser(response.data));
      }
      return HttpResponse.success(response.data);
    } catch (e) {
      //Logs.p.e(e);

      int statusCode = 0;
      String message = 'Unknown error';
      dynamic data;

      if (e is DioError) {
        statusCode = -1;
        message = e.message;

        statusCode = e.response?.statusCode ?? -1;
        message = e.response?.statusMessage ?? 'Unknown error';
        data = e.response?.data;
      }

      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
