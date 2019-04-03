import 'package:flutter/material.dart';

///
/// Custom scroll behavior of list view
/// Remove overflow color when scroll list view
///
class MyScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}