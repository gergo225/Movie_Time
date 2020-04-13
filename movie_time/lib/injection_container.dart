import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/features/movie/data/repositories/movie_info_repository_impl.dart';
import 'package:movie_time/features/movie/domain/repositories/movie_info_repository.dart';
import 'package:movie_time/features/movie/domain/usecases/get_movie_by_id.dart';
import 'package:movie_time/features/movie/presentation/bloc/movie_info_bloc.dart';
import 'package:movie_time/features/search/data/datasources/search_remote_data_source.dart';
import 'package:movie_time/features/search/data/repositories/search_repository_impl.dart';
import 'package:movie_time/features/search/domain/usecases/search_movie_by_title.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/movie/data/datasources/movie_info_remote_data_source.dart';
import 'features/movie/domain/usecases/get_latest_movie.dart';
import 'features/search/domain/repositories/search_repository.dart';
import 'features/search/presentation/bloc/search_bloc.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Movie Info, search
  setUpMovieFeature();
  setUpSearchFeature();

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}

void setUpMovieFeature() {
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
}

void setUpSearchFeature() {
  // Bloc
  sl.registerFactory(() => SearchBloc(
        byTitle: sl(),
      ));
  // Use cases
  sl.registerLazySingleton(() => SearchMovieByTitle(sl()));
  // Repository
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(client: sl()),
  );
}
