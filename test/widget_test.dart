import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_werd_app/features/home/ui/home_screen.dart';
import 'package:muslim_werd_app/muslim_werd_app.dart';

void main() {
  testWidgets('App renders the home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MuslimWerdApp());
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
  });
}