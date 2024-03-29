import 'package:cypress_task/features/album/data/model/response/photo_response.dart';
import 'package:hive/hive.dart';

import 'features/album/blocs/photos_bloc/photos_bloc_bloc.dart';
import 'features/album/data/data_sources/remote/album_remote.dart';
import 'features/album/data/repositories/album_repo.dart';
import 'features/album/data/repositories/photo_repo.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/data/network_info.dart';
import 'features/album/blocs/albums_bloc/album_bloc.dart';
import 'features/album/data/data_sources/local/album_local.dart';
import 'features/album/data/data_sources/local/photo_local.dart';
import 'features/album/data/data_sources/remote/photo_remote.dart';

final di = GetIt.instance;

Future<void> init() async {
// blocs
  di.registerFactory(() => AlbumBloc(albumRepo: di(), albumLocalDataSrc: di()));
  di.registerFactory(
      () => PhotosBloc(photoRepo: di(), photoLocalDataSrc: di()));
  // repos
  di.registerLazySingleton<AlbumRepo>(() => AlbumRepoImpl(
      albumRemoteDataSrc: di(), networkInfo: di(), albumLocalDataSrc: di()));

  di.registerFactory<PhotoRepo>(() => PhotoRepoImpl(
      photoRemoteDataSrc: di(), networkInfo: di(), photoLocalDataSrc: di()));

  // datasource
  di.registerLazySingleton<AlbumRemoteDataSrc>(() => AlbumRemoteDataSrcImpl());
  di.registerLazySingleton<PhotoRemoteDataSrc>(() => PhotoRemoteDataSrcImpl());
  di.registerLazySingleton<AlbumLocalDataSrc>(
      () => AlbumLocalDataSrcImpl(albumBox: di()));
  di.registerLazySingleton<PhotoLocalDataSrc>(
      () => PhotoLocalDataSrcImpl(photoBox: di()));

  // core
  di.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      di(),
    ),
  );

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  final photoBox = await Hive.openBox<AllPhotoResponses>('photos'); // open photos box
  final albumBox = await Hive.openBox('albums'); // open albums box
  di.registerLazySingleton(() => DataConnectionChecker());
  di.registerLazySingleton(() => sharedPreferences);
  di.registerLazySingleton(() => photoBox);
  di.registerLazySingleton(() => albumBox);
}
