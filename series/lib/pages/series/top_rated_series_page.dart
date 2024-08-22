import 'package:commonui/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/bloc/toprated/toprated_series_event.dart';

import '../../bloc/toprated/toprated_series_bloc.dart';
import '../../bloc/toprated/toprated_series_state.dart';


class TopRatedSeriesPage extends StatefulWidget {


  const TopRatedSeriesPage({super.key});

  @override
  _TopRatedSeriesPageState createState() => _TopRatedSeriesPageState();
}

class _TopRatedSeriesPageState extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedSeriesBloc>().add(FetchTopRatedSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
            builder: (context, state) {
          if (state is TopRatedSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedSeriesHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final series = state.series[index];
                return SeriesCard(series);
              },
              itemCount: state.series.length,
            );
          } else if (state is TopRatedSeriesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Text("No Data Displayed");
          }
        }),
      ),
    );
  }
}
