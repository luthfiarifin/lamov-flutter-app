import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../config/di/injection.dart';
import '../../../../config/router/app_router.dart';
import '../../../../core/data/constant/url_constant.dart';
import '../../../../core/domain/common/model/model.dart';
import '../../../../core/presentation/extension/extension.dart';
import '../../../../core/presentation/widget/widget.dart';
import '../cubit/cubit.dart';
import '../widget/actor_widget.dart';
import '../widget/chip_attribute.dart';
import '../widget/loading_widget.dart';

@RoutePage()
class DetailPage extends StatefulWidget implements AutoRouteWrapper {
  final int id;
  final String? title, imageUrl, source;

  const DetailPage({
    super.key,
    @PathParam('id') required this.id,
    @QueryParam('title') this.title,
    @QueryParam('image_url') this.imageUrl,
    @QueryParam('source') this.source,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt<DetailCubit>(),
      child: this,
    );
  }
}

class _DetailPageState extends State<DetailPage> {
  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    _getInitialData();
    super.initState();
  }

  @override
  void dispose() {
    _youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 500,
            flexibleSpace: FlexibleSpaceBar(
              background: _imageBackground(),
              titlePadding: const EdgeInsets.only(),
            ),
            pinned: true,
          ),
        ],
        body: BlocConsumer<DetailCubit, DetailState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetDetailLoaded) {
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: _children(state.movie),
              );
            }

            return const LoadingWidget();
          },
        ),
      ),
    );
  }

  Hero _imageBackground() {
    return Hero(
      tag: '${widget.source}-${widget.imageUrl}',
      child: ImageNetwork(
        widget.imageUrl?.w500Image ?? '',
        fit: BoxFit.cover,
      ),
    );
  }

  List<Widget> _children(MovieModel movie) {
    return [
      _movieTitle(movie),
      const Gap(16),
      _attribute(movie),
      const Gap(16),
      _overview(movie.overview),
      const Gap(16),
      ..._actor(movie.credits?.actor),
      const Gap(16),
      ..._trailer(movie.videos),
    ];
  }

  Widget _movieTitle(MovieModel movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        movie.title,
        style: context.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _attribute(MovieModel movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        direction: Axis.horizontal,
        runSpacing: 8,
        spacing: 8,
        children: [
          _review(movie),
          _runtime(movie),
          ...genres(movie.genres),
        ],
      ),
    );
  }

  List<Widget> genres(List<GenreModel>? genres) =>
      genres?.map((e) => ChipAttribute(e.name)).toList() ?? [];

  Widget _runtime(MovieModel movie) => ChipAttribute('${movie.runtime} Min');

  Widget _review(MovieModel movie) => ChipAttribute(
        '${movie.voteAverage.ceilToDouble().toString()} (See Reviews)',
        icon: const Icon(
          Icons.star,
          color: Colors.yellow,
          size: 16,
        ),
        onTap: _navigateToReview,
      );

  Padding _overview(String overview) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        overview,
        style: context.bodyMedium,
      ),
    );
  }

  Widget _title({
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: context.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _getInitialData() {
    context.read<DetailCubit>().getDetail(widget.id);
  }

  List<Widget> _trailer(List<MovieVideoModel>? videos) {
    final youtubeTrailer = videos
        ?.where(
          (element) => element.type == 'Trailer' && element.site == 'YouTube',
        )
        .firstOrNull;

    if (youtubeTrailer == null) {
      return [];
    }

    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: youtubeTrailer.key,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        showLiveFullscreenButton: false,
      ),
    );

    return [
      _title(text: 'Movie Trailer'),
      const Gap(8),
      _youtubePlayer(),
    ];
  }

  Padding _youtubePlayer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: YoutubePlayer(
        controller: _youtubePlayerController!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: context.colorScheme.primary,
        progressColors: ProgressBarColors(
          playedColor: context.colorScheme.primary,
          handleColor: context.colorScheme.primary,
        ),
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
        ],
      ),
    );
  }

  List<Widget> _actor(List<MovieCreditsCastModel>? actors) {
    if (actors == null || actors.isEmpty) {
      return [];
    }

    return [
      _title(text: 'Actor'),
      const Gap(8),
      _actorList(actors),
    ];
  }

  Widget _actorList(List<MovieCreditsCastModel> actors) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        itemCount: actors.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (context, index) => const Gap(8),
        itemBuilder: (context, index) {
          return ActorWidget(actor: actors[index]);
        },
      ),
    );
  }

  void _navigateToReview() {
    context.router.push(
      DetailReviewRoute(id: widget.id),
    );
  }
}
