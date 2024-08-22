import 'package:commonui/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/bloc/search/search_tv_series_bloc.dart';


class SearchSeriesPage extends StatelessWidget {


  const SearchSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchTvSeriesBloc>().add(OnQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
                  builder: (context, state) {
                if (state is SearchTvSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTvSeriesHasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final series = state.series[index];
                      return SeriesCard(series);
                    },
                    itemCount: state.series.length,
                  );
                } else if (state is SearchTvSeriesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is SearchTvSeriesInitial) {
                  return const Center(
                    child: Text("Search Tv Series"),
                  );
                } else {
                  return const Text(
                      "No Data Displayed, Try to change your query");
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
