import 'package:commonui/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/popular/movie_toprated_state.dart';
import 'package:movies/bloc/popular/popular_movie_bloc.dart';
import 'package:movies/bloc/popular/popular_movie_event.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({super.key});

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MoviePopularBloc>().add(OnFetchDataPopular()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Popular Movies'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
                builder: (ctx, state) {
              switch (state) {
                case PopularMovieEmpty():
                  return const Center(
                    child: Text("No Data displayed"),
                  );
                case PopularMovieLoading():
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case PopularMovieError():
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                case PopularMovieHasData():
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return MovieCard(movie);
                    },
                    itemCount: state.movies.length,
                  );
              }
            })));
  }
}
