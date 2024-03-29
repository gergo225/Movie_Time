import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/data/actor/actor_info_remote_data_source.dart';
import 'package:movie_time/data/actor/actor_info_repository_impl.dart';
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/data/home/home_info_remote_datasource.dart';
import 'package:movie_time/data/home/home_info_repository_impl.dart';
import 'package:movie_time/data/movie/movie_info_remote_data_source.dart';
import 'package:movie_time/data/movie/movie_info_repository_impl.dart';
import 'package:movie_time/data/search/search_remote_data_source.dart';
import 'package:movie_time/data/search/search_repository_impl.dart';
import 'package:movie_time/data/series/series_info_remote_data_source.dart';
import 'package:movie_time/data/series/series_info_repository_impl.dart';
import 'package:movie_time/domain/actor/actor_info_repository.dart';
import 'package:movie_time/domain/actor/get_actor_by_id.dart';
import 'package:movie_time/domain/home/get_home_info.dart';
import 'package:movie_time/domain/home/home_info_repository.dart';
import 'package:movie_time/domain/movie/get_movie_by_id.dart';
import 'package:movie_time/domain/movie/movie_info_repository.dart';
import 'package:movie_time/domain/search/search_media_by_title.dart';
import 'package:movie_time/domain/search/search_repository.dart';
import 'package:movie_time/domain/series/get_series_by_id.dart';
import 'package:movie_time/domain/series/get_series_season_by_number.dart';
import 'package:movie_time/domain/series/series_info_repository.dart';
import 'package:movie_time/presentation/actor/actor_bloc.dart';
import 'package:movie_time/presentation/home/home_bloc.dart';
import 'package:movie_time/presentation/movie/movie_info_bloc.dart';
import 'package:movie_time/presentation/search/search_bloc.dart';
import 'package:movie_time/presentation/series/series_bloc.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Movie, Series, Search, Home, Actor
  setUpMovieFeature();
  setUpSeriesFeature();
  setUpSearchFeature();
  setUpHomeFeature();
  setUpActorFeature();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  //! External
  sl.registerLazySingleton(() => http.Client());
}

void setUpHomeFeature() {
  // Bloc
  sl.registerFactory(
    () => HomeBloc(getHomeInfo: sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetHomeInfo(sl()));
  // Repository
  sl.registerLazySingleton<HomeInfoRepository>(
    () => HomeInfoRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<HomeInfoRemoteDataSource>(
    () => HomeInfoRemoteDataSourceImpl(client: sl()),
  );
}

void setUpMovieFeature() {
  // Bloc
  sl.registerFactory(
    () => MovieInfoBloc(byId: sl()),
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

void setUpSeriesFeature() {
  // Bloc
  sl.registerFactory(
    () => SeriesBloc(
      seasonByNumber: sl(),
      seriesById: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => GetSeriesById(sl()));
  sl.registerLazySingleton(() => GetSeriesSeasonByNumber(sl()));
  // Repository
  sl.registerLazySingleton<SeriesInfoRepository>(
    () => SeriesInfoRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<SeriesInfoRemoteDataSource>(
    () => SeriesInfoRemoteDataSourceImpl(client: sl()),
  );
}

void setUpSearchFeature() {
  // Bloc
  sl.registerFactory(() => SearchBloc(byTitle: sl()));
  // Use cases
  sl.registerLazySingleton(() => SearchMediaByTitle(sl()));
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

void setUpActorFeature() {
  // Bloc
  sl.registerFactory(() => ActorBloc(getActorById: sl()));
  // Use cases
  sl.registerLazySingleton(() => GetActorById(sl()));
  // Repository
  sl.registerLazySingleton<ActorInfoRepository>(
    () => ActorInfoRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<ActorInfoRemoteDataSource>(
    () => ActorInfoRemoteDataSourceImpl(client: sl()),
  );
}
