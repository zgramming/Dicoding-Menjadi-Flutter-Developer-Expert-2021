import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:core/src/domain/entities/tv/tv.dart';
import 'package:watchlist/watchlist.dart';

import 'get_watchlist_tv_series_test.mocks.dart';

@GenerateMocks([TVRepository])
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
