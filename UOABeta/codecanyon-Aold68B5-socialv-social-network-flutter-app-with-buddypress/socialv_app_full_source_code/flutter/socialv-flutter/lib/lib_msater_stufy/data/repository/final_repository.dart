import 'package:inject/inject.dart';
import 'package:socialv/lib_msater_stufy/data/models/FinalResponse.dart';
import 'package:socialv/lib_msater_stufy/data/network/api_provider.dart';

abstract class FinalRepository {
  Future<FinalResponse> getCourseResults(int courseId);
}

@provide
@singleton
class FinalRepositoryImpl implements FinalRepository {
  final UserApiProvider apiProvider;

  FinalRepositoryImpl(this.apiProvider);

  @override
  Future<FinalResponse> getCourseResults(int courseId) {
    return apiProvider.getCourseResults(courseId);
  }
}
