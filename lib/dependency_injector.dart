import 'package:cypress_task/features/album/cubit/album_cubit.dart';
import 'package:cypress_task/features/album/data/data_sources/album_data_src.dart';
import 'package:cypress_task/features/album/data/data_sources/remote/album_remote.dart';
import 'package:cypress_task/features/album/data/repositories/album_repo.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';

import 'core/data/network_info.dart';
import 'features/album/data/data_sources/local/album_local.dart';

final di = GetIt.instance;

Future<void> init() async {
// cubits
  di.registerFactory(() => AlbumCubit(albumRepo: di()));

  // repos
  di.registerLazySingleton<AlbumRepo>(
      () => AlbumRepoImpl(albumDataSrc: di(), networkInfo: di()));

  // datasource
  di.registerLazySingleton<AlbumDataSrc>(() => AlbumRemoteDataSrcImpl());
  di.registerLazySingleton<AlbumDataSrc>(() => AlbumLocalDataSrcImpl());

  // core
  di.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      di(),
    ),
  );

  // external
  di.registerLazySingleton(() => DataConnectionChecker());
}
