import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';

class SearchCategory {
  final String title;
  final CategoryMenu category;

  SearchCategory({
    required this.title,
    required this.category,
  });
}

final _categories = <SearchCategory>[
  SearchCategory(
    title: 'Movie',
    category: CategoryMenu.Movie,
  ),
  SearchCategory(
    title: 'TV Series',
    category: CategoryMenu.TVSeries,
  ),
];

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchCategory _selectedCategory;
  late final TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories.first;
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: [
          Container(
            child: DropdownButton<SearchCategory>(
              value: _selectedCategory,
              onChanged: (value) {
                if (_searchController.text.isNotEmpty) {
                  if (value!.category == CategoryMenu.Movie) {
                    /// Call Function Movie
                    Provider.of<MovieSearchNotifier>(context, listen: false).fetchMovieSearch(
                      _searchController.text,
                    );
                  } else {
                    /// Call Function TV Series
                    Provider.of<TVSeriesSearchNotifier>(context, listen: false).fetchTVSeriesSearch(
                      _searchController.text,
                    );
                  }
                }
                setState(() => _selectedCategory = value!);
              },
              items: _categories
                  .map(
                    (e) => DropdownMenuItem<SearchCategory>(
                      child: Text('${e.title}'),
                      value: e,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              onSubmitted: (query) {
                if (_selectedCategory.category == CategoryMenu.Movie) {
                  Provider.of<MovieSearchNotifier>(context, listen: false).fetchMovieSearch(
                    query,
                  );
                } else {
                  Provider.of<TVSeriesSearchNotifier>(context, listen: false).fetchTVSeriesSearch(
                    query,
                  );
                }
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            if (_selectedCategory.category == CategoryMenu.Movie) ...[
              Consumer<MovieSearchNotifier>(
                builder: (context, data, child) {
                  return _buildMovieSearch(data);
                },
              ),
            ] else ...[
              Consumer<TVSeriesSearchNotifier>(
                builder: (context, data, child) {
                  return _buildTVSeriesSearch(data);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  _buildMovieSearch(MovieSearchNotifier data) {
    if (data.state == RequestState.Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (data.state == RequestState.Loaded) {
      final result = data.searchResult;
      return Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final movie = data.searchResult[index];
            return MovieCard(movie);
          },
          itemCount: result.length,
        ),
      );
    } else {
      return Expanded(
        child: Container(),
      );
    }
  }

  _buildTVSeriesSearch(TVSeriesSearchNotifier data) {
    if (data.state == RequestState.Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (data.state == RequestState.Loaded) {
      final result = data.items;
      return Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final tv = data.items[index];
            return TVCard(tv: tv);
          },
          itemCount: result.length,
        ),
      );
    } else {
      return Expanded(
        child: Container(),
      );
    }
  }
}
