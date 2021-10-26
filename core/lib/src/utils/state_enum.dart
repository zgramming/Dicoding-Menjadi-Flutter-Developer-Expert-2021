// ignore_for_file: constant_identifier_names

enum RequestState { Empty, Loading, Loaded, Error }
enum CategoryMenu { Movie, TVSeries }
enum SeeMoreState { Popular, TopRated }

const Map<CategoryMenu, String> categoryMenuValues = {
  CategoryMenu.Movie: 'movie',
  CategoryMenu.TVSeries: 'tv_series',
};
