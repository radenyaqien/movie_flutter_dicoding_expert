import 'package:commonui/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/bloc/now_playing/now_playing_bloc.dart';
import 'package:series/bloc/now_playing/nowplaying_event.dart';
import 'package:series/bloc/now_playing/nowplaying_state.dart';


class NowPlayingSeriesPage extends StatefulWidget {


  const NowPlayingSeriesPage({super.key});

  @override
  _NowPlayingSeriesPageState createState() => _NowPlayingSeriesPageState();
}

class _NowPlayingSeriesPageState extends State<NowPlayingSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<NowPlayingBloc>().add(FetchNowPlayingTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingBloc, NowPlayingSeriesState>(
          builder: (context, data) {
            if (data is NowPlayingSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is NowPlayingSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final seriesItem = data.series[index];
                  return SeriesCard(seriesItem);
                },
                itemCount: data.series.length,
              );
            } else if (data is NowPlayingSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            } else {
              return const Center(
                child: Text("No movie is Displayed"),
              );
            }
          },
        ),
      ),
    );
  }
}
