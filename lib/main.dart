import 'package:cypress_task/features/album/data/model/response/photo_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'dependency_injector.dart' as di;
import 'simple_bloc_observer.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final dbPath = join(dir.path, 'Album.db');
  Hive.initFlutter(dbPath);
  Hive.registerAdapter<PhotoResponse>(PhotoResponseAdapter());
  await di.init();

  // ..registerAdapter(AlbumResponseAdapter());
  runApp(const AlbumApp());
}
