import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/src/domain/entities/tv/tv.dart';
import 'package:core/src/domain/usecases/tv/search_tv_series.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVRepository repository;
  late SearchTVSeries usecase;

  setUp(() {
    repository = MockTVRepository();
    usecase = SearchTVSeries(repository: repository);
  });

  const query = 'your lie in april';
  const list = <TV>[];
  test('should get list of TV Series from repository', () async {
    /// arrange
    when(repository.searchTVSeries(query)).thenAnswer((_) async => const Right(list));

    /// act
    final result = await usecase.execute(query);

    /// assert
    expect(result, const Right(list));
  });
}
