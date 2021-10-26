import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/src/data/models/tv/tv_detail/tv_detail_model.dart';
import 'package:ditonton/src/data/models/tv/tv_episode/tv_episode_model.dart';
import 'package:ditonton/src/domain/usecases/tv/get_episode_season_tv_series.dart';
import 'package:ditonton/src/presentation/provider/tv/tv_series_episode_season_notifier.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_episode_season_notifier_test.mocks.dart';

@GenerateMocks([GetEpisodeSeasonTVSeries])
void main() {
  late TVSeriesEpisodeSeasonNotifier notifier;

  late MockGetEpisodeSeasonTVSeries getEpisodeSeasonTVSeries;
  setUp(() {
    getEpisodeSeasonTVSeries = MockGetEpisodeSeasonTVSeries();
    notifier = TVSeriesEpisodeSeasonNotifier(
      getEpisodeSeasonTVSeries: getEpisodeSeasonTVSeries,
    );
  });

  final mockTVDetail = TVDetailResponse.fromJson(jsonDetailTV).toEntity();
  final mockEpisodeSeasonTV =
      jsonListEpisodeSeasonTV.map((e) => EpisodeModel.fromJson(e).toEntity()).toList();

  group('Episode Season TV Series', () {
    test('state should change to loading when function called', () async {
      /// arrange
      when(getEpisodeSeasonTVSeries.execute(id: mockTVDetail.id, seasonNumber: 1))
          .thenAnswer((_) async => Right(mockEpisodeSeasonTV));

      /// act
      notifier.get(id: mockTVDetail.id, seasonNumber: 1);

      /// assert
      expect(notifier.state, RequestState.Loading);
    });

    test('state should change to loaded when function called', () async {
      /// arrange
      when(getEpisodeSeasonTVSeries.execute(id: mockTVDetail.id, seasonNumber: 1))
          .thenAnswer((_) async => Right(mockEpisodeSeasonTV));

      /// act
      await notifier.get(id: mockTVDetail.id, seasonNumber: 1);

      /// assert
      expect(notifier.items, mockEpisodeSeasonTV);
      expect(notifier.state, RequestState.Loaded);
    });

    test(
      'state should change to error when function called',
      () async {
        /// arrange
        when(getEpisodeSeasonTVSeries.execute(id: mockTVDetail.id, seasonNumber: 1))
            .thenAnswer((_) async => Left(ServerFailure('error')));

        /// act
        await notifier.get(id: mockTVDetail.id, seasonNumber: 1);

        /// assert
        expect(notifier.message, 'error');
        expect(notifier.state, RequestState.Error);
      },
    );
  });
}
