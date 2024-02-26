import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/domain/common/model/movie_model.dart';
import '../../../../core/presentation/enum/navigation_source.dart';
import 'movie_item.dart';

class MovieHorizontalList extends StatelessWidget {
  final List<MovieModel>? movies;
  final NavigationSource source;
  final OnMovieItemTap onTap;

  const MovieHorizontalList({
    super.key,
    this.movies,
    required this.source,
    required this.onTap,
  });

  final Axis _scrollDirection = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 244,
      child: movies != null
          ? ListView.separated(
              padding: _padding(),
              scrollDirection: _scrollDirection,
              itemCount: movies!.length,
              itemBuilder: (context, index) {
                return MovieItem(
                  movie: movies!.elementAt(index),
                  onTap: onTap,
                  source: source,
                );
              },
              separatorBuilder: (context, index) => _separator(),
            )
          : ListView.separated(
              padding: _padding(),
              scrollDirection: _scrollDirection,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const MovieItemShimmer();
              },
              separatorBuilder: (context, index) => _separator(),
            ),
    );
  }

  EdgeInsets _padding() => const EdgeInsets.symmetric(horizontal: 16);

  Gap _separator() => const Gap(16);
}
