import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/routes.dart';
import 'package:commonui/constants.dart';
import 'package:commonui/widgets/custom_drawer.dart';
import 'package:domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/nowplaying/movie_nowplaying_bloc.dart';
import 'package:movies/bloc/nowplaying/movie_nowplaying_event.dart';
import 'package:movies/bloc/nowplaying/movie_nowplaying_state.dart';
import 'package:movies/bloc/popular/movie_toprated_state.dart';
import 'package:movies/bloc/popular/popular_movie_bloc.dart';
import 'package:movies/bloc/popular/popular_movie_event.dart';
import 'package:movies/bloc/toprated/movie_toprated_state.dart';
import 'package:movies/bloc/toprated/toprated_movie_bloc.dart';
import 'package:movies/bloc/toprated/toprated_movie_event.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MoviePopularBloc>().add(OnFetchDataPopular());
      context.read<MovieNowPlayingBloc>().add(OnFetchDataNowPlaying());
      context.read<TopRatedMovieBloc>().add(OnFetchData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('movieflutter'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchMovieRoute);
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
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                  builder: (ctx, state) {
                switch (state) {
                  case NowPlayingMovieEmpty():
                    return const Center(
                      child: Text("Data Is Empty"),
                    );
                  case NowPlayingMovieLoading():
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case NowPlayingMovieError():
                    return Center(
                      child: Text(state.message),
                    );
                  case NowPlayingMovieHasData():
                    return MovieList(state.movies);
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularMovieRoute),
              ),
              BlocBuilder<MoviePopularBloc, MoviePopularState>(
                  builder: (ctx, state) {
                switch (state) {
                  case PopularMovieEmpty():
                    return const Center(
                      child: Text("Data Is Empty"),
                    );
                  case PopularMovieLoading():
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case PopularMovieError():
                    return Center(
                      child: Text(state.message),
                    );
                  case PopularMovieHasData():
                    return MovieList(state.movies);
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, topRatedMovieRoute),
              ),
              BlocBuilder<TopRatedMovieBloc, MovieTopRatedState>(
                  builder: (ctx, state) {
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
                      child: Text(state.message),
                    );
                  case TopRatedMovieHasData():
                    return MovieList(state.movies);
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

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  detailMovieRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
