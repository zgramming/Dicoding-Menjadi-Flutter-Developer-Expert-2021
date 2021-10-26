import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:global_template/global_template.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/tv/tv_crew.dart';
import '../../domain/entities/tv/tv_detail.dart';
import '../../domain/entities/tv/tv_season.dart';
import '../../presentation/cubit/tv/tv_series_episode_season_cubit.dart';

class TVEpisodeSeasonPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/episode-season-tv';

  /// [tv, season]
  final Map<String, dynamic> param;

  const TVEpisodeSeasonPage({
    Key? key,
    required this.param,
  }) : super(key: key);

  @override
  State<TVEpisodeSeasonPage> createState() => _TVEpisodeSeasonPageState();
}

class _TVEpisodeSeasonPageState extends State<TVEpisodeSeasonPage> {
  late final TVDetail tv;
  late final Season season;
  @override
  void initState() {
    super.initState();
    tv = widget.param['tv'];
    season = widget.param['season'];

    Future.microtask(() {
      context.read<TVSeriesEpisodeSeasonCubit>().get(
            id: tv.id,
            seasonNumber: season.seasonNumber,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('${tv.name} | ${season.name}'),
      ),
      body: SizedBox.expand(
        child: BlocBuilder<TVSeriesEpisodeSeasonCubit, TVSeriesEpisodeSeasonState>(
          builder: (context, state) {
            if (state is TVSeriesEpisodeSeasonLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TVSeriesEpisodeSeasonLoadedState) {
              if (state.items.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('Episode untuk ${tv.name} ${season.name} tidak ditemukan'),
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.items.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  final episode = state.items[index];
                  return ListTile(
                    leading: SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: '$BASE_IMAGE_URL/${episode.stillPath}',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: const BoxDecoration(color: kMikadoYellow),
                            child: const FittedBox(
                              child: Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text('${episode.name}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),
                        Builder(builder: (_) {
                          DateTime? date;
                          if (episode.airDate != null) {
                            date = episode.airDate;
                          }
                          if (date == null) {
                            return const SizedBox();
                          }

                          return Text(
                            GlobalFunction.formatYMDS(date),
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12.0,
                            ),
                          );
                        }),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RatingBarIndicator(
                              rating: (episode.voteAverage ?? 0) / 2,
                              itemCount: 5,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: kMikadoYellow,
                              ),
                              itemSize: 24,
                            ),
                            const SizedBox(width: 5),
                            Text((episode.voteAverage ?? 0).toStringAsFixed(1)),
                          ],
                        )
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () async {
                        await showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15.0),
                            ),
                          ),
                          context: context,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Crew',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ShowCrew(crews: episode.crew),
                                const SizedBox(height: 20),
                                const Text(
                                  'Guest Start',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ShowCrew(crews: episode.guestStars),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundColor: kMikadoYellow,
                        foregroundColor: Colors.white,
                        child: Icon(Icons.person),
                      ),
                    ),
                  );
                },
              );
            } else if (state is TVSeriesEpisodeSeasonErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class ShowCrew extends StatelessWidget {
  const ShowCrew({
    Key? key,
    required this.crews,
  }) : super(key: key);

  final List<Crew> crews;
  @override
  Widget build(BuildContext context) {
    if (crews.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(child: Text('People not found')),
      );
    }
    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemExtent: 100,
        itemCount: crews.length,
        itemBuilder: (context, index) {
          final crew = crews[index];
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: '$BASE_IMAGE_URL/${crew.profilePath}',
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          color: kMikadoYellow,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${crew.name}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
