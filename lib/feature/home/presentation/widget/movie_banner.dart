import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import '../../../../core/data/constant/url_constant.dart';
import '../../../../core/domain/common/model/movie_model.dart';
import '../../../../core/presentation/extension/build_context_extension.dart';
import '../../../../core/presentation/widget/image_network.dart';
import '../../../../core/presentation/widget/shimmer_widget.dart';

class MovieBannerCarousel extends StatelessWidget {
  final List<MovieModel>? movies;

  const MovieBannerCarousel({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    if (movies == null) {
      return FlutterCarousel.builder(
        itemCount: 3,
        itemBuilder: (_, __, ___) {
          return const MovieBannerShimmer();
        },
        options: _carouselOptions(
          autoPlay: false,
        ),
      );
    }

    return FlutterCarousel.builder(
      itemCount: movies!.length,
      itemBuilder: (_, index, __) {
        return MovieBanner(movie: movies![index]);
      },
      options: _carouselOptions(),
    );
  }

  CarouselOptions _carouselOptions({
    bool autoPlay = true,
  }) {
    return CarouselOptions(
      aspectRatio: 16 / 9,
      autoPlay: autoPlay,
      autoPlayInterval: const Duration(seconds: 5),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      slideIndicator: CircularSlideIndicator(
        padding: const EdgeInsets.only(right: 32, bottom: 16),
        currentIndicatorColor: Colors.white,
        indicatorBackgroundColor: Colors.white.withOpacity(0.8),
        indicatorRadius: 3,
        itemSpacing: 10,
        alignment: Alignment.bottomRight,
      ),
    );
  }
}

class MovieBanner extends StatelessWidget {
  const MovieBanner({
    super.key,
    required this.movie,
  });

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          ImageNetwork(
            movie.backdropPath?.w500Image ?? '',
            fit: BoxFit.cover,
            height: context.height,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 16,
                right: 16,
                left: 16,
              ),
              color: Colors.black.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text(
                    context,
                    text: movie.title,
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _text(
                    context,
                    text: movie.overview,
                    style: context.labelSmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _text(
    BuildContext context, {
    required TextStyle? style,
    required String text,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: context.width * 0.7),
      child: Text(
        text,
        style: style,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class MovieBannerShimmer extends StatelessWidget {
  const MovieBannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShimmerWidget(
      radius: 16,
    );
  }
}
