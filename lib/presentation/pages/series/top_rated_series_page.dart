import 'package:movieflutter/common/state_enum.dart';
import 'package:movieflutter/presentation/provider/series/top_rated_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/series_card_list.dart';

class TopRatedSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-series';

  const TopRatedSeriesPage({super.key});

  @override
  _TopRatedSeriesPageState createState() => _TopRatedSeriesPageState();
}

class _TopRatedSeriesPageState extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedSeriesNotifier>(context, listen: false)
            .fetchTopRatedSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = data.series[index];
                  return SeriesCard(series);
                },
                itemCount: data.series.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
