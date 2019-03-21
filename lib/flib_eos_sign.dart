import 'dart:async';

import 'package:flutter/services.dart';

class FlibEosSign {
  static const MethodChannel _channel =
      const MethodChannel('flutter.fanwe.com/flib_eos_sign');

  static Future<String> generatePrivateKey() {
    return _channel.invokeMethod<String>('generatePrivateKey');
  }

  static Future<String> toPublicKey(String privateKey) {
    return _channel.invokeMethod<String>('toPublicKey', privateKey);
  }

  static Future<String> sign(List<int> data, String privateKey) {
    final Map<String, dynamic> arguments = {
      'data': data,
      'privateKey': privateKey,
    };
    return _channel.invokeMethod<String>('sign', arguments);
  }
}
