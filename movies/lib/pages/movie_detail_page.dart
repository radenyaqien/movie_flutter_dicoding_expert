import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/routes.dart';
import 'package:commonui/constants.dart';
import 'package:domain/entities/genre.dart';
import 'package:domain/entities/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/bloc/detail/movie_detail_bloc.dart';
import 'package:movies/bloc/detail/movie_detail_event.dart';
import 'package:movies/bloc/detail/movie_detail_state.dart';
import 'package:movies/bloc/recommendation/recommendation_movie_bloc.dart';
import 'package:movies/bloc/recommendation/recommendation_movie_event.dart';
import 'package:movies/bloc/recommendation/recommendation_movie_state.dart';
import 'package:movies/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:movies/bloc/watchlist/movie_watchlist_event.dart';
import 'package:movies/bloc/watchlist/movie_watchlist_state.dart';
import 'package:provider/provider.dart';

import '../bloc/movie_detail_notifier.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;

  const MovieDetailPage({super.key, required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailMovieBloc>().add(FetchDetailMovie(widget.id));
      context
          .read<MovieWatchListBloc>()
          .add(OnCheckStatusWatchList(id: widget.id));
      context
          .read<RecommendationMovieBloc>()
          .add(FetchRecommendationMovie(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMovieAddedToWatchlist = context.select<MovieWatchListBloc, bool>(
        (bloc) => (bloc.state is WatchlistMovieIsAdded)
            ? (bloc.state as WatchlistMovieIsAdded).isAdded
            : false);
    return Scaffold(body:
        BlocBuilder<DetailMovieBloc, DetailMovieState>(builder: (ctx, state) {
      switch (state) {
        case DetailMovieEmpty():
        case DetailMovieLoading():
          return const Center(
            child: CircularProgressIndicator(),
          );
        case DetailMovieError():
          return Text(state.message);
        case DetailMovieHasData():
          return SafeArea(
            child: DetailContent(
              state.movie,
              isMovieAddedToWatchlist,
            ),
          );
      }
    }));
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final bool isAddedWatchlist;

  const DetailContent(this.movie, this.isAddedWatchlist, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  await Provider.of<MovieDetailNotifier>(
                                          context,
                                          listen: false)
                                      .addWatchlist(movie);
                                } else {
                                  await Provider.of<MovieDetailNotifier>(
                                          context,
                                          listen: false)
                                      .removeFromWatchlist(movie);
                                }

                                final message =
                                    Provider.of<MovieDetailNotifier>(context,
                                            listen: false)
                                        .watchlistMessage;

                                if (message ==
                                        MovieDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        MovieDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationMovieBloc,
                                    RecommendationMovieState>(
                                builder: (ctx, state) {
                              switch (state) {
                                case RecommendationMovieEmpty():
                                  return Text("Data Is empty");
                                case RecommendationMovieLoading():
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                case RecommendationMovieError():
                                  return Text(state.message);
                                case RecommendationMovieHasData():
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.movie[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                detailMovieRoute,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.movie.length,
                                    ),
                                  );
                              }
                            })
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
