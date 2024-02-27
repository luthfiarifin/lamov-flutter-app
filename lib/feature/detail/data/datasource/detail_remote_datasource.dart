import 'package:injectable/injectable.dart';

import '../../../../core/data/network/network.dart';
import '../../../../core/domain/common/model/model.dart';

abstract class DetailRemoteDataSource {
  Future<MovieModel> getDetailMovie(int id);
}

@LazySingleton(as: DetailRemoteDataSource)
class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  final ApiClient client;

  const DetailRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<MovieModel> getDetailMovie(int id) {
    return client.get(
      '${ApiConstant.movie}/$id',
      queryParameters: {
        'append_to_response': 'videos,credits',
      },
      converter: (e) => MovieModel.fromJson(e),
    );
  }
}
