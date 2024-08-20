import 'package:movieflutter/common/exception.dart';
import 'package:movieflutter/data/datasources/db/database_helper.dart';
import 'package:movieflutter/data/models/series_table.dart';

abstract class SeriesLocalDataSource {
  Future<String> insertWatchlistSeries(SeriesTable movie);

  Future<String> removeWatchlistSeries(SeriesTable movie);

  Future<SeriesTable?> getSeriesById(int id);

  Future<List<SeriesTable>> getWatchlistSeries();
}

class SeriesLocalDataSourceImpl implements SeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  SeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistSeries(SeriesTable movie) async {
    try {
      await databaseHelper.insertWatchlistTV(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistSeries(SeriesTable movie) async {
    try {
      await databaseHelper.removeWatchlistTV(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<SeriesTable?> getSeriesById(int id) async {
    final result = await databaseHelper.getSeriesById(id);
    if (result != null) {
      return SeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<SeriesTable>> getWatchlistSeries() async {
    final result = await databaseHelper.getWatchlistTVShows();
    return result.map((data) => SeriesTable.fromMap(data)).toList();
  }
}
