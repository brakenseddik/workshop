import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:untitled/utils/failure.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://dummyjson.com',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'charset': 'utf-8',
      'Accept-Charset': 'utf-8',
    },
  ));

  Future<T> getHttp<T>({
    required String endPoint,
    required T Function(Object data) deserializer,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get(
        endPoint,
        queryParameters: queryParams,
      );
      if (response.statusCode! / 100 == 2) {
        final T decodedJson = deserializer(jsonDecode(response.data));
        return decodedJson;
      }
    } on DioException catch (e) {
      log(e.toString());
      throw Failure(e.message, e.type.name);
    } catch (e) {
      log(e.toString());
      throw Failure("Internet exception", "400");
    }
    throw Failure('Unknown Error', null);
  }

  /// [deserializer] how to deserialize the coming json, if there is no json
  /// just pass (_) => unit
  Future<T> postData<T>(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParams,
      required T Function(Object data) deserializer,
      void Function(int, int)? onSendProgress}) async {
    try {
      final Response response = await _dio.post(endPoint,
          data: data == null ? null : FormData.fromMap(data),
          // ?? jsonEncode(data),
          queryParameters: queryParams,
          onSendProgress: onSendProgress);
      log("response:  ${response.statusCode}");
      if (response.statusCode == 200) {
        final T decodedJson = deserializer(response.data);
        log("decoded data: $decodedJson");
        return decodedJson;
      }
    } on DioException catch (e) {
      log("Dio exception:$e");
      throw Failure(e.message, null);
    } catch (e) {
      log("uncaught exception: $e");
      throw Failure("Internet error", null);
    }
    throw Failure("Unknown error", null);
  }
}
