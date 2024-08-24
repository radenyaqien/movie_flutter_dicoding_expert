import 'package:commonui/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/toprated/movie_toprated_state.dart';
import 'package:movies/bloc/toprated/toprated_movie_bloc.dart';
import 'package:movies/bloc/toprated/toprated_movie_event.dart';

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage({super.key});

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedMovieBloc>().add(OnFetchData()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top Rated Movies'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: BlocBuilder<TopRatedMovieBloc, MovieTopRatedState>(
                  builder: (context, state) {
                switch (state) {
                  case TopRatedMovieEmpty():
                    return const Center(
                      child: Text("Data Is Empty"),
                    );
                  case TopRatedMovieLoading():
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case TopRatedMovieError():
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );

                  case TopRatedMovieHasData():
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return MovieCard(movie);
                      },
                      itemCount: state.movies.length,
                    );
                }
              }),
            )));
  }
}
