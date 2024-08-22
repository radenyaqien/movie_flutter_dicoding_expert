import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/routes.dart';
import 'package:commonui/constants.dart';
import 'package:domain/entities/genre.dart';
import 'package:domain/entities/series/series_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:series/bloc/detail/detail_tv_series_bloc.dart';
import 'package:series/bloc/recommendation/recommendation_tv_series_bloc.dart';
import 'package:series/bloc/watchlist/watchlist_tv_series_bloc.dart';

class SeriesDetailPage extends StatefulWidget {
  final int id;

  const SeriesDetailPage({super.key, required this.id});

  @override
  _SeriesDetailPageState createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("tv series id asas${widget.id}");
    }

    Future.microtask(() {
      context.read<DetailTvSeriesBloc>().add(FetchDetailTvSeries(widget.id));
      context
          .read<WatchlistTvSeriesBloc>()
          .add(LoadWatchlistStatusTvSeries(id: widget.id));
      context
          .read<RecommendationTvSeriesBloc>()
          .add(FetchRecommendationTvSeries(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTvShowAddedToWatchlist =
        context.select<WatchlistTvSeriesBloc, bool>((bloc) =>
            (bloc.state is WatchlistTvSeriesIsAdded)
                ? (bloc.state as WatchlistTvSeriesIsAdded).isAdded
                : false);

    return Scaffold(
      body: BlocBuilder<DetailTvSeriesBloc, DetailTvSeriesState>(
          builder: (context, state) {
        if (state is DetailTvSeriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DetailTvSeriesHasData) {
          final series = state.seriesItem;
          return SafeArea(
            child: DetailSeriesContent(
              series,
              isTvShowAddedToWatchlist,
            ),
          );
        } else if (state is DetailTvSeriesError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Text("No Data Displayed");
        }
      }),
    );
  }
}

class DetailSeriesContent extends StatefulWidget {
  final SeriesDetail series;

  bool isAddedWatchlist;

  DetailSeriesContent(this.series, this.isAddedWatchlist, {super.key});

  @override
  State<DetailSeriesContent> createState() => _DetailSeriesContentState();
}

class _DetailSeriesContentState extends State<DetailSeriesContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.series.posterPath}',
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
                              widget.series.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  context
                                      .read<WatchlistTvSeriesBloc>()
                                      .add(AddSeriesWatchList(widget.series));
                                } else {
                                  context.read<WatchlistTvSeriesBloc>().add(
                                      RemoveseriesWatchList(widget.series));
                                }

                                final state =
                                    BlocProvider.of<WatchlistTvSeriesBloc>(
                                            context)
                                        .state;
                                String message = "";

                                if (state is WatchlistTvSeriesIsAdded) {
                                  final isAdded = state.isAdded;
                                  message = isAdded == false
                                      ? "Add Successfully"
                                      : "Remove SuccessFully";
                                } else {
                                  message = !widget.isAddedWatchlist
                                      ? "Add Successfully"
                                      : "Remove SuccessFully";
                                }

                                if (message == "Add Successfully" ||
                                    message == "Remove SuccessFully") {
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
                                setState(() {
                                  widget.isAddedWatchlist =
                                      !widget.isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.series.genres),
                            ),
                            // Text(
                            //   _showDuration(series.runtime),
                            // ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.series.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.series.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.series.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTvSeriesBloc,
                                RecommendationTvSeriesState>(
                              builder: (context, state) {
                                if (state is RecommendationTvSeriesLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is RecommendationTvSeriesHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.series[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                detailSeriesRoute,
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
                                      itemCount: state.series.length,
                                    ),
                                  );
                                } else if (state
                                    is RecommendationTvSeriesError) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                } else {
                                  return const Text("No Data Displayed");
                                }
                              },
                            ),
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
}
