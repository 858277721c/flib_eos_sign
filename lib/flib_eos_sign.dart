import 'dart:async';

import 'package:flutter/services.dart';

class FlibEosSign {
  static const MethodChannel _channel =
  const MethodChannel('flutter.fanwe.com/flib_eos_sign');

  static Future<String> generatePrivateKey() async {
    return await _channel.invokeMethod('generatePrivateKey');
  }

  static Future<String> toPublicKey(String privateKey) async {
    return await _channel.invokeMethod('toPublicKey', privateKey);
  }

  static Future<String> sign(List<int> data, String privateKey) async {
    final Map<String, dynamic> arguments = {
      'data': data,
      'privateKey': privateKey,
    };
    return await _channel.invokeMethod('sign', arguments);
  }
}
