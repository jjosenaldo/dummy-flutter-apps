import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app.dart';
import 'module/app_module.dart';

void main() {
  runApp(
    ModularApp(
      child: App(),
      module: AppModule(),
    ),
  );
}
