import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieflutter/common/constants.dart';
import 'package:movieflutter/common/state_enum.dart';
import 'package:movieflutter/domain/entities/series/series.dart';
// ignore: unused_import
import 'package:movieflutter/presentation/pages/popular_movies_page.dart';
import 'package:movieflutter/presentation/pages/series/now_playing_series_page.dart';
import 'package:movieflutter/presentation/pages/series/popular_series_page.dart';
import 'package:movieflutter/presentation/pages/series/search_series_page.dart';
import 'package:movieflutter/presentation/pages/series/series_detail_page.dart';
import 'package:movieflutter/presentation/pages/series/top_rated_series_page.dart';
import 'package:movieflutter/presentation/provider/series/series_list_notifier.dart';
import 'package:movieflutter/presentation/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(
        () => Provider.of<SeriesListNotifier>(context, listen: false)
          ..fetchNowPlayingSeries()
          ..fetchPopularSeries()
          ..fetchTopRatedSeries());
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
              Navigator.pushNamed(context, SearchSeriesPage.ROUTE_NAME);
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
                onTap: () => Navigator.pushNamed(
                    context, NowPlayingSeriesPage.ROUTE_NAME),
              ),
              Consumer<SeriesListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return SeriesList(data.nowPlayingSeries);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularSeriesPage.ROUTE_NAME),
              ),
              Consumer<SeriesListNotifier>(builder: (context, data, child) {
                final state = data.popularSeriesState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return SeriesList(data.popularSeries);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedSeriesPage.ROUTE_NAME),
              ),
              Consumer<SeriesListNotifier>(builder: (context, data, child) {
                final state = data.topRatedSeriesState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return SeriesList(data.topRatedSeries);
                } else {
                  return const Text('Failed');
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
                  SeriesDetailPage.ROUTE_NAME,
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
