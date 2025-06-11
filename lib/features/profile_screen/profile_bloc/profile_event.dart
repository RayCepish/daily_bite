part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUserProfile extends ProfileEvent {}

class LogoutRequested extends ProfileEvent {}

class LogoutSuccess extends ProfileEvent {}

class UpdateUserProfile extends ProfileEvent {
  final File? photo;

  UpdateUserProfile({this.photo});

  @override
  List<Object?> get props => [photo];
}
