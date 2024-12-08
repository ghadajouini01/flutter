import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:clone_jumia/services/api_response.dart';
import 'package:clone_jumia/services/custom_exception.dart';

abstract class BaseService<Model> extends ChangeNotifier {
  ApiResponse<Model> apiResponse = ApiResponse.loading();

  BaseService();

  Function? get fromJsonFunction => null;

  Function(Model)? get toJsonFunction => null;

  CustomException toJsonFunctionUnassignedError() =>
      CustomException(message: "To json function unassigned");

  bool isDisposed = false;

  @override
  void dispose() {
    super.dispose();

    isDisposed = true;
  }

  void setApiResponseData(
    dynamic data,
    Function? fromJson, {
    bool hasCustomData = false,
  }) {
    print('data : $data');

    if (hasCustomData) {
      apiResponse.customData = data;
      return;
    }

    if (data is List) {
      if (data.isNotEmpty && fromJson != null) {
        apiResponse.itemList = data.map<Model>((e) => fromJson(e)).toList();
      }
    } else if (data is Map) {
      if (fromJson != null) {
        apiResponse.item = fromJson(data);
      } else {
        print('From json null');
      }
    } else if (data is String) {
      apiResponse.message = data;
    } else {
      apiResponse.customData = data;
      log('Unsupported api response type ${data.runtimeType}');
      log("Custom data : $data");
    }
  }

  Future<ApiResponse<Model>> makeApiCall({
    required Future<dynamic> apiCall,
    Function? fromJsonFunction,
    bool withoutLoading = false,
    bool hasCustomData = false,
  }) async {
    if (!withoutLoading) apiResponse = ApiResponse.loading();
    if (!isDisposed) notifyListeners();

    try {
      apiResponse = ApiResponse.completed();
      setApiResponseData(
        await apiCall,
        fromJsonFunction,
        hasCustomData: hasCustomData,
      );
      if (!isDisposed) notifyListeners();
    } catch (e, stackTrace) {
      int? statusCode;
      if (e.runtimeType == CustomException) {
        statusCode = (e as CustomException).statusCode;
      }

      log('Network error : $e');
      if (kDebugMode) print(stackTrace);
      apiResponse = ApiResponse.error(
        message: e.toString(),
        statusCode: statusCode,
      );
      if (!isDisposed) notifyListeners();
    }

    return apiResponse;
  }
}
