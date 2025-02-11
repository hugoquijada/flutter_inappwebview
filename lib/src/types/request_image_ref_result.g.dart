// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_image_ref_result.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the result used by the [InAppWebViewController.requestImageRef] method.
class RequestImageRefResult {
  ///The image's url.
  Uri? url;
  RequestImageRefResult({this.url});

  ///Gets a possible [RequestImageRefResult] instance from a [Map] value.
  static RequestImageRefResult? fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }
    final instance = RequestImageRefResult(
      url: map['url'] != null ? Uri.parse(map['url']) : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap() {
    return {
      "url": url?.toString(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'RequestImageRefResult{url: $url}';
  }
}
