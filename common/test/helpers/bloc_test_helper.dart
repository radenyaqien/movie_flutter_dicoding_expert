import 'package:domain/usecases/series/get_now_playing_series.dart';
import 'package:domain/usecases/series/get_popular_series.dart';
import 'package:domain/usecases/series/get_series_detail.dart';
import 'package:domain/usecases/series/get_series_recommendations.dart';
import 'package:domain/usecases/series/get_top_rated_series.dart';
import 'package:domain/usecases/series/get_watchlist_series.dart';
import 'package:domain/usecases/series/get_watchlist_series_status.dart';
import 'package:domain/usecases/series/remove_watchlist_series.dart';
import 'package:domain/usecases/series/save_watchlist_series.dart';
import 'package:domain/usecases/series/search_series.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetSeriesDetail,
  GetPopularSeries,
  GetNowPlayingSeries,
  GetTopRatedSeries,
  GetWatchListSeriesStatus,
  GetWatchlistSeries,
  RemoveWatchlistSeries,
  SaveWatchlistSeries,
  GetSeriesRecommendations,
  SearchSeries,
])
void main() {}
