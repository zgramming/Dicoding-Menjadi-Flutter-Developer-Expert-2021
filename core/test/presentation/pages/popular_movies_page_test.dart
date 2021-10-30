import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MoviePopularCubitMock extends MockCubit<MoviePopularState> implements MoviePopularCubit {}

void main() {
  late MoviePopularCubitMock mockMoviePopularCubit;

  setUp(() {
    mockMoviePopularCubit = MoviePopularCubitMock();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<MoviePopularCubit>(
          create: (context) => mockMoviePopularCubit,
        ),
      ],
      child: MaterialApp(home: body),
    );
  }

  void initializeFunction() {
    when(() => mockMoviePopularCubit.get()).thenAnswer((_) async => {});
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    initializeFunction();

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    when(() => mockMoviePopularCubit.state).thenAnswer((_) => const MoviePopularLoadingState());
    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    /// Find Widget
    final listViewFinder = find.byType(ListView);

    initializeFunction();
    when(() => mockMoviePopularCubit.state)
        .thenAnswer((_) => const MoviePopularLoadedState(items: []));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    /// Find Widget
    final textFinder = find.byKey(const Key('error_message'));

    initializeFunction();
    when(() => mockMoviePopularCubit.state)
        .thenAnswer((_) => const MoviePopularErrorState('error'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
