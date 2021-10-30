import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class TVSeriesPopularCubitMock extends MockCubit<TVSeriesPopularState>
    implements TVSeriesPopularCubit {}

class TVSeriesTopRatedCubitMock extends MockCubit<TVSeriesTopRatedState>
    implements TVSeriesTopRatedCubit {}

void main() {
  late TVSeriesPopularCubitMock tvSeriesPopularCubitMock;
  late TVSeriesTopRatedCubitMock tvSeriesTopRatedCubitMock;

  setUp(() {
    tvSeriesPopularCubitMock = TVSeriesPopularCubitMock();
    tvSeriesTopRatedCubitMock = TVSeriesTopRatedCubitMock();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<TVSeriesPopularCubit>(
          create: (context) => tvSeriesPopularCubitMock,
        ),
        BlocProvider<TVSeriesTopRatedCubit>(
          create: (context) => tvSeriesTopRatedCubitMock,
        ),
      ],
      child: MaterialApp(home: body),
    );
  }

  void initializeFunction() {
    when(() => tvSeriesPopularCubitMock.get()).thenAnswer((_) async => {});
    when(() => tvSeriesTopRatedCubitMock.get()).thenAnswer((_) async => {});
  }

  group('TV Series Popular', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      initializeFunction();

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      when(() => tvSeriesPopularCubitMock.state)
          .thenAnswer((_) => const TVSeriesPopularLoadingState());
      await tester
          .pumpWidget(_makeTestableWidget(const TVSeeMorePage(seeMoreState: SeeMoreState.Popular)));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
      /// Find Widget
      final listViewFinder = find.byType(ListView);

      initializeFunction();
      when(() => tvSeriesPopularCubitMock.state)
          .thenAnswer((_) => const TVSeriesPopularLoadedState(items: []));

      await tester
          .pumpWidget(_makeTestableWidget(const TVSeeMorePage(seeMoreState: SeeMoreState.Popular)));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
      /// Find Widget
      final textFinder = find.byKey(const Key('error_message'));

      initializeFunction();
      when(() => tvSeriesPopularCubitMock.state)
          .thenAnswer((_) => const TVSeriesPopularErrorState('error'));

      await tester
          .pumpWidget(_makeTestableWidget(const TVSeeMorePage(seeMoreState: SeeMoreState.Popular)));

      expect(textFinder, findsOneWidget);
    });
  });

  group(
    'TV Series Top Rated',
    () {
      testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        initializeFunction();

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        when(() => tvSeriesTopRatedCubitMock.state)
            .thenAnswer((_) => const TVSeriesTopRatedLoadingState());
        await tester.pumpWidget(
            _makeTestableWidget(const TVSeeMorePage(seeMoreState: SeeMoreState.TopRated)));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

      testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
        /// Find Widget
        final listViewFinder = find.byType(ListView);

        initializeFunction();
        when(() => tvSeriesTopRatedCubitMock.state)
            .thenAnswer((_) => const TVSeriesTopRatedLoadedState(items: []));

        await tester.pumpWidget(
            _makeTestableWidget(const TVSeeMorePage(seeMoreState: SeeMoreState.TopRated)));

        expect(listViewFinder, findsOneWidget);
      });

      testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
        /// Find Widget
        final textFinder = find.byKey(const Key('error_message'));

        initializeFunction();
        when(() => tvSeriesTopRatedCubitMock.state)
            .thenAnswer((_) => const TVSeriesTopRatedErrorState('error'));

        await tester.pumpWidget(
            _makeTestableWidget(const TVSeeMorePage(seeMoreState: SeeMoreState.TopRated)));

        expect(textFinder, findsOneWidget);
      });
    },
  );
}
