import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/tv/tv.dart';
import '../../presentation/cubit/movie/movie_top_rated_cubit.dart';
import '../../presentation/cubit/movie/movie_now_playing_cubit.dart';
import '../../presentation/cubit/movie/movie_popular_cubit.dart';
import '../../presentation/cubit/tv/tv_series_airing_today_cubit.dart';
import '../../presentation/cubit/tv/tv_series_popular_cubit.dart';
import '../../presentation/cubit/tv/tv_series_top_rated_cubit.dart';
import '../../presentation/pages/about_page.dart';
import '../../presentation/pages/movie_detail_page.dart';
import '../../presentation/pages/popular_movies_page.dart';
import '../../presentation/pages/search_page.dart';
import '../../presentation/pages/top_rated_movies_page.dart';
import '../../presentation/pages/tv_detail_page.dart';
import '../../presentation/pages/tv_see_more_page.dart';
import '../../presentation/pages/watchlist_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> with SingleTickerProviderStateMixin {
  late final TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

    Future.microtask(() {
      context.read<MovieNowPlayingCubit>().get();
      context.read<MoviePopularCubit>().get();
      context.read<MovieTopRatedCubit>().get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TabBar(
                controller: _controller,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: kMikadoYellow,
                ),
                tabs: [
                  Tab(child: Text('Movie')),
                  Tab(child: Text('TV Series')),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(
                  controller: _controller,
                  children: [
                    MovieTabMenu(),
                    TVSeriesTabMenu(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TVSeriesTabMenu extends StatefulWidget {
  const TVSeriesTabMenu({Key? key}) : super(key: key);

  @override
  State<TVSeriesTabMenu> createState() => _TVSeriesTabMenuState();
}

class _TVSeriesTabMenuState extends State<TVSeriesTabMenu> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TVSeriesAiringTodayCubit>().get();
      context.read<TVSeriesTopRatedCubit>().get();
      context.read<TVSeriesPopularCubit>().get();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Airing Today',
            style: kHeading6,
          ),
          BlocBuilder<TVSeriesAiringTodayCubit, TVSeriesAiringTodayState>(
            builder: (context, state) {
              if (state is TVSeriesAiringTodayLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is TVSeriesAiringTodayLoaded) {
                return TVList(state.items);
              }

              if (state is TVSeriesAiringTodayError) {
                return Center(child: Text(state.message));
              }

              return SizedBox();
            },
          ),
          BuildSubHeading(
            title: 'Popular',
            onTap: () => Navigator.pushNamed(
              context,
              TVSeeMorePage.ROUTE_NAME,
              arguments: SeeMoreState.Popular,
            ),
          ),
          BlocBuilder<TVSeriesPopularCubit, TVSeriesPopularState>(
            builder: (context, state) {
              if (state is TVSeriesPopularLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TVSeriesPopularLoadedState) {
                return TVList(state.items);
              } else if (state is TVSeriesPopularErrorState) {
                return Center(child: Text('${state.message}'));
              } else {
                return SizedBox();
              }
            },
          ),
          BuildSubHeading(
            title: 'Top Rated',
            onTap: () => Navigator.pushNamed(
              context,
              TVSeeMorePage.ROUTE_NAME,
              arguments: SeeMoreState.TopRated,
            ),
          ),
          BlocBuilder<TVSeriesTopRatedCubit, TVSeriesTopRatedState>(
            builder: (context, state) {
              if (state is TVSeriesTopRatedLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TVSeriesTopRatedLoadedState) {
                return TVList(state.items);
              } else if (state is TVSeriesTopRatedErrorState) {
                return Center(child: Text(state.message));
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MovieTabMenu extends StatelessWidget {
  const MovieTabMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Now Playing',
            style: kHeading6,
          ),
          BlocBuilder<MovieNowPlayingCubit, MovieNowPlayingState>(
            builder: (context, state) {
              if (state is MovieNowPlayingLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MovieNowPlayingLoadedState) {
                return MovieList(state.items);
              } else if (state is MovieNowPlayingErrorState) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox();
              }
            },
          ),
          BuildSubHeading(
            title: 'Popular',
            onTap: () => Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
          ),
          BlocBuilder<MoviePopularCubit, MoviePopularState>(builder: (context, state) {
            if (state is MoviePopularLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MoviePopularLoadedState) {
              return MovieList(state.items);
            } else if (state is MoviePopularErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          }),
          BuildSubHeading(
            title: 'Top Rated',
            onTap: () => Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
          ),
          BlocBuilder<MovieTopRatedCubit, MovieTopRatedState>(builder: (context, state) {
            if (state is MovieTopRatedLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MovieTopRatedLoadedState) {
              return MovieList(state.items);
            } else if (state is MovieTopRatedErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
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

class TVList extends StatelessWidget {
  final List<TV> items;

  TVList(this.items);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = items[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}

class BuildSubHeading extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const BuildSubHeading({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}