import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movieflutter/common/state_enum.dart';
import 'package:movieflutter/domain/entities/series.dart';
import 'package:movieflutter/domain/entities/series/tv_detail.dart';
import 'package:movieflutter/domain/usecases/series/get_series_detail.dart';
import 'package:movieflutter/domain/usecases/series/get_series_recommendations.dart';
import 'package:movieflutter/domain/usecases/series/get_watchlist_series_status.dart';
import 'package:movieflutter/domain/usecases/series/remove_watchlist_series.dart';

import '../../../domain/usecases/series/save_watchlist_series.dart';

class SeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendations getSeriesRecommendations;
  final GetWatchListSeriesStatus getWatchListStatus;
  final SaveWatchlistSeries saveWatchlist;
  final RemoveWatchlistSeries removeWatchlist;

  SeriesDetailNotifier({
    required this.getSeriesDetail,
    required this.getSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late SeriesDetail _series;

  SeriesDetail get series => _series;

  RequestState _seriesState = RequestState.Empty;

  RequestState get seriesState => _seriesState;

  List<Series> _seriesRecommendations = [];

  List<Series> get movieRecommendations => _seriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;

  RequestState get recommendationState => _recommendationState;

  String _message = '';

  String get message => _message;

  bool _isAddedtoWatchlist = false;

  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchSeriesDetail(int id) async {
    _seriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getSeriesDetail.execute(id);
    final recommendationResult = await getSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _seriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _recommendationState = RequestState.Loading;
        _series = movie;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = RequestState.Loaded;
            _seriesRecommendations = movies;
          },
        );
        _seriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';

  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(SeriesDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(SeriesDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
