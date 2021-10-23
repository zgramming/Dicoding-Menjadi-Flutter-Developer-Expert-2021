import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/src/domain/entities/tv/tv.dart';
import 'package:ditonton/src/domain/usecases/tv/get_watchlist_tv_series.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVRepository repository;
  late GetWatchlistTVSeries usecase;

  setUp(() {
    repository = MockTVRepository();
    usecase = GetWatchlistTVSeries(repository: repository);
  });

  final list = <TV>[];
  test(
    'should get watchlist from repository',
    () async {
      /// arrange
      when(repository.getWatchlistTVSeries()).thenAnswer((realInvocation) async => Right(list));

      /// act
      final result = await usecase.execute();

      /// assert
      expect(result, Right(list));
    },
  );
}
