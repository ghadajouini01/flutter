import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'api_response.dart';

typedef ApiWidgetBuilder<A> = Widget Function(A value);

class ApiViewHandler {
  static Future<void> withAlert({
    required BuildContext context,
    bool showIndicator = true,
    required Future<ApiResponse> apiCall,
    required Function() successFunction,
    Function? failureFunction,
  }) async {
    if (showIndicator && !context.loaderOverlay.visible) {
      context.loaderOverlay.show();
    }

    await apiCall.then((apiResponse) {
      if (apiResponse.status == ApiStatus.completed) {
        successFunction();
      } else {
        if (failureFunction != null) {
          failureFunction();
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(apiResponse.message),
            ),
          );
        }
      }
    }).whenComplete(() {
      if (showIndicator && context.loaderOverlay.visible) {
        context.loaderOverlay.hide();
      }
    });
  }

  static Future<void> futureWithAlert<T>({
    required BuildContext context,
    bool showIndicator = true,
    required Future<T> future,
    required Function(T result) successFunction,
    Function? failureFunction,
  }) async {
    if (showIndicator && !context.loaderOverlay.visible) {
      context.loaderOverlay.show();
    }

    bool hasError = false;
    dynamic result;

    try {
      result = await future;
    } catch (e) {
      if (failureFunction != null) {
        failureFunction();
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          ),
        );
      }
    }

    if (!hasError) successFunction(result);

    if (showIndicator && (context.loaderOverlay.visible)) {
      context.loaderOverlay.hide();
    }
  }

  static Widget modelListBuilder<T>(
    BuildContext context, {
    required ApiResponse<T> apiResponse,
    Widget Function()? loadingWidgetBuilder,
    required ApiWidgetBuilder<List<T>> builder,
    Future<void> Function()? refreshFunction,
  }) {
    switch (apiResponse.status) {
      case ApiStatus.completed:
        return apiResponse.itemList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent))
            : builder(apiResponse.itemList);
      case ApiStatus.loading:
        return loadingWidgetBuilder != null
            ? loadingWidgetBuilder()
            : Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
      case ApiStatus.error:
        return Text(apiResponse.message);
    }
  }
}
