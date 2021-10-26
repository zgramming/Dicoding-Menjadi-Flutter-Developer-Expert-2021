import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../presentation/cubit/tv/tv_series_popular_cubit.dart';
import '../../presentation/cubit/tv/tv_series_top_rated_cubit.dart';
import '../../presentation/widgets/tv_card_list.dart';

class TVSeeMorePage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/see-more-tv';

  final SeeMoreState seeMoreState;
  const TVSeeMorePage({
    Key? key,
    required this.seeMoreState,
  }) : super(key: key);

  @override
  _TVSeeMorePageState createState() => _TVSeeMorePageState();
}

class _TVSeeMorePageState extends State<TVSeeMorePage> {
  late String titleAppbar;
  @override
  void initState() {
    super.initState();

    if (widget.seeMoreState == SeeMoreState.Popular) {
      // Provider.of<TVSeriesPopularNotifier>(context, listen: false)..get();
      context.read<TVSeriesPopularCubit>().get();
      titleAppbar = 'Popular TV Series';
    } else {
      // Provider.of<TVSeriesTopRatedNotifier>(context, listen: false)..get();
      context.read<TVSeriesTopRatedCubit>().get();
      titleAppbar = 'Top Rated TV Series';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.seeMoreState == SeeMoreState.Popular) {}
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppbar),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(builder: (_) {
          if (widget.seeMoreState == SeeMoreState.Popular) {
            return BlocBuilder<TVSeriesPopularCubit, TVSeriesPopularState>(
              builder: (context, state) => _buildPopular(state),
            );
          } else {
            return BlocBuilder<TVSeriesTopRatedCubit, TVSeriesTopRatedState>(
              builder: (context, state) => _buildTopRated(state),
            );
          }
        }),
      ),
    );
  }

  _buildPopular(TVSeriesPopularState state) {
    if (state is TVSeriesPopularLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is TVSeriesPopularLoadedState) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final tv = state.items[index];
          return TVCard(tv: tv);
        },
        itemCount: state.items.length,
      );
    } else if (state is TVSeriesPopularErrorState) {
      return Center(
        key: const Key('error_message'),
        child: Text(state.message),
      );
    } else {
      return const SizedBox();
    }
  }

  _buildTopRated(TVSeriesTopRatedState state) {
    if (state is TVSeriesTopRatedLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is TVSeriesTopRatedLoadedState) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final tv = state.items[index];
          return TVCard(tv: tv);
        },
        itemCount: state.items.length,
      );
    } else if (state is TVSeriesTopRatedErrorState) {
      return Center(
        key: const Key('error_message'),
        child: Text(state.message),
      );
    } else {
      return const SizedBox();
    }
  }
}
