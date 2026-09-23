import 'dart:async' show TimeoutException;
import 'dart:io' show IOException;
import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:intl/date_symbol_data_local.dart';
import 'package:just_audio/just_audio.dart' show PlayerException;
import 'package:muslim_werd_app/muslim_werd_app.dart';

bool _isStreamNoise(Object error) {
  if (error is PlayerException) return true;
  if (error is IOException) return true;
  if (error is TimeoutException) return true;
  if (error is PlatformException) {
    const knownCodes = {'0', '10000000', '100000001Zone mismatch.'};
    final message = error.message;
    if (knownCodes.contains(error.code)) return true;
    if (message != null &&
        (message.contains('Source error') ||
            message.contains('Connection aborted'))) {
      return true;
    }
  }
  return false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("ar");
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    if (_isStreamNoise(error)) return true;
    FlutterError.reportError(
      FlutterErrorDetails(exception: error, stack: stack),
    );
    return true;
  };
  runApp(const MuslimWerdApp());
}
