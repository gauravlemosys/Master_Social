import 'package:equatable/equatable.dart';
import 'package:socialv/lib_msater_stufy/data/models/user_course.dart';

abstract class UserCoursesState extends Equatable {
  const UserCoursesState();
}

class InitialUserCoursesState extends UserCoursesState {
  @override
  List<Object> get props => [];
}

class ErrorUserCoursesState extends UserCoursesState {
  @override
  List<Object> get props => [];
}

class EmptyCoursesState extends UserCoursesState {
  @override
  List<Object> get props => [];
}

class EmptyCacheCoursesState extends UserCoursesState {
  @override
  List<Object> get props => [];
}

class LoadedCoursesState extends UserCoursesState {
  final List<PostsBean?> courses;

  LoadedCoursesState(this.courses);

  @override
  List<Object>? get props => null;
}
