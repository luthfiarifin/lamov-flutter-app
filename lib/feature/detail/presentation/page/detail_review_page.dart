import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/di/injection.dart';
import '../../../../core/domain/common/model/model.dart';
import '../../../../core/presentation/extension/extension.dart';
import '../../domain/param/param.dart';
import '../cubit/detail_review_cubit.dart';
import '../widget/widget.dart';

@RoutePage()
class DetailReviewPage extends StatefulWidget implements AutoRouteWrapper {
  final int id;

  const DetailReviewPage({
    @PathParam('id') required this.id,
    super.key,
  });

  @override
  State<DetailReviewPage> createState() => _DetailReviewPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt<DetailReviewCubit>(),
      child: this,
    );
  }
}

class _DetailReviewPageState extends State<DetailReviewPage> {
  final PagingController<int, ReviewModel> _pagingController = PagingController(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _listenPagingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocListener<DetailReviewCubit, DetailReviewState>(
        listener: (context, state) {
          _onBodyListener(state);
        },
        child: _body(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Reviews',
        style: context.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _body() {
    return PagedListView<int, ReviewModel>.separated(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: 48,
      ),
      separatorBuilder: (context, index) => const Column(
        children: [
          Gap(4),
          Divider(),
          Gap(4),
        ],
      ),
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<ReviewModel>(
        animateTransitions: true,
        firstPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
        newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
        noItemsFoundIndicatorBuilder: (context) => const NotFoundWidget(),
        itemBuilder: (context, item, index) {
          return ReviewItem(item: item);
        },
      ),
    );
  }

  void _listenPagingController() {
    _pagingController.addPageRequestListener((pageKey) {
      _getReviews(page: pageKey);
    });
  }

  void _getReviews({
    required int page,
  }) {
    context.read<DetailReviewCubit>().getReviews(GetReviewParam(
          id: widget.id,
          page: page,
        ));
  }

  void _onBodyListener(DetailReviewState state) {
    if (state is GetReviewLoaded) {
      _onGetReviewLoaded(state);
    }
  }

  void _onGetReviewLoaded(GetReviewLoaded state) {
    final isLastPage = state.data.page == state.data.totalPages;

    if (isLastPage) {
      _pagingController.appendLastPage(state.data.results);
    } else {
      final nextPageKey = (state.data.page ?? 0) + 1;
      _pagingController.appendPage(state.data.results, nextPageKey);
    }
  }
}

class ReviewItem extends StatelessWidget {
  final ReviewModel item;

  const ReviewItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _author(context),
                if (item.authorDetails.rating != null) ..._ratings(context),
              ],
            ),
            _date(context),
          ],
        ),
        const Gap(16),
        _content(context),
      ],
    );
  }

  Text _author(BuildContext context) {
    return Text(
      item.author,
      style: context.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  List<Widget> _ratings(BuildContext context) {
    return [
      const Gap(2),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.star,
            color: Colors.yellow,
            size: 16,
          ),
          const Gap(4),
          Text(
            item.authorDetails.rating!.ceilToDouble().toString(),
            style: context.bodyMedium,
          ),
        ],
      )
    ];
  }

  Widget _content(BuildContext context) {
    return MarkdownBody(
      data: item.content,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: context.labelMedium,
      ),
      onTapLink: (text, href, title) => launchUrl(Uri.parse(href ?? '')),
    );
  }

  Widget _date(BuildContext context) {
    return Text(
      item.createdAt.formatDate(
        inputType: timeInputFormat,
        outputType: 'MMM dd, yyyy',
      ),
      style: context.labelMedium,
    );
  }
}
