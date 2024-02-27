import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../feature/detail/presentation/page/detail_page.dart';
import '../../feature/home/presentation/page/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          path: '/',
        ),
        AutoRoute(
          page: DetailRoute.page,
          path: '/movie/:id',
        ),
      ];
}
