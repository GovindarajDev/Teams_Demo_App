part of 'invited_cubit.dart';

@immutable
abstract class InvitedState {}

class InvitedInitial extends InvitedState {}
class InvitedLoading extends InvitedState {}
class InvitedSuccess extends InvitedState {}
class InvitedFailed extends InvitedState {
  final String? message;
  InvitedFailed({@required this.message});
}
class InvitedError extends InvitedState {
  final String? message;
  InvitedError({@required this.message});
}
