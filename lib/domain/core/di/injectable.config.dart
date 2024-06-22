// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../application/downloads/downloads_bloc.dart' as _i10;
import '../../../application/fast_laugh/fast_laugh_bloc.dart' as _i11;
import '../../../application/home/home_bloc.dart' as _i12;
import '../../../application/hotandnew/hotandnew_bloc.dart' as _i5;
import '../../../application/search/search_bloc.dart' as _i13;
import '../../../infrastructure/downloads/downloads_repository.dart' as _i7;
import '../../../infrastructure/hotandnew/hot_and_new_impl.dart' as _i4;
import '../../../infrastructure/search/search_impl.dart' as _i9;
import '../../downloads/i_download_repo.dart' as _i6;
import '../../hotandnew/hot_and_new_service.dart' as _i3;
import '../../search/search_service.dart' as _i8;

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
    gh.lazySingleton<_i3.HotAndNewService>(() => _i4.HotAndNewImplementation());
    gh.factory<_i5.HotandnewBloc>(
        () => _i5.HotandnewBloc(gh<_i3.HotAndNewService>()));
    gh.lazySingleton<_i6.IDownloadsRepo>(() => _i7.DownloadsReposetory());
    gh.lazySingleton<_i8.SearchService>(() => _i9.SearchImpl());
    gh.factory<_i10.DownloadsBloc>(
        () => _i10.DownloadsBloc(gh<_i6.IDownloadsRepo>()));
    gh.factory<_i11.FastLaughBloc>(
        () => _i11.FastLaughBloc(gh<_i6.IDownloadsRepo>()));
    gh.factory<_i12.HomeBloc>(() => _i12.HomeBloc(gh<_i3.HotAndNewService>()));
    gh.factory<_i13.SearchBloc>(() => _i13.SearchBloc(
          gh<_i6.IDownloadsRepo>(),
          gh<_i8.SearchService>(),
        ));
    return this;
  }
}
