import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../cubit/movie/movie_top_rated_cubit.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<MovieTopRatedCubit>().get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieTopRatedCubit, MovieTopRatedState>(
          builder: (context, state) {
            if (state is MovieTopRatedLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MovieTopRatedLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.items[index];
                  return MovieCard(movie);
                },
                itemCount: state.items.length,
              );
            } else if (state is MovieTopRatedErrorState) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
