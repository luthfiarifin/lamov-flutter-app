// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../core/data/data.dart' as _i11;
import '../../core/data/network/api_client.dart' as _i3;
import '../../core/data/network/network.dart' as _i5;
import '../../feature/detail/data/datasource/datasource.dart' as _i7;
import '../../feature/detail/data/datasource/detail_remote_datasource.dart'
    as _i4;
import '../../feature/detail/domain/repository/detail_repository.dart' as _i6;
import '../../feature/detail/domain/repository/repository.dart' as _i9;
import '../../feature/detail/domain/usecase/get_movie_detail_usecase.dart'
    as _i8;
import '../../feature/detail/domain/usecase/usecase.dart' as _i15;
import '../../feature/detail/presentation/cubit/detail_cubit.dart' as _i14;
import '../../feature/home/data/datasource/datasource.dart' as _i13;
import '../../feature/home/data/datasource/home_remote_datasource.dart' as _i10;
import '../../feature/home/domain/repository/home_repository.dart' as _i12;
import '../../feature/home/domain/usecase/get_movie_genres_use_case.dart'
    as _i16;
import '../../feature/home/domain/usecase/get_movies_discover_use_case.dart'
    as _i17;
import '../../feature/home/domain/usecase/get_movies_now_playing_use_case.dart'
    as _i18;
import '../../feature/home/domain/usecase/get_movies_popular_use_case.dart'
    as _i19;
import '../../feature/home/domain/usecase/get_movies_top_rated_use_case.dart'
    as _i20;
import '../../feature/home/domain/usecase/usecase.dart' as _i22;
import '../../feature/home/presentation/cubit/home_cubit.dart' as _i21;
import 'core.injection.dart' as _i23;

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
    gh.lazySingleton<_i10.HomeRemoteDataSource>(
        () => _i10.HomeRemoteDataSourceImpl(client: gh<_i11.ApiClient>()));
    gh.lazySingleton<_i12.HomeRepository>(() => _i12.HomeRepositoryImpl(
        remoteDataSource: gh<_i13.HomeRemoteDataSource>()));
    gh.factory<_i14.DetailCubit>(
        () => _i14.DetailCubit(gh<_i15.GetMovieDetailUseCase>()));
    gh.lazySingleton<_i16.GetMovieGenresUseCase>(
        () => _i16.GetMovieGenresUseCase(gh<_i12.HomeRepository>()));
    gh.lazySingleton<_i17.GetMoviesDiscoverUseCase>(
        () => _i17.GetMoviesDiscoverUseCase(gh<_i12.HomeRepository>()));
    gh.lazySingleton<_i18.GetMoviesNowPlayingUseCase>(
        () => _i18.GetMoviesNowPlayingUseCase(gh<_i12.HomeRepository>()));
    gh.lazySingleton<_i19.GetMoviesPopularUseCase>(
        () => _i19.GetMoviesPopularUseCase(gh<_i12.HomeRepository>()));
    gh.lazySingleton<_i20.GetMoviesTopRatedUseCase>(
        () => _i20.GetMoviesTopRatedUseCase(gh<_i12.HomeRepository>()));
    gh.factory<_i21.HomeCubit>(() => _i21.HomeCubit(
          gh<_i22.GetMovieGenresUseCase>(),
          gh<_i22.GetMoviesNowPlayingUseCase>(),
          gh<_i22.GetMoviesDiscoverUseCase>(),
          gh<_i22.GetMoviesPopularUseCase>(),
          gh<_i22.GetMoviesTopRatedUseCase>(),
        ));
    return this;
  }
}

class _$CoreInjectionModule extends _i23.CoreInjectionModule {}
