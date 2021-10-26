import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/src/data/models/tv/tv_model.dart';
import 'package:ditonton/src/domain/usecases/tv/get_popular_tv_series.dart';
import 'package:ditonton/src/presentation/provider/tv/tv_series_popular_notifier.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_popular_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late TVSeriesPopularNotifier notifier;
  late MockGetPopularTVSeries getPopularTVSeries;

  setUp(() {
    getPopularTVSeries = MockGetPopularTVSeries();
    notifier = TVSeriesPopularNotifier(getPopularTVSeries: getPopularTVSeries);
  });

  final mockListTV = jsonListSearchTV
      .map(
        (e) => TVModel.fromJson(Map<String, dynamic>.from(e as Map)).toEntity(),
      )
      .toList();

  group(
    'Popular TV Series',
    () {
      test(
        'state should be loading when function success called ',
        () async {
          /// arrange
          when(getPopularTVSeries.execute()).thenAnswer((_) async => Right(mockListTV));

          /// act
          notifier.get();

          /// assert
          expect(notifier.state, RequestState.Loading);
        },
      );

      test('state should be loaded when function success called', () async {
        /// arrange
        when(getPopularTVSeries.execute()).thenAnswer((_) async => Right(mockListTV));

        /// act
        await notifier.get();

        /// assert
        expect(notifier.items, mockListTV);
        expect(notifier.state, RequestState.Loaded);
      });

      test('state should be error when funtion success called', () async {
        /// arrange
        when(getPopularTVSeries.execute()).thenAnswer((_) async => Left(ServerFailure('error')));

        /// act
        await notifier.get();

        /// assert
        expect(notifier.message, 'error');
        expect(notifier.state, RequestState.Error);
      });
    },
  );
}
