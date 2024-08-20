import 'package:flutter/foundation.dart';
import 'package:movieflutter/common/state_enum.dart';
import 'package:movieflutter/domain/entities/series.dart';
import 'package:movieflutter/domain/usecases/series/get_watchlist_series.dart';

class WatchlistSeriesNotifier extends ChangeNotifier {
  var _watchlistSeries = <Series>[];

  List<Series> get watchlistSeries => _watchlistSeries;

  var _watchlistState = RequestState.Empty;

  RequestState get watchlistState => _watchlistState;

  String _message = '';

  String get message => _message;

  WatchlistSeriesNotifier({required this.getWatchlistSeries});

  final GetWatchlistSeries getWatchlistSeries;

  Future<void> fetchWatchlistSeries() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistSeries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistSeries = moviesData;
        notifyListeners();
      },
    );
  }
}
