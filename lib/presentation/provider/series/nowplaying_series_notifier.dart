import 'package:flutter/foundation.dart';
import 'package:movieflutter/common/state_enum.dart';
import 'package:movieflutter/domain/entities/series/series.dart';
import 'package:movieflutter/domain/usecases/series/get_now_playing_series.dart';

class NowPlayingSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingSeries getNowPlayingSeries;

  NowPlayingSeriesNotifier({required this.getNowPlayingSeries});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Series> _series = [];

  List<Series> get series => _series;

  String _message = '';

  String get message => _message;

  Future<void> fetchNowPlayingSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingSeries.execute();

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
