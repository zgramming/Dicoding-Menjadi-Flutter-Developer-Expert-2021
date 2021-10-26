// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton/test/presentation/cubit/tv/tv_series_detail/tv_series_detail_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/src/domain/entities/tv/tv_detail.dart' as _i7;
import 'package:ditonton/src/domain/repositories/tv_repository.dart' as _i2;
import 'package:ditonton/src/domain/usecases/tv/get_detail_tv_series.dart'
    as _i4;
import 'package:ditonton/src/domain/usecases/tv/get_watch_list_status_tv_series.dart'
    as _i8;
import 'package:ditonton/src/domain/usecases/tv/remove_watchlist_tv_series.dart'
    as _i10;
import 'package:ditonton/src/domain/usecases/tv/save_watchlist_tv_series.dart'
    as _i9;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTVRepository_0 extends _i1.Fake implements _i2.TVRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetDetailTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetDetailTVSeries extends _i1.Mock implements _i4.GetDetailTVSeries {
  MockGetDetailTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository_0()) as _i2.TVRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TVDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i3.Either<_i6.Failure, _i7.TVDetail>>.value(
                  _FakeEither_1<_i6.Failure, _i7.TVDetail>()))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.TVDetail>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetWatchListStatusTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusTVSeries extends _i1.Mock
    implements _i8.GetWatchListStatusTVSeries {
  MockGetWatchListStatusTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository_0()) as _i2.TVRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SaveWatchlistTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTVSeries extends _i1.Mock
    implements _i9.SaveWatchlistTVSeries {
  MockSaveWatchlistTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository_0()) as _i2.TVRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i7.TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [RemoveWatchlistTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTVSeries extends _i1.Mock
    implements _i10.RemoveWatchlistTVSeries {
  MockRemoveWatchlistTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository_0()) as _i2.TVRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i7.TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
  @override
  String toString() => super.toString();
}
