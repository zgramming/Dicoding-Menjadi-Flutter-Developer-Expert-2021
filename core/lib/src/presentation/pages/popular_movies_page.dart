import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../presentation/cubit/movie/movie_popular_cubit.dart';
import '../../presentation/widgets/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/popular-movie';

  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<MoviePopularCubit>().get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularCubit, MoviePopularState>(
          builder: (context, state) {
            if (state is MoviePopularLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MoviePopularLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.items[index];
                  return MovieCard(movie: movie);
                },
                itemCount: state.items.length,
              );
            } else if (state is MoviePopularErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
