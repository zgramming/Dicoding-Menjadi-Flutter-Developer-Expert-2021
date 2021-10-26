import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/src/domain/entities/tv/tv.dart';
import 'package:core/src/domain/usecases/tv/get_recommendation_tv_series.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVRepository repository;
  late GetRecommendationTVSeries usecase;

  setUp(() async {
    repository = MockTVRepository();
    usecase = GetRecommendationTVSeries(repository: repository);
  });
  const id = 1;
  const list = <TV>[];

  test(
    'should get list of tv series from repository',
    () async {
      /// arrange
      when(repository.getRecommendationTVSeries(id)).thenAnswer((_) async => const Right(list));

      /// act
      final result = await usecase.execute(id);

      /// assert
      expect(result, const Right(list));
    },
  );
}
