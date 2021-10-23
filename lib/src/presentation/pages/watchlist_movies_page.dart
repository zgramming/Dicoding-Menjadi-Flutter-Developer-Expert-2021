import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../presentation/cubit/movie/movie_watchlist_cubit.dart';
import '../../presentation/cubit/tv/tv_series_watchlist_cubit.dart';
import '../../presentation/widgets/movie_card_list.dart';
import '../../presentation/widgets/tv_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        // Provider.of<WatchlistMovieNotifier>(context, listen: false).fetchWatchlistMovies();
        // Provider.of<TVSeriesWatchlistNotifier>(context, listen: false).get();
        context.read<TVSeriesWatchlistCubit>().get();
        context.read<MovieWatchlistCubit>().get();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TabBar(
                indicatorColor: kMikadoYellow,
                tabs: [
                  Tab(child: Text('Movie')),
                  Tab(child: Text('TV Series')),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  children: [
                    BlocBuilder<MovieWatchlistCubit, MovieWatchlistState>(
                      builder: (context, state) => _buildWatchlistMovie(state),
                    ),
                    BlocBuilder<TVSeriesWatchlistCubit, TVSeriesWatchlistState>(
                      builder: (context, state) => _buildWatchlistTVSeries(state),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWatchlistMovie(MovieWatchlistState state) {
    if (state is MovieWatchlistLoadingState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is MovieWatchlistLoadedState) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final movie = state.items[index];
          return MovieCard(movie);
        },
        itemCount: state.items.length,
      );
    } else if (state is MovieWatchlistErrorState) {
      return Center(
        key: Key('error_message'),
        child: Text(state.message),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _buildWatchlistTVSeries(TVSeriesWatchlistState state) {
    if (state is TVSeriesWatchlistLoadingState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is TVSeriesWatchlistLoadedState) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final tv = state.items[index];
          return TVCard(tv: tv);
        },
        itemCount: state.items.length,
      );
    } else if (state is TVSeriesWatchlistErrorState) {
      return Center(
        key: Key('error_message'),
        child: Text(state.message),
      );
    } else {
      return SizedBox();
    }
  }
}
