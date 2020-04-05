import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/features/movie/data/repositories/movie_info_repository_impl.dart';
import 'package:movie_time/features/movie/domain/repositories/movie_info_repository.dart';
import 'package:movie_time/features/movie/domain/usecases/get_movie_by_id.dart';
import 'package:movie_time/features/movie/presentation/bloc/movie_info_bloc.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/movie/data/datasources/movie_info_remote_data_source.dart';
import 'features/movie/domain/usecases/get_latest_movie.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Movie Info
  // Bloc
  sl.registerFactory(
    () => MovieInfoBloc(
      byId: sl(),
      latest: sl(),
      inputConverter: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => GetMovieById(sl()));
  sl.registerLazySingleton(() => GetLatestMovie(sl()));
  // Repository
  sl.registerLazySingleton<MovieInfoRepository>(
    () => MovieInfoRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<MovieInfoRemoteDataSource>(
    () => MovieInfoRemoteDataSourceImpl(client: sl()),
  );
  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
