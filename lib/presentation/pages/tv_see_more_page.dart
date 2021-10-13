import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_popular_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_top_rated_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';

class TVSeeMorePage extends StatefulWidget {
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
      Provider.of<TVSeriesPopularNotifier>(context, listen: false)..get();
      titleAppbar = 'Popular TV Series';
    } else {
      Provider.of<TVSeriesTopRatedNotifier>(context, listen: false)..get();
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
            return Consumer<TVSeriesPopularNotifier>(
              builder: (context, data, child) => _buildPopular(data),
            );
          } else {
            return Consumer<TVSeriesTopRatedNotifier>(
              builder: (context, data, child) => _buildTopRated(data),
            );
          }
        }),
      ),
    );
  }

  _buildPopular(TVSeriesPopularNotifier data) {
    if (data.state == RequestState.Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (data.state == RequestState.Loaded) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final tv = data.items[index];
          return TVCard(tv: tv);
        },
        itemCount: data.items.length,
      );
    } else {
      return Center(
        key: Key('error_message'),
        child: Text(data.message),
      );
    }
  }

  _buildTopRated(TVSeriesTopRatedNotifier data) {
    if (data.state == RequestState.Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (data.state == RequestState.Loaded) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final tv = data.items[index];
          return TVCard(tv: tv);
        },
        itemCount: data.items.length,
      );
    } else {
      return Center(
        key: Key('error_message'),
        child: Text(data.message),
      );
    }
  }
}
