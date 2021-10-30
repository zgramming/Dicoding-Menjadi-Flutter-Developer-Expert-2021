import 'package:core/core.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MovieTopRatedCubitMock extends MockCubit<MovieTopRatedState> implements MovieTopRatedCubit {}

void main() {
  late MovieTopRatedCubitMock movieTopRatedCubitMock;

  setUp(() {
    movieTopRatedCubitMock = MovieTopRatedCubitMock();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieTopRatedCubit>(
          create: (context) => movieTopRatedCubitMock,
        ),
      ],
      child: MaterialApp(home: body),
    );
  }

  void initializeFunction() {
    when(() => movieTopRatedCubitMock.get()).thenAnswer((_) async => {});
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    initializeFunction();

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    when(() => movieTopRatedCubitMock.state).thenAnswer((_) => const MovieTopRatedLoadingState());
    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    /// Find Widget
    final listViewFinder = find.byType(ListView);

    initializeFunction();
    when(() => movieTopRatedCubitMock.state)
        .thenAnswer((_) => const MovieTopRatedLoadedState(items: []));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    /// Find Widget
    final textFinder = find.byKey(const Key('error_message'));

    initializeFunction();
    when(() => movieTopRatedCubitMock.state)
        .thenAnswer((_) => const MovieTopRatedErrorState('error'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
