import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:muslim_werd_app/muslim_werd_app.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => const MuslimWerdApp(),
      enabled: kReleaseMode,
    ),
  );
}
