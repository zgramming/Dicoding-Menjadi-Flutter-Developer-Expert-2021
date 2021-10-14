import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/domain/usecases/tv/get_airing_today_tv_series.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_airing_today_notifier.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_airing_today_notifier_test.mocks.dart';

@GenerateMocks([GetAiringTodayTVSeries])
void main() {
  late MockGetAiringTodayTVSeries getAiringTodayTVSeries;
  late TVSeriesAiringTodayNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    getAiringTodayTVSeries = MockGetAiringTodayTVSeries();
    notifier = TVSeriesAiringTodayNotifier(getAiringTodayTVSeries: getAiringTodayTVSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final mockAiringTodayTV =
      jsonListAiringTodayTV.map((e) => TVModel.fromJson(e).toEntity()).toList();

  test(
    'should change state to loading when usecase is called',
    () async {
      /// arrange
      when(getAiringTodayTVSeries.execute()).thenAnswer((_) async => Right(mockAiringTodayTV));

      /// act
      notifier.get();

      /// assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    },
  );

  test(
    'should get tv series when success called API',
    () async {
      /// arrange
      when(getAiringTodayTVSeries.execute()).thenAnswer((_) async => Right(mockAiringTodayTV));

      /// act
      await notifier.get();

      /// assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.items, mockAiringTodayTV);
      expect(listenerCallCount, 2);
    },
  );

  test(
    'should return error when data is unsuccess called API',
    () async {
      /// arrange
      when(getAiringTodayTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('server error')));

      /// act
      await notifier.get();

      /// assert
      expect(notifier.message, 'server error');
      expect(notifier.state, RequestState.Error);
      expect(listenerCallCount, 2);
    },
  );
}
