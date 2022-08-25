import 'package:flutter/material.dart';

import 'app.dart';
import 'dependency_injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const AlbumApp());
}
