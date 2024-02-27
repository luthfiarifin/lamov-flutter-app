// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<DetailRouteArgs>(
          orElse: () => DetailRouteArgs(
                id: pathParams.getInt('id'),
                title: queryParams.optString('title'),
                imageUrl: queryParams.optString('image_url'),
                source: queryParams.optString('source'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DetailPage(
          key: args.key,
          id: args.id,
          title: args.title,
          imageUrl: args.imageUrl,
          source: args.source,
        )),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const HomePage()),
      );
    },
  };
}

/// generated route for
/// [DetailPage]
class DetailRoute extends PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    Key? key,
    required int id,
    String? title,
    String? imageUrl,
    String? source,
    List<PageRouteInfo>? children,
  }) : super(
          DetailRoute.name,
          args: DetailRouteArgs(
            key: key,
            id: id,
            title: title,
            imageUrl: imageUrl,
            source: source,
          ),
          rawPathParams: {'id': id},
          rawQueryParams: {
            'title': title,
            'image_url': imageUrl,
            'source': source,
          },
          initialChildren: children,
        );

  static const String name = 'DetailRoute';

  static const PageInfo<DetailRouteArgs> page = PageInfo<DetailRouteArgs>(name);
}

class DetailRouteArgs {
  const DetailRouteArgs({
    this.key,
    required this.id,
    this.title,
    this.imageUrl,
    this.source,
  });

  final Key? key;

  final int id;

  final String? title;

  final String? imageUrl;

  final String? source;

  @override
  String toString() {
    return 'DetailRouteArgs{key: $key, id: $id, title: $title, imageUrl: $imageUrl, source: $source}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
