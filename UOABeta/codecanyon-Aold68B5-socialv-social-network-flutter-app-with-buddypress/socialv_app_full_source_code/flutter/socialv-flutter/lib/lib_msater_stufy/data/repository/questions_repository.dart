
import 'package:inject/inject.dart';
import 'package:socialv/lib_msater_stufy/data/models/QuestionAddResponse.dart';
import 'package:socialv/lib_msater_stufy/data/models/QuestionsResponse.dart';
import 'package:socialv/lib_msater_stufy/data/network/api_provider.dart';

abstract class QuestionsRepository {
  Future<QuestionsResponse> getQuestions(int lessonId, int page, String search, String authorIn);

  Future<QuestionAddResponse> addQuestion(int lessonId, String comment, int parent);
}

@provide
class QuestionsRepositoryImpl extends QuestionsRepository {
  final UserApiProvider _userApiProvider;

  QuestionsRepositoryImpl(this._userApiProvider);

  @override
  Future<QuestionsResponse> getQuestions(int lessonId, int page, String search, String authorIn) {
    return _userApiProvider.getQuestions(lessonId, page, search, authorIn);
  }

  @override
  Future<QuestionAddResponse> addQuestion(int lessonId, String comment, int parent) {
    return _userApiProvider.addQuestion(lessonId, comment, parent);
  }
}
