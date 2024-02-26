import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../config/di/injection.dart';
import '../../../../core/domain/common/model/movie_model.dart';
import '../../../../core/presentation/enum/navigation_source.dart';
import '../../../../core/presentation/extension/build_context_extension.dart';
import '../../domain/model/model.dart';
import '../cubit/home_cubit.dart';
import '../widget/widget.dart';

@RoutePage()
class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeCubit>(),
      child: this,
    );
  }
}

class _HomePageState extends State<HomePage> {
  CategoryModel _selectedCategory = const CategoryModel(id: 1, name: 'Action');

  final PagingController<int, MovieModel> _pagingController = PagingController(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _getInitialData();
    _listenPagingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'LaMov',
        style: context.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leadingWidth: 40,
      automaticallyImplyLeading: false,
      actions: [
        _notificationIcon(),
      ],
      leading: _profileAvatar(),
    );
  }

  Widget _notificationIcon() {
    return Container(
      height: 26,
      width: 26,
      margin: const EdgeInsets.only(right: 16),
      child: SvgPicture.asset(
        'assets/icon/notification.svg',
        fit: BoxFit.fitWidth,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _profileAvatar() {
    return Transform.translate(
      offset: const Offset(16, 0),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(
          'assets/avatar/profile.svg',
          height: 32,
          width: 32,
        ),
      ),
    );
  }

  Widget _body() {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        _onBlocStateChange(state);
      },
      child: CustomScrollView(
        slivers: [
          MultiSliver(
            children: [
              const Gap(16),
              _banners(),
              const Gap(24),
              _categories(),
              const Gap(24),
              _popular(),
              const Gap(24),
              ..._topRated(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _banners() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => _bannerBuildWhen(current),
      builder: (context, state) {
        return MovieBannerCarousel(
          movies: context.read<HomeCubit>().bannerMovies,
        );
      },
    );
  }

  Widget _categories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Categories'),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              _categoryBuildWhen(current) || _movieCategoryBuildWhen(current),
          builder: (context, state) {
            return MovieCategoryTabList(
              categories: context.read<HomeCubit>().categories,
              selectedCategory: _selectedCategory,
              onTap: _onCategoryTap,
            );
          },
        ),
        const Gap(8),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) => _movieCategoryBuildWhen(current),
          builder: (context, state) {
            return MovieHorizontalList(
              source: NavigationSource.category,
              onTap: _navigateToDetail,
              movies: context.read<HomeCubit>().movies,
            );
          },
        )
      ],
    );
  }

  Widget _popular() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Popular Movies'),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) => _movieCategoryBuildWhen(current),
          builder: (context, state) {
            return MovieHorizontalList(
              source: NavigationSource.popular,
              onTap: _navigateToDetail,
              movies: context.read<HomeCubit>().movies,
            );
          },
        )
      ],
    );
  }

  List<Widget> _topRated() {
    return [
      SliverToBoxAdapter(
        child: _sectionTitle('Top Rated Movies'),
      ),
      MoviePagedList(
        source: NavigationSource.topRated,
        onTap: _navigateToDetail,
        pagingController: _pagingController,
      ),
    ];
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: Text(
        text,
        style: context.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  bool _bannerBuildWhen(HomeState current) =>
      current is GetBannerMoviesLoaded ||
      current is GetBannerMoviesLoading ||
      current is GetBannerMoviesError;

  bool _categoryBuildWhen(HomeState current) =>
      current is GetCategoryLoaded ||
      current is GetCategoryLoading ||
      current is GetCategoryError;

  bool _movieCategoryBuildWhen(HomeState current) =>
      current is GetMoviesByCategoryLoaded ||
      current is GetMoviesByCategoryLoading ||
      current is GetMoviesByCategoryError;

  void _onCategoryTap(CategoryModel category) {
    _selectedCategory = category;

    _getMovieByCategory();
  }

  void _getInitialData() {
    _getBannerMovies();
    _getCategory();
    _getMovieByCategory();
  }

  void _getBannerMovies() {
    context.read<HomeCubit>().getBannerMovies();
  }

  void _getCategory() {
    context.read<HomeCubit>().getCategories();
  }

  void _getMovieByCategory() {
    context.read<HomeCubit>().getMovieByCategory(_selectedCategory);
  }

  void _navigateToDetail(MovieModel post, NavigationSource source) {
    // TODO: implement navigation
  }

  void _listenPagingController() {
    _pagingController.addPageRequestListener((page) async {
      _fetchTopRatedData(page: page);
    });
  }

  void _fetchTopRatedData({
    required int page,
  }) {
    context.read<HomeCubit>().getTopRatedMovies(page);
  }

  void _onBlocStateChange(HomeState state) {
    if (state is GetTopRatedMoviesLoaded) {
      _onTopRatedMoviesLoaded(state);
    } else if (state is GetBannerMoviesError) {
      _showSnackbarError(state.message);
    } else if (state is GetCategoryError) {
      _showSnackbarError(state.message);
    } else if (state is GetMoviesByCategoryError) {
      _showSnackbarError(state.message);
    }
  }

  void _onTopRatedMoviesLoaded(GetTopRatedMoviesLoaded state) {
    final isLastPage = state.movies.page == state.movies.totalPages;

    if (isLastPage) {
      _pagingController.appendLastPage(state.movies.results);
    } else {
      final nextPageKey = state.movies.page + 1;
      _pagingController.appendPage(state.movies.results, nextPageKey);
    }
  }

  void _showSnackbarError(String message) {
    context.showSnackBar(message: message);
  }
}
