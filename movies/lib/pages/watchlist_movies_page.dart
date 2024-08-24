import 'package:commonui/utils.dart';
import 'package:commonui/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:movies/bloc/watchlist/movie_watchlist_event.dart';
import 'package:movies/bloc/watchlist/movie_watchlist_state.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({super.key});

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<MovieWatchListBloc>().add(const OnGetWatchListMovie()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<MovieWatchListBloc>().add(const OnGetWatchListMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<MovieWatchListBloc, MovieWatchListState>(
              builder: (context, state) {
            switch (state) {
              case WatchlistMovieEmpty():
                return const Center(
                  child: Text("Empty"),
                );
              case WatchlistMovieLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case WatchlistMovieError():
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );

              case WatchlistMovieHasData():
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return MovieCard(movie);
                    },
                    itemCount: state.movies.length,
                  ),
                );
              default:
                return const Center(
                  child: Text("Save Your Watch List Movie Here"),
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
