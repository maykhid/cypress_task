import 'features/album/blocs/photos_bloc/photos_bloc_bloc.dart';
import 'features/album/presentation/album_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/album/blocs/albums_bloc/album_bloc.dart';

class AlbumApp extends StatelessWidget {
  const AlbumApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AlbumBloc>(
            create: (context) => GetIt.instance<AlbumBloc>()..add(AlbumFetched()),
          ),
          BlocProvider<PhotosBloc>(
            create: (context) => GetIt.instance<PhotosBloc>()
          ),
        ],
        child: const AlbumPage(),
      ),
    );
  }
}
