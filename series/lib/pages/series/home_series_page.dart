import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/routes.dart';
import 'package:commonui/constants.dart';
import 'package:commonui/widgets/custom_drawer.dart';
import 'package:domain/entities/series/series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/bloc/now_playing/now_playing_bloc.dart';
import 'package:series/bloc/now_playing/nowplaying_event.dart';
import 'package:series/bloc/now_playing/nowplaying_state.dart';
import 'package:series/bloc/popular_series/popular_series_bloc.dart';
import 'package:series/bloc/popular_series/popular_series_event.dart';
import 'package:series/bloc/popular_series/popular_series_state.dart';
import 'package:series/bloc/toprated/toprated_series_bloc.dart';
import 'package:series/bloc/toprated/toprated_series_event.dart';
import 'package:series/bloc/toprated/toprated_series_state.dart';

class HomeSeriesPage extends StatefulWidget {
  static const String ROUTE_NAME = "/HomeSeriesPage";

  const HomeSeriesPage({super.key});

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedSeriesBloc>().add(FetchTopRatedSeries());
      context.read<PopularSeriesBloc>().add(FetchPopularSeries());
      context.read<NowPlayingBloc>().add(FetchNowPlayingTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchSeriesRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, nowPlayingSeriesRoute),
              ),
              BlocBuilder<NowPlayingBloc, NowPlayingSeriesState>(
                  builder: (context, state) {
                if (state is NowPlayingSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingSeriesHasData) {
                  return SeriesList(state.series);
                } else if (state is NowPlayingSeriesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text('No data is displayed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularSeriesRoute),
              ),
              BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
                  builder: (context, state) {
                if (state is PopularSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularSeriesHasData) {
                  return SeriesList(state.series);
                } else if (state is PopularSeriesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text("No Data Displayed");
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, topRatedSeriesRoute),
              ),
              BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
                  builder: (context, state) {
                if (state is TopRatedSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedSeriesHasData) {
                  return SeriesList(state.series);
                } else if (state is TopRatedSeriesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text("No Data Displayed");
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class SeriesList extends StatelessWidget {
  final List<Series> series;

  const SeriesList(this.series, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvseri = series[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  detailSeriesRoute,
                  arguments: tvseri.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvseri.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: series.length,
      ),
    );
  }
}
