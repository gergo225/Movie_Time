import 'package:dartz/dartz.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'series_info.dart';

abstract class SeriesInfoRepository {
  Future<Either<Failure, SeriesInfo>> getSeriesById(int id);
}