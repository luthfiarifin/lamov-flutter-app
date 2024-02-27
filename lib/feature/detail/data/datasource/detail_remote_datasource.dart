import 'package:injectable/injectable.dart';

import '../../../../core/data/network/network.dart';
import '../../../../core/domain/common/model/model.dart';
import '../../domain/param/param.dart';

abstract class DetailRemoteDataSource {
  Future<MovieModel> getDetail(int id);
  Future<BaseModel<ReviewModel>> getReviews(GetReviewParam param);
}

@LazySingleton(as: DetailRemoteDataSource)
class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  final ApiClient client;

  const DetailRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<MovieModel> getDetail(int id) {
    return client.get(
      '${ApiConstant.movie}/$id',
      queryParameters: {
        'append_to_response': 'videos,credits',
      },
      converter: (e) => MovieModel.fromJson(e),
    );
  }

  @override
  Future<BaseModel<ReviewModel>> getReviews(GetReviewParam param) {
    return client.get(
      '${ApiConstant.movie}/${param.id}/${ApiConstant.reviews}',
      queryParameters: {
        'page': param.page,
      },
      converter: (e) => BaseModel.fromJson(
        e,
        (e) => ReviewModel.fromJson(e),
      ),
    );
  }
}
