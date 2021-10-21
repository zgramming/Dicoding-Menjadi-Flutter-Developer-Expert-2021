import 'package:ditonton/presentation/cubit/movie/movie_search_cubit.dart';
import 'package:ditonton/presentation/cubit/movie/movie_watchlist_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_series_popular_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_series_search_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_series_watchlist_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/tv/get_airing_today_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_detail_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_episode_season_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_recommendation_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_watch_list_status_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/search_tv_series.dart';
import 'package:ditonton/presentation/cubit/tv/tv_series_airing_today_cubit.dart';
import 'package:ditonton/presentation/cubit/tv/tv_series_detail_cubit.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_episode_season_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_popular_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_recommendations_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_top_rated_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_watchlist_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';

import './presentation/cubit/tv/tv_series_recommendations_cubit.dart';
import './presentation/cubit/tv/tv_series_top_rated_cubit.dart';

final locator = GetIt.instance;

void init() {
  ///? START CUBIT
  ///! START TV SERIES
  locator.registerFactory(
    () => TVSeriesAiringTodayCubit(
      getAiringTodayTVSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesDetailCubit(
      getDetailTVSeries: locator(),
      getWatchListStatusTVSeries: locator(),
      saveWatchlistTVSeries: locator(),
      removeWatchlistTVSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesRecommendationsCubit(
      getRecommendationTVSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesSearchCubit(
      searchTVSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesTopRatedCubit(
      getTopRatedTVSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesPopularCubit(
      getPopularTVSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesWatchlistCubit(
      getWatchlistTVSeries: locator(),
    ),
  );

  ///! END TV SERIES
  ///! START MOVIES SERIES
  locator.registerFactory(
    () => MovieSearchCubit(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieWatchlistCubit(
      getWatchlistMovies: locator(),
    ),
  );

  ///! END MOVIES SERIES

  ///? END CUBIT
  ///? START PROVIDER

  //! START [MOVIE_NOTIFIER]
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  //! END [MOVIE_NOTIFIER]

  //! START [TV_NOTIFIER]
  // locator.registerFactory(
  //   () => TVSeriesAiringTodayNotifier(
  //     getAiringTodayTVSeries: locator(),
  //   ),
  // );

  locator.registerFactory(
    () => TVSeriesPopularNotifier(
      getPopularTVSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesTopRatedNotifier(
      getTopRatedTVSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesDetailNotifier(
      getDetailTVSeries: locator(),
      getWatchListStatusTVSeries: locator(),
      removeWatchlistTVSeries: locator(),
      saveWatchlistTVSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesRecommendationsNotifier(
      getRecommendationTVSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesSearchNotifier(
      searchTVSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesWatchlistNotifier(
      getWatchlistTVSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesEpisodeSeasonNotifier(
      getEpisodeSeasonTVSeries: locator(),
    ),
  );
  //! END [TV_NOTIFIER]

  ///? END [PROVIDER]

  ///? START [USECASE]

  //! START[USECASE_MOVIE]
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  //! END[USECASE_MOVIE]

  //! START[USECASE_TV]
  locator.registerLazySingleton(() => GetAiringTodayTVSeries(repository: locator()));
  locator.registerLazySingleton(() => GetDetailTVSeries(repository: locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(repository: locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(repository: locator()));
  locator.registerLazySingleton(() => SearchTVSeries(repository: locator()));
  locator.registerLazySingleton(() => GetRecommendationTVSeries(repository: locator()));
  locator.registerLazySingleton(() => GetEpisodeSeasonTVSeries(repository: locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTVSeries(repository: locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeries(repository: locator()));
  locator.registerLazySingleton(() => SaveWatchlistTVSeries(repository: locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTVSeries(repository: locator()));

  //! END[USECASE_TV]

  ///? END [USECASE]

  ///? START [DOMAIN/REPOSITORY]

  //! START [DOMAIN/REPOSITORY/MOVIE]
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  //! END [DOMAIN/REPOSITORY/MOVIE]

  //! START [DOMAIN/REPOSITORY/TV]
  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      tvRemoteDataSource: locator(),
      tvLocalDataSource: locator(),
    ),
  );
  //! END [DOMAIN/REPOSITORY/TV]

  ///? END [DOMAIN/REPOSITORY]

  ///? START [DATA SOURCE]

  //! START [DATASOURCE/MOVIE]
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );
  //! END [DATASOURCE/MOVIE]

  //! START [DATASOURCE/TV]
  locator.registerLazySingleton<TVRemoteDataSource>(
    () => TVRemoteDataSourceImp(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<TVLocalDataSource>(
    () => TVLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );
  //! END [DATASOURCE/TV]

  ///? END [DATA SOURCE]

  ///! START [HELPER]
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  ///! END [HELPER]

  // external
  locator.registerLazySingleton(() => http.Client());
}
