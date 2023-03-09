import 'package:flutter/material.dart';

class Nav {
  Nav._();

  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  static NavigatorState get to => navKey.currentState!;
}
