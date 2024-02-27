// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../core/data/data.dart' as _i12;
import '../../core/data/network/api_client.dart' as _i3;
import '../../core/data/network/network.dart' as _i5;
import '../../feature/detail/data/datasource/datasource.dart' as _i7;
import '../../feature/detail/data/datasource/detail_remote_datasource.dart'
    as _i4;
import '../../feature/detail/domain/repository/detail_repository.dart' as _i6;
import '../../feature/detail/domain/repository/repository.dart' as _i9;
import '../../feature/detail/domain/usecase/get_movie_detail_usecase.dart'
    as _i8;
import '../../feature/detail/domain/usecase/get_movie_review_usecase.dart'
    as _i10;
import '../../feature/detail/domain/usecase/usecase.dart' as _i16;
import '../../feature/detail/presentation/cubit/detail_cubit.dart' as _i15;
import '../../feature/detail/presentation/cubit/detail_review_cubit.dart'
    as _i17;
import '../../feature/home/data/datasource/datasource.dart' as _i14;
import '../../feature/home/data/datasource/home_remote_datasource.dart' as _i11;
import '../../feature/home/domain/repository/home_repository.dart' as _i13;
import '../../feature/home/domain/usecase/get_movie_genres_use_case.dart'
    as _i18;
import '../../feature/home/domain/usecase/get_movies_discover_use_case.dart'
    as _i19;
import '../../feature/home/domain/usecase/get_movies_now_playing_use_case.dart'
    as _i20;
import '../../feature/home/domain/usecase/get_movies_popular_use_case.dart'
    as _i21;
import '../../feature/home/domain/usecase/get_movies_top_rated_use_case.dart'
    as _i22;
import '../../feature/home/domain/usecase/usecase.dart' as _i24;
import '../../feature/home/presentation/cubit/home_cubit.dart' as _i23;
import 'core.injection.dart' as _i25;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreInjectionModule = _$CoreInjectionModule();
    gh.lazySingleton<_i3.ApiClient>(() => coreInjectionModule.apiClient);
    gh.lazySingleton<_i4.DetailRemoteDataSource>(
        () => _i4.DetailRemoteDataSourceImpl(client: gh<_i5.ApiClient>()));
    gh.lazySingleton<_i6.DetailRepository>(() => _i6.DetailRepositoryImpl(
        remoteDataSource: gh<_i7.DetailRemoteDataSource>()));
    gh.lazySingleton<_i8.GetMovieDetailUseCase>(
        () => _i8.GetMovieDetailUseCase(gh<_i9.DetailRepository>()));
    gh.lazySingleton<_i10.GetMovieReviewUseCase>(
        () => _i10.GetMovieReviewUseCase(gh<_i9.DetailRepository>()));
    gh.lazySingleton<_i11.HomeRemoteDataSource>(
        () => _i11.HomeRemoteDataSourceImpl(client: gh<_i12.ApiClient>()));
    gh.lazySingleton<_i13.HomeRepository>(() => _i13.HomeRepositoryImpl(
        remoteDataSource: gh<_i14.HomeRemoteDataSource>()));
    gh.factory<_i15.DetailCubit>(
        () => _i15.DetailCubit(gh<_i16.GetMovieDetailUseCase>()));
    gh.factory<_i17.DetailReviewCubit>(
        () => _i17.DetailReviewCubit(gh<_i16.GetMovieReviewUseCase>()));
    gh.lazySingleton<_i18.GetMovieGenresUseCase>(
        () => _i18.GetMovieGenresUseCase(gh<_i13.HomeRepository>()));
    gh.lazySingleton<_i19.GetMoviesDiscoverUseCase>(
        () => _i19.GetMoviesDiscoverUseCase(gh<_i13.HomeRepository>()));
    gh.lazySingleton<_i20.GetMoviesNowPlayingUseCase>(
        () => _i20.GetMoviesNowPlayingUseCase(gh<_i13.HomeRepository>()));
    gh.lazySingleton<_i21.GetMoviesPopularUseCase>(
        () => _i21.GetMoviesPopularUseCase(gh<_i13.HomeRepository>()));
    gh.lazySingleton<_i22.GetMoviesTopRatedUseCase>(
        () => _i22.GetMoviesTopRatedUseCase(gh<_i13.HomeRepository>()));
    gh.factory<_i23.HomeCubit>(() => _i23.HomeCubit(
          gh<_i24.GetMovieGenresUseCase>(),
          gh<_i24.GetMoviesNowPlayingUseCase>(),
          gh<_i24.GetMoviesDiscoverUseCase>(),
          gh<_i24.GetMoviesPopularUseCase>(),
          gh<_i24.GetMoviesTopRatedUseCase>(),
        ));
    return this;
  }
}

class _$CoreInjectionModule extends _i25.CoreInjectionModule {}
