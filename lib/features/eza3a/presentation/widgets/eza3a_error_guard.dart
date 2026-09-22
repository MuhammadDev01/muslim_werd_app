import 'dart:async' show TimeoutException;
import 'dart:io' show IOException;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:just_audio/just_audio.dart' show PlayerException;

class Eza3aErrorGuard extends StatefulWidget {
  const Eza3aErrorGuard({super.key, required this.child});

  final Widget child;

  @override
  State<Eza3aErrorGuard> createState() => _Eza3aErrorGuardState();
}

class _Eza3aErrorGuardState extends State<Eza3aErrorGuard> {
  void Function(FlutterErrorDetails)? _previous;

  @override
  void initState() {
    super.initState();
    _previous = FlutterError.onError;
    FlutterError.onError = _filteredOnError;
  }

  void _filteredOnError(FlutterErrorDetails details) {
    if (_isStreamNoise(details.exception)) return;
    _previous?.call(details);
  }

  static bool _isStreamNoise(Object error) {
    if (error is PlayerException) return true;
    if (error is IOException) return true;
    if (error is TimeoutException) return true;
    if (error is PlatformException) {
      const noisyCodes = {'0', '10000000', '100000001'};
      final message = error.message;
      return noisyCodes.contains(error.code) ||
          (message != null &&
              (message.contains('Source error') ||
                  message.contains('Connection aborted')));
    }
    return false;
  }

  @override
  void dispose() {
    FlutterError.onError = _previous;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
