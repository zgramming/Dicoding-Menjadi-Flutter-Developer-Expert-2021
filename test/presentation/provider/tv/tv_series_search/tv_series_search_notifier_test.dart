import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/domain/usecases/tv/search_tv_series.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_search_notifier.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late TVSeriesSearchNotifier notifier;
  late MockSearchTVSeries searchTVSeries;
  setUp(() {
    searchTVSeries = MockSearchTVSeries();
    notifier = TVSeriesSearchNotifier(searchTVSeries: searchTVSeries);
  });

  const query = 'your lie in april';
  final mockListTV = jsonListSearchTV.map((e) => TVModel.fromJson(e).toEntity()).toList();

  group('search TV Series', () {
    test('state should be loading when function success called', () {
      /// arrange
      when(searchTVSeries.execute(query)).thenAnswer((_) async => Right([]));

      /// act
      notifier.fetchTVSeriesSearch(query);

      /// assert
      expect(notifier.state, RequestState.Loading);
    });

    test('state should be loaded when function success called', () async {
      /// arrange
      when(searchTVSeries.execute(query)).thenAnswer((_) async => Right(mockListTV));

      /// act
      await notifier.fetchTVSeriesSearch(query);

      /// assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.items, mockListTV);
    });

    test('state should be error when function success called', () async {
      /// arrange
      when(searchTVSeries.execute(query)).thenAnswer((_) async => Left(ServerFailure('error')));

      /// act
      await notifier.fetchTVSeriesSearch(query);

      /// assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'error');
    });
  });
}
