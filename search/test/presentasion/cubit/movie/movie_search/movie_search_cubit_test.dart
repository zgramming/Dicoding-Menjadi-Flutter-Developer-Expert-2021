import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:core/src/domain/entities/movie.dart';
import 'package:search/search.dart';

import 'movie_search_cubit_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MovieSearchCubit cubit;
  setUp(() {
    mockSearchMovies = MockSearchMovies();
    cubit = MovieSearchCubit(searchMovies: mockSearchMovies);
  });

  tearDown(() async {
    await cubit.close();
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';
  group(
    'Movie Search',
    () {
      blocTest<MovieSearchCubit, MovieSearchState>(
        'Should emitsInOrder [Loading, Loaded] when success ',
        build: () {
          when(mockSearchMovies.execute(tQuery)).thenAnswer((_) async => Right(tMovieList));

          return cubit;
        },
        act: (bloc) => bloc.get(tQuery),
        expect: () => [
          const MovieSearchLoadingState(),
          MovieSearchLoadedState(items: tMovieList),
        ],
      );

      blocTest<MovieSearchCubit, MovieSearchState>(
        'Should emitsInOrder [Loading, Error] when unsuccess ',
        build: () {
          when(mockSearchMovies.execute(tQuery))
              .thenAnswer((_) async => const Left(ServerFailure('error')));

          return cubit;
        },
        act: (bloc) => bloc.get(tQuery),
        expect: () => [
          const MovieSearchLoadingState(),
          const MovieSearchErrorState('error'),
        ],
      );
    },
  );
}
