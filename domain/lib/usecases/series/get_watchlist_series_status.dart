import 'package:domain/repositories/series_repository.dart';

class GetWatchListSeriesStatus {
  final SeriesRepository repository;

  GetWatchListSeriesStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTv(id);
  }
}
