import 'package:commonui/constants.dart';
import 'package:commonui/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/search/movie_search_bloc.dart';
import 'package:movies/bloc/search/movie_search_event.dart';
import 'package:movies/bloc/search/movie_search_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<MovieSearchBloc>().add(OnSearchMovie(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<MovieSearchBloc, MovieSearchState>(
                builder: (ctx, state) {
              switch (state) {
                case SearchMovieEmpty():
                  return const Center(
                    child: Text("No Data displayed"),
                  );
                case SearchMovieLoading():
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case SearchMovieError():
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                case SearchMovieHasData():
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return MovieCard(movie);
                      },
                      itemCount: state.movies.length,
                    ),
                  );
                case SearchMovieInitial():
                  return const Center(
                    child: Text("Search Your favorite Movie"),
                  );
              }
            })
          ],
        ),
      ),
    );
  }
}
