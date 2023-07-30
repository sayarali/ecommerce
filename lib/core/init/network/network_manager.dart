
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/core/constants/network/network_constants.dart';
import '../../base/model/base_model.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._init();
  static NetworkManager get instance => _instance;
  NetworkManager._init() {
    final baseOptions = BaseOptions(
      baseUrl: NetworkConstants.BASE_URL,
      responseType: ResponseType.json,
    );
    _dio = Dio(baseOptions);
    _dio.interceptors.add(InterceptorsWrapper());
  }

  Dio _dio;

  Future dioGet<T extends BaseModel>(String path, T model) async {
    final response = await _dio.get(path);
    switch(response.statusCode) {
      case HttpStatus.ok: {
        final responseBody = response.data;
        if(responseBody is List){
          return responseBody.map((e) => model.fromJson(e as Map<String, Object>)).toList().cast<T>();
        } else if(responseBody is Map){
          return model.fromJson(responseBody);
        }
        print("any");
        return responseBody;
      }
    }
  }
}