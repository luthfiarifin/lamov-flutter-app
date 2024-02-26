import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/data/constant/url_constant.dart';
import '../../../../core/domain/common/model/movie_model.dart';
import '../../../../core/presentation/enum/navigation_source.dart';
import '../../../../core/presentation/extension/extension.dart';
import '../../../../core/presentation/widget/widget.dart';

typedef OnMovieItemTap = Function(MovieModel post, NavigationSource source);

const double _width = 150, _imageHeight = 200;

class MovieItem extends StatelessWidget {
  final MovieModel movie;
  final NavigationSource source;
  final OnMovieItemTap onTap;
  final double? height;
  final double width;

  const MovieItem({
    super.key,
    required this.movie,
    required this.source,
    required this.onTap,
    this.height,
    this.width = _width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(movie, source),
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: width,
        height: height,
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ImageNetwork(
            movie.posterPath?.w500Image ?? '',
            fit: BoxFit.cover,
            width: width,
            height: _imageHeight,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          movie.title,
          overflow: TextOverflow.ellipsis,
          style: context.bodyMedium,
        ),
        Text(
          movie.releaseDate?.formatDate() ?? '',
          style: context.labelMedium,
        ),
      ],
    );
  }
}

class MovieItemShimmer extends StatelessWidget {
  final double width;

  const MovieItemShimmer({
    super.key,
    this.width = _width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _imageHeight,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _image(),
          const Gap(8),
          _text(),
          const Gap(4),
          _text(),
        ],
      ),
    );
  }

  Widget _image() {
    return const Expanded(
      child: ShimmerWidget(
        radius: 16,
      ),
    );
  }

  Widget _text() {
    return const ShimmerWidget(
      height: 16,
      radius: 8,
    );
  }
}
