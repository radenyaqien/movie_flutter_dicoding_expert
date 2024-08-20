import 'package:movieflutter/common/state_enum.dart';
import 'package:movieflutter/domain/entities/series.dart';
import 'package:movieflutter/domain/usecases/series/get_popular_series.dart';
import 'package:flutter/foundation.dart';

class PopularSeriesNotifier extends ChangeNotifier {
  final GetPopularSeries getPopularSeries;

  PopularSeriesNotifier({required this.getPopularSeries});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Series> _series = [];

  List<Series> get series => _series;

  String _message = '';

  String get message => _message;

  Future<void> fetchPopularSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _series = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
