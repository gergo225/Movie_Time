import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/data/movie/movie_info_remote_data_source.dart';
import 'package:movie_time/data/movie/movie_info_repository_impl.dart';
import 'package:movie_time/data/search/search_remote_data_source.dart';
import 'package:movie_time/data/search/search_repository_impl.dart';
import 'package:movie_time/domain/movie/get_movie_by_id.dart';
import 'package:movie_time/domain/movie/movie_info_repository.dart';
import 'package:movie_time/domain/search/search_movie_by_title.dart';
import 'package:movie_time/domain/search/search_repository.dart';
import 'package:movie_time/presentation/movie/movie_info_bloc.dart';
import 'package:movie_time/presentation/search/search_bloc.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Movie Info, Search
  setUpMovieFeature();
  setUpSearchFeature();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  //! External
  sl.registerLazySingleton(() => http.Client());
}

void setUpMovieFeature() {
  // Bloc
  sl.registerFactory(
    () => MovieInfoBloc(
      byId: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => GetMovieById(sl()));
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
