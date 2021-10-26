library core;

export './src/styles/colors.dart';
export './src/styles/text_styles.dart';

export './src/utils/constants.dart';
export './src/utils/exception.dart';
export './src/utils/failure.dart';
export './src/utils/state_enum.dart';

///! Cubit
export './src/presentation/cubit/tv/tv_series_airing_today_cubit.dart';
export './src/presentation/cubit/tv/tv_series_detail_cubit.dart';
export './src/presentation/cubit/tv/tv_series_episode_season_cubit.dart';
export './src/presentation/cubit/tv/tv_series_popular_cubit.dart';
export './src/presentation/cubit/tv/tv_series_recommendations_cubit.dart';
export './src/presentation/cubit/tv/tv_series_search_cubit.dart';
export './src/presentation/cubit/tv/tv_series_top_rated_cubit.dart';
export './src/presentation/cubit/tv/tv_series_watchlist_cubit.dart';

export './src/presentation/cubit/movie/movie_detail_cubit.dart';
export './src/presentation/cubit/movie/movie_now_playing_cubit.dart';
export './src/presentation/cubit/movie/movie_popular_cubit.dart';
export './src/presentation/cubit/movie/movie_recommendations_cubit.dart';
export './src/presentation/cubit/movie/movie_search_cubit.dart';
export './src/presentation/cubit/movie/movie_top_rated_cubit.dart';
export './src/presentation/cubit/movie/movie_watchlist_cubit.dart';

///! END Cubit

///! Pages
export './src/presentation/pages/home_movie_page.dart';
export './src/presentation/pages/movie_detail_page.dart';
export './src/presentation/pages/popular_movies_page.dart';
export './src/presentation/pages/search_page.dart';
export './src/presentation/pages/top_rated_movies_page.dart';
export './src/presentation/pages/tv_detail_page.dart' hide DetailContent;
export './src/presentation/pages/tv_episode_season_page.dart';
export './src/presentation/pages/tv_see_more_page.dart';
export './src/presentation/pages/watchlist_movies_page.dart';
///! END Pages