import 'package:commonui/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/bloc/popular_series/popular_series_bloc.dart';
import 'package:series/bloc/popular_series/popular_series_event.dart';


import '../../bloc/popular_series/popular_series_state.dart';

class PopularSeriesPage extends StatefulWidget {


  const PopularSeriesPage({super.key});

  @override
  _PopularSeriesPageState createState() => _PopularSeriesPageState();
}

class _PopularSeriesPageState extends State<PopularSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularSeriesBloc>().add(FetchPopularSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Series'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
              builder: (context, state) {
            if (state is PopularSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.series[index];
                  return SeriesCard(series);
                },
                itemCount: state.series.length,
              );
            } else if (state is PopularSeriesError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Text("No Data Displayed");
            }
          })),
    );
  }
}
