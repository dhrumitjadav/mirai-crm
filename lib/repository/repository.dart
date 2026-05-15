import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:mirai_crm/main.dart';
import 'package:mirai_crm/repository/network_url.dart';
import 'package:mirai_crm/utils/custom_alert_dialog.dart';
import 'package:mirai_crm/utils/shared_preferences.dart';
import '../widgets/logger.dart';

class Repository {
  static final Repository _service = Repository._internal();

  Repository._internal();

  factory Repository() {
    return _service;
  }

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: NetworkUrl.baseUrl,
      connectTimeout: const Duration(seconds: 40),
      receiveTimeout: const Duration(seconds: 40),
      headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
    ),
  );

  initRepo() async {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          logger.i("➡️ onRequest: URI ->> ${options.uri}");
          logger.d("Headers ->> ${options.headers}");
          logger.d("Data ->> ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          logger.i("✅ onResponse: RealUri ->> ${response.realUri}");
          logger.i("StatusCode ->> ${response.statusCode}");
          logger.d("Data ->> ${response.data}");
          return handler.next(response);
        },
        onError: (error, handler) async {
          logger.e("❌ onError: Error ->> ${error.error}");
          logger.e("Response ->> ${error.response}");
          // 403 = permission revoked since last refresh. Re-fetch the
          // permission map so subsequent UI rebuilds reflect the new
          // state, and surface a friendly toast. Skip the toast on the
          // permissions endpoint itself to avoid loops.
          if (error.response?.statusCode == 403) {
            showToastMessage(msg: "You don't have permission for this action.");
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<bool> isInternetAvailable() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity()
        .checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);
  }

  Future<dynamic> getApiCall({required String url}) async {
    bool internetAvailable = await isInternetAvailable();
    dynamic responseJson;
    try {
      if (internetAvailable) {
        String? accessToken = await sp!.getString(SpUtil.accessToken);
        if (accessToken != null) {
          dio.options.headers["Authorization"] = "Bearer $accessToken";
        }
        Response response = await dio.get(url);
        responseJson = response.data;
      } else {
        showToastMessage(msg: "Please check your internet connection and try.");
      }
      return responseJson;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout Exception");
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Receive Timeout Exception");
      }
      throw Exception(e.message.toString());
    }
  }

  Future<dynamic> postApiCall({required String url, required body}) async {
    bool internetAvailable = await isInternetAvailable();
    dynamic responseJson;
    try {
      if (internetAvailable) {
        String? accessToken = await sp!.getString(SpUtil.accessToken);
        if (accessToken != null) {
          dio.options.headers["Authorization"] = "Bearer $accessToken";
        }
        Response response = await dio.post(url, data: body);
        responseJson = response.data;
      } else {
        noInternetDialog(
          onRetry: () {
            postApiCall(url: url, body: body);
          },
        );
      }
      return responseJson;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout Exception");
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Receive Timeout Exception");
      }
      throw Exception(
        e.response?.data is Map && e.response?.data['message'] is String
            ? e.response?.data['message']
            : e.message,
      );
    }
  }

  Future<dynamic> putApiCall({required String url, required body}) async {
    bool internetAvailable = await isInternetAvailable();
    dynamic responseJson;
    try {
      if (internetAvailable) {
        String? accessToken = await sp!.getString(SpUtil.accessToken);
        if (accessToken != null) {
          dio.options.headers["Authorization"] = "Bearer $accessToken";
        }
        Response response = await dio.put(url, data: body);
        responseJson = response.data;
      } else {
        noInternetDialog(
          onRetry: () {
            putApiCall(url: url, body: body);
          },
        );
      }
      return responseJson;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout Exception");
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Receive Timeout Exception");
      }
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  Future<dynamic> multipartPostApiCall({
    required String url,
    required FormData formData,
  }) async {
    bool internetAvailable = await isInternetAvailable();
    dynamic responseJson;
    try {
      if (internetAvailable) {
        String? accessToken = await sp!.getString(SpUtil.accessToken);
        if (accessToken != null) {
          dio.options.headers["Authorization"] = "Bearer $accessToken";
        }
        Response response = await dio.post(
          url,
          data: formData,
          options: Options(contentType: 'multipart/form-data'),
        );
        responseJson = response.data;
      } else {
        noInternetDialog(
          onRetry: () {
            multipartPostApiCall(url: url, formData: formData);
          },
        );
      }
      return responseJson;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout Exception");
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Receive Timeout Exception");
      }
      throw Exception(
        e.response?.data is Map && e.response?.data['message'] is String
            ? e.response?.data['message']
            : e.message,
      );
    }
  }

  Future<dynamic> deleteApiCall({required String url}) async {
    bool internetAvailable = await isInternetAvailable();
    dynamic responseJson;
    try {
      if (internetAvailable) {
        String? accessToken = await sp!.getString(SpUtil.accessToken);
        if (accessToken != null) {
          dio.options.headers["Authorization"] = "Bearer $accessToken";
        }
        Response response = await dio.delete(url);
        responseJson = response.data;
      } else {
        noInternetDialog(
          onRetry: () {
            deleteApiCall(url: url);
          },
        );
      }
      return responseJson;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout Exception");
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Receive Timeout Exception");
      }
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}
