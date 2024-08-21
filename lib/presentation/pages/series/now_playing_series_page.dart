import 'package:movieflutter/common/state_enum.dart';
import 'package:movieflutter/presentation/provider/series/nowplaying_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/series_card_list.dart';

class NowPlayingSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now_playing-series';

  const NowPlayingSeriesPage({super.key});

  @override
  _NowPlayingSeriesPageState createState() => _NowPlayingSeriesPageState();
}

class _NowPlayingSeriesPageState extends State<NowPlayingSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowPlayingSeriesNotifier>(context, listen: false)
            .fetchNowPlayingSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayingSeriesNotifier>(
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
