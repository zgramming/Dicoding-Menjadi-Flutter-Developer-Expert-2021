import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:search/search.dart';
import 'package:watchlist/watchlist.dart';

import './injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  await initializeDateFormatting();
  // FirebaseCrashlytics.instance.crash();

  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// [https://github.com/felangel/bloc/issues/2526]
    return MultiProvider(
      providers: [
        ///* START MIGRATION TV SERIES CUBIT
        BlocProvider<TVSeriesAiringTodayCubit>(
          create: (context) => di.locator<TVSeriesAiringTodayCubit>(),
        ),
        BlocProvider<TVSeriesDetailCubit>(
          create: (context) => di.locator<TVSeriesDetailCubit>(),
        ),
        BlocProvider<TVSeriesRecommendationsCubit>(
          create: (context) => di.locator<TVSeriesRecommendationsCubit>(),
        ),
        BlocProvider<TVSeriesSearchCubit>(
          create: (context) => di.locator<TVSeriesSearchCubit>(),
        ),
        BlocProvider<TVSeriesTopRatedCubit>(
          create: (context) => di.locator<TVSeriesTopRatedCubit>(),
        ),
        BlocProvider<TVSeriesPopularCubit>(
          create: (context) => di.locator<TVSeriesPopularCubit>(),
        ),
        BlocProvider<TVSeriesWatchlistCubit>(
          create: (context) => di.locator<TVSeriesWatchlistCubit>(),
        ),
        BlocProvider<TVSeriesEpisodeSeasonCubit>(
          create: (context) => di.locator<TVSeriesEpisodeSeasonCubit>(),
        ),

        ///* END MIGRATION TV SERIES CUBIT
        ///* START MIGRATION MOVIES CUBIT
        BlocProvider<MovieSearchCubit>(
          create: (context) => di.locator<MovieSearchCubit>(),
        ),
        BlocProvider<MovieWatchlistCubit>(
          create: (context) => di.locator<MovieWatchlistCubit>(),
        ),
        BlocProvider<MovieNowPlayingCubit>(
          create: (context) => di.locator<MovieNowPlayingCubit>(),
        ),
        BlocProvider<MoviePopularCubit>(
          create: (context) => di.locator<MoviePopularCubit>(),
        ),
        BlocProvider<MovieTopRatedCubit>(
          create: (context) => di.locator<MovieTopRatedCubit>(),
        ),
        BlocProvider<MovieRecommendationsCubit>(
          create: (context) => di.locator<MovieRecommendationsCubit>(),
        ),
        BlocProvider<MovieDetailCubit>(
          create: (context) => di.locator<MovieDetailCubit>(),
        ),

        ///* END MIGRATION MOVIES CUBIT
      ],
      child: MaterialApp(
        title: 'Ditonton',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());

            ///! START TV SECTION
            case TVDetailPage.ROUTE_NAME:
              final int id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (context) => TVDetailPage(id: id),
              );
            case TVSeeMorePage.ROUTE_NAME:
              final SeeMoreState state = settings.arguments as SeeMoreState;
              return MaterialPageRoute(
                builder: (context) => TVSeeMorePage(seeMoreState: state),
              );
            case TVEpisodeSeasonPage.ROUTE_NAME:
              final param = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => TVEpisodeSeasonPage(param: param),
              );

            ///! END TV SECTION
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
