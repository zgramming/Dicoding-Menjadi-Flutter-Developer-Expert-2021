import 'package:ditonton/data/models/tv/tv_detail/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';

abstract class TVRemoteDataSource {
  Future<List<TVModel>> getNowPlayingTVSeries();
  Future<List<TVModel>> getPopularTVSeries();
  Future<List<TVModel>> getTopRatedTVSeries();
  Future<TVDetailResponse> getTVSeriesDetail(int id);
  Future<List<TVModel>> getTVSeriesRecommendations(int id);
  Future<List<TVModel>> searchTVSeries(String query);
}
