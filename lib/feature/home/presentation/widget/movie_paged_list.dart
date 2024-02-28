import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/domain/common/model/movie_model.dart';
import '../../../../core/presentation/enum/navigation_source.dart';
import '../../../../core/presentation/widget/loading_widget.dart';
import 'movie_item.dart';

class MoviePagedList extends StatelessWidget {
  final OnMovieItemTap onTap;
  final NavigationSource source;
  final PagingController<int, MovieModel> pagingController;

  const MoviePagedList({
    super.key,
    required this.onTap,
    required this.source,
    required this.pagingController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: PagedMasonrySliverGrid.count(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<MovieModel>(
          itemBuilder: (context, movie, index) {
            return MovieItem(
              movie: movie,
              onTap: onTap,
              source: source,
              width: double.infinity,
            );
          },
          newPageProgressIndicatorBuilder: (context) {
            return _loadingWidget();
          },
          firstPageProgressIndicatorBuilder: (context) {
            return _loadingWidget();
          },
        ),
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
      ),
    );
  }

  Widget _loadingWidget() {
    return const LoadingWidget();
  }
}
