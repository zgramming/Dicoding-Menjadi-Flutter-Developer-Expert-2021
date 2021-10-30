import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/src/data/models/tv/tv_episode/tv_episode_model.dart';
import 'package:core/src/domain/entities/tv/tv_season.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';

class TVSeriesEpisodeSeasonCubitMock extends MockCubit<TVSeriesEpisodeSeasonState>
    implements TVSeriesEpisodeSeasonCubit {}

void main() {
  late TVSeriesEpisodeSeasonCubitMock tvSeriesEpisodeSeasonCubitMock;

  setUp(() async {
    await initializeDateFormatting();
    tvSeriesEpisodeSeasonCubitMock = TVSeriesEpisodeSeasonCubitMock();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<TVSeriesEpisodeSeasonCubit>(
          create: (context) => tvSeriesEpisodeSeasonCubitMock,
        ),
      ],
      child: MaterialApp(home: body),
    );
  }

  final mockListEpisodeSeasonTV =
      jsonListEpisodeSeasonTV.map((e) => EpisodeModel.fromJson(e).toEntity()).toList();

  void initializeFunction() {
    when(
      () => tvSeriesEpisodeSeasonCubitMock.get(
        id: any(named: 'id'),
        seasonNumber: any(named: 'seasonNumber'),
      ),
    ).thenAnswer((_) async => {});
  }

  group(
    'TV Series Episode of Season',
    () {
      testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        initializeFunction();

        when(() => tvSeriesEpisodeSeasonCubitMock.state).thenAnswer(
          (_) => const TVSeriesEpisodeSeasonLoadingState(),
        );

        await tester.pumpWidget(
          _makeTestableWidget(
            const TVEpisodeSeasonPage(
              param: {
                'tv': testTVDetail,
                'season': Season(),
              },
            ),
          ),
        );

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

      testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
        /// Find Widget
        final listViewFinder = find.byType(ListView);

        initializeFunction();
        when(() => tvSeriesEpisodeSeasonCubitMock.state)
            .thenAnswer((_) => TVSeriesEpisodeSeasonLoadedState(items: mockListEpisodeSeasonTV));

        await tester.pumpWidget(
          _makeTestableWidget(
            const TVEpisodeSeasonPage(
              param: {
                'tv': testTVDetail,
                'season': Season(),
              },
            ),
          ),
        );

        expect(listViewFinder, findsOneWidget);
      });

      testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
        /// Find Widget
        final textFinder = find.byKey(const Key('error_message'));

        initializeFunction();
        when(() => tvSeriesEpisodeSeasonCubitMock.state)
            .thenAnswer((_) => const TVSeriesEpisodeSeasonErrorState('error'));

        await tester.pumpWidget(
          _makeTestableWidget(
            const TVEpisodeSeasonPage(
              param: {
                'tv': testTVDetail,
                'season': Season(),
              },
            ),
          ),
        );

        expect(textFinder, findsOneWidget);
      });
    },
  );
}
