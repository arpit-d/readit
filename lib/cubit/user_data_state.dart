part of 'user_data_cubit.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

class UserDataInitial extends UserDataState {
  @override
  List<Object> get props => [];
}

class UserDataLoadingState extends UserDataState {
  @override
  List<Object> get props => [];
}

class UserDataLoadedState extends UserDataState {
  UserDataLoadedState(this.userData);

  final UserDataModel userData;

  @override
  List<Object> get props => [userData];
}

class UserDataErrorState extends UserDataState {
  @override
  List<Object> get props => [];
}
