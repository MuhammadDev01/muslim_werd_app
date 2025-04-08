import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) =>
      Navigator.pushNamed(this, routeName, arguments: arguments);

  Future<dynamic> pushReplacement(String routeName, {Object? arguments}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: arguments);

  Future<dynamic> pushNamedAndRemoveUntil(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) => Navigator.pushNamedAndRemoveUntil(
    this,
    newRouteName,
    predicate,
    arguments: arguments,
  );
}
