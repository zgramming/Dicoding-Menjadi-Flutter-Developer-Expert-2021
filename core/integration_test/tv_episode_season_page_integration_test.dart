import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/src/domain/entities/tv/tv_crew.dart';
import 'package:core/src/domain/entities/tv/tv_episode.dart';
import 'package:core/src/domain/entities/tv/tv_season.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'dummy_data/dummy_objects.dart';

class TVSeriesEpisodeSeasonCubitMock extends MockCubit<TVSeriesEpisodeSeasonState>
    implements TVSeriesEpisodeSeasonCubit {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late TVSeriesEpisodeSeasonCubitMock tvSeriesEpisodeSeasonCubitMock;

  setUp(() async {
    await initializeDateFormatting();
    tvSeriesEpisodeSeasonCubitMock = TVSeriesEpisodeSeasonCubitMock();
  });

  final mockListEpisode = List.generate(10, (index) {
    var dateTime = DateTime.now().add(Duration(days: index));
    return Episode(
      airDate: dateTime,
      episodeNumber: index,
      crew: [
        Crew(
          id: index,
          job: 'Job $index',
          department: 'Department $index',
          personId: 'personId $index',
          creditId: 'creditId $index',
          adult: true,
          gender: 1,
          knownForDepartment: 'knownForDepartment $index',
          name: 'Zeffry Reynando $index',
          originalName: 'originalName $index',
          popularity: 10 + double.parse(index.toString()),
          profilePath: 'profilePath $index',
          character: 'character $index',
          order: index,
        ),
      ],
      guestStars: [
        Crew(
          id: index,
          job: 'Job $index',
          department: 'Department $index',
          personId: 'personId $index',
          creditId: 'creditId $index',
          adult: true,
          gender: 1,
          knownForDepartment: 'knownForDepartment $index',
          name: 'Ando ronaldo $index',
          originalName: 'originalName $index',
          popularity: 10 + double.parse(index.toString()),
          profilePath: 'profilePath $index',
          character: 'character $index',
          order: index,
        ),
      ],
      id: index + 1,
      name: 'name $index',
      overview: 'overview $index',
      productionCode: 'productionCode $index',
      seasonNumber: index + 1,
      stillPath: 'stillPath $index',
      voteAverage: Random().nextInt(10).toDouble(),
      voteCount: Random().nextInt(100),
    );
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

  void initializeFunction() {
    when(
      () => tvSeriesEpisodeSeasonCubitMock.get(
        id: any(named: 'id'),
        seasonNumber: any(named: 'seasonNumber'),
      ),
    ).thenAnswer((_) async => {});
  }

  group('TV Episode of Season', () {
    testWidgets(
      'After state is loaded, then tap icon to show detail person of episode',
      (WidgetTester tester) async {
        /// Find Widget
        final listViewFinder = find.byType(ListView);
        final inkWellFinder = find.byKey(const Key('ontap_crew0'));

        initializeFunction();
        when(() => tvSeriesEpisodeSeasonCubitMock.state).thenAnswer(
          (_) => TVSeriesEpisodeSeasonLoadedState(items: mockListEpisode),
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

        expect(listViewFinder, findsOneWidget);
        expect(inkWellFinder, findsOneWidget);

        await tester.tap(inkWellFinder);
        await tester.pumpAndSettle();

        final textCrewFinder = find.text('Crew');
        final textGuestStarFinder = find.text('Guest Star');

        expect(textCrewFinder, findsOneWidget);
        expect(textGuestStarFinder, findsOneWidget);

        await tester.pumpAndSettle(const Duration(seconds: 2));
      },
    );
  });
}
