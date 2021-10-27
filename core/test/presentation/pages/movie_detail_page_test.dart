import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:core/src/domain/usecases/get_watchlist_status.dart';
import 'package:core/src/presentation/cubit/movie/movie_detail_cubit.dart';
import 'package:core/src/presentation/cubit/movie/movie_recommendations_cubit.dart';
import 'package:core/src/presentation/pages/movie_detail_page.dart';
import 'package:core/src/presentation/provider/movie_detail_notifier.dart';

import '../../dummy_data/dummy_objects.dart';

class MovieDetailCubitMock extends MockCubit<MovieDetailState> implements MovieDetailCubit {}

class MovieDetailStateMock extends Fake implements MovieDetailState {}

class MovieRecommendationsCubitMock extends MockCubit<MovieRecommendationsState>
    implements MovieRecommendationsCubit {}

class MovieRecommendationsStateMock extends Fake implements MovieRecommendationsState {}

class GetWatchListStatusMock extends Fake implements GetWatchListStatus {}

class SaveWatchlistMock extends Fake implements SaveWatchlist {}

@GenerateMocks([MovieDetailNotifier])
void main() {
  late MovieDetailCubitMock movieDetailCubitMock;
  late MovieRecommendationsCubitMock movieRecommendationsMock;
  setUpAll(() {
    registerFallbackValue(MovieDetailStateMock());
    registerFallbackValue(MovieRecommendationsStateMock());
    registerFallbackValue(GetWatchListStatusMock());
    registerFallbackValue(SaveWatchlistMock());
  });

  setUp(() {
    movieRecommendationsMock = MovieRecommendationsCubitMock();
    movieDetailCubitMock = MovieDetailCubitMock();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieDetailCubit>(
          create: (context) => movieDetailCubitMock,
        ),
        BlocProvider<MovieRecommendationsCubit>(
          create: (context) => movieRecommendationsMock,
        ),
      ],
      child: MaterialApp(home: body),
    );
  }

  void initializeFunction() {
    when(() => movieDetailCubitMock.get(any())).thenAnswer((_) async => {});
    when(() => movieDetailCubitMock.getWatchlistStatus(any())).thenAnswer((_) async => {});
    when(() => movieRecommendationsMock.get(any())).thenAnswer((_) async => {});
  }

  testWidgets('Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    /// Find widget
    final watchlistButtonIcon = find.byIcon(Icons.add);

    initializeFunction();

    when(() => movieDetailCubitMock.state)
        .thenAnswer((_) => const MovieDetailState(requestState: RequestState.Loaded));

    when(() => movieRecommendationsMock.state)
        .thenAnswer((_) => MovieRecommendationsLoadedState(items: testMovieList));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    /// Find Widget
    final watchlistButtonIcon = find.byIcon(Icons.check);

    initializeFunction();

    when(() => movieDetailCubitMock.state).thenReturn(
      const MovieDetailState(
        requestState: RequestState.Loaded,
        movie: testMovieDetail,
        isAddedToWatchlist: true,
      ),
    );

    when(() => movieRecommendationsMock.state).thenReturn(
      const MovieRecommendationsLoadedState(items: []),
    );

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    initializeFunction();
    when(() => movieDetailCubitMock.addWatchlist(testMovieDetail)).thenAnswer((_) async => {});

    when(() => movieDetailCubitMock.state).thenReturn(
      const MovieDetailState(
        requestState: RequestState.Loaded,
        movie: testMovieDetail,
        messageWatchlist: 'Added to Watchlist',
      ),
    );

    when(() => movieRecommendationsMock.state).thenReturn(
      const MovieRecommendationsLoadedState(items: []),
    );

    // when(() => mockNotifier.movieState).thenReturn(RequestState.Loaded);
    // when(() => mockNotifier.movie).thenReturn(testMovieDetail);
    // when(() => mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    // when(() => mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    // when(() => mockNotifier.isAddedToWatchlist).thenReturn(false);
    // when(() => mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets('Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    initializeFunction();
    when(() => movieDetailCubitMock.addWatchlist(testMovieDetail)).thenAnswer((_) async => {});

    when(() => movieDetailCubitMock.state).thenReturn(
      const MovieDetailState(
        requestState: RequestState.Loaded,
        movie: testMovieDetail,
        messageWatchlist: 'Failed',
        isAddedToWatchlist: false,
      ),
    );

    when(() => movieRecommendationsMock.state).thenReturn(
      const MovieRecommendationsLoadedState(items: []),
    );
    // when(() => mockNotifier.movieState).thenReturn(RequestState.Loaded);
    // when(() => mockNotifier.movie).thenReturn(testMovieDetail);
    // when(() => mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    // when(() => mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    // when(() => mockNotifier.isAddedToWatchlist).thenReturn(false);
    // when(() => mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
