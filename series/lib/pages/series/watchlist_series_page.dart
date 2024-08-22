
import 'package:commonui/utils.dart';
import 'package:commonui/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/bloc/watchlist/watchlist_tv_series_bloc.dart';

class WatchlistSeriesPage extends StatefulWidget {


  const WatchlistSeriesPage({super.key});

  @override
  _WatchlistSeriesPageState createState() => _WatchlistSeriesPageState();
}

class _WatchlistSeriesPageState extends State<WatchlistSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tv'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
              builder: (context, state) {
            if (state is WatchlistTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.series[index];
                  return SeriesCard(series);
                },
                itemCount: state.series.length,
              );
            } else if (state is WatchlistTvSeriesError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text("No Data Displayed"),
              );
            }
          })),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
