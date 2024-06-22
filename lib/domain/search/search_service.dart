import 'package:dartz/dartz.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';

import 'model/search_resp/search_resp.dart';

abstract class SearchService {
  Future<Either<MainFailure, SearchResp>> searchMovies({
    required String movieQuery,
  });
}
