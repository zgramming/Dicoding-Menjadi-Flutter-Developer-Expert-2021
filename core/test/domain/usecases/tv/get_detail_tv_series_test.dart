import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/src/domain/usecases/tv/get_detail_tv_series.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVRepository repository;
  late GetDetailTVSeries usecase;

  setUp(() {
    repository = MockTVRepository();
    usecase = GetDetailTVSeries(repository: repository);
  });
  const tId = 1;
  test(
    'should get tv series detail from the repository',
    () async {
      /// arrange
      when(repository.getDetailTVSeries(tId)).thenAnswer((_) async => const Right(testTVDetail));

      /// act
      final result = await usecase.execute(tId);

      /// assert
      expect(result, const Right(testTVDetail));
    },
  );
}
