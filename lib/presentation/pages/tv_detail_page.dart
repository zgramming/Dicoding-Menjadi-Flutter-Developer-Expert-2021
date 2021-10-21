import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/presentation/cubit/tv/tv_series_detail_cubit.dart';
import 'package:ditonton/presentation/pages/tv_episode_season_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_recommendations_notifier.dart';
import '../cubit/tv/tv_series_recommendations_cubit.dart';

class TVDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;

  const TVDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVSeriesDetailCubit>().get(widget.id);
      context.read<TVSeriesRecommendationsCubit>().get(widget.id);
      // Provider.of<TVSeriesRecommendationsNotifier>(context, listen: false)..get(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: BlocBuilder<TVSeriesDetailCubit, TVSeriesDetailState>(
          builder: (_, state) {
            if (state is TVSeriesDetailLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TVSeriesDetailLoadedState) {
              return DetailContent(tv: state.tv);
            } else if (state is TVSeriesDetailErrorState) {
              return Center(child: Text(state.message));
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TVDetail tv;
  const DetailContent({
    Key? key,
    required this.tv,
  }) : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TVSeriesDetailCubit>().getWatchlistStatus(widget.tv.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
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
                              widget.tv.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<TVSeriesDetailCubit, TVSeriesDetailState>(
                              builder: (_, state) {
                                if (state is TVSeriesDetailLoadedState) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (!state.isAddedToWatchlist) {
                                        await context
                                            .read<TVSeriesDetailCubit>()
                                            .saveWatchlist(widget.tv);
                                      } else {
                                        await context
                                            .read<TVSeriesDetailCubit>()
                                            .removeWatchlist(widget.tv);
                                      }

                                      final watchlist = (context.read<TVSeriesDetailCubit>().state
                                          as TVSeriesDetailLoadedState);

                                      if (watchlist.messageWatchlist ==
                                              TVSeriesDetailNotifier.watchlistAddSuccessMessage ||
                                          watchlist.messageWatchlist ==
                                              TVSeriesDetailNotifier
                                                  .watchlistRemoveSuccessMessage) {
                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(watchlist.messageWatchlist),
                                          ),
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text(watchlist.messageWatchlist),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        state.isAddedToWatchlist
                                            ? Icon(Icons.check)
                                            : Icon(Icons.add),
                                        Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                            Text(
                              _showGenres(widget.tv.genres),
                            ),
                            Text(
                              widget.tv.episodeRunTime.isEmpty
                                  ? ''
                                  : '${_showDuration(widget.tv.episodeRunTime.first)}/episode',
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tv.overview ?? '',
                            ),
                            if (widget.tv.seasons.isNotEmpty) ...[
                              SizedBox(height: 16),
                              Text(
                                'Season',
                                style: kHeading6,
                              ),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.tv.seasons.length,
                                  itemExtent: 120,
                                  itemBuilder: (context, index) {
                                    final season = widget.tv.seasons[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            TVEpisodeSeasonPage.ROUTE_NAME,
                                            arguments: {'tv': widget.tv, 'season': season},
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w500${season.posterPath}',
                                            placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                            errorWidget: (context, url, error) {
                                              return Container(
                                                height: double.infinity,
                                                color: kMikadoYellow,
                                                child: Center(
                                                  child: FittedBox(
                                                    child: Transform.rotate(
                                                      angle: 45,
                                                      child: Text(
                                                        '${season.name}',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TVSeriesRecommendationsCubit, TVSeriesRecommendationsState>(
                              builder: (context, state) {
                                if (state is TVSeriesRecommendationsLoadingState) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TVSeriesRecommendationsErrorState) {
                                  return Text(state.message);
                                } else if (state is TVSeriesRecommendationsLoadedState) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final recommendation = state.items[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVDetailPage.ROUTE_NAME,
                                                arguments: recommendation.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${recommendation.posterPath}',
                                                placeholder: (context, url) => Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                                errorWidget: (context, url, error) =>
                                                    Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.items.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
