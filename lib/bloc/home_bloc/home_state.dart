part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeSuccess extends HomeState {
  final Data? data;
  HomeSuccess({@required this.data});
}
class HomeFailed extends HomeState {
  final String? message;
  HomeFailed({@required this.message});
}
class HomeError extends HomeState {
  final String? message;
  HomeError({@required this.message});
}
