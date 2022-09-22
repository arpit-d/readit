import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:readit/models/user_data_model.dart';
import 'package:readit/repository/user_data_repository.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this._userDataRepository) : super(UserDataInitial()) {
    getUserData();
  }
  final UserDataRepository _userDataRepository;

  void getUserData() async {
    try {
      emit(UserDataLoadingState());
      final userData = await _userDataRepository.getUserData();
      emit(UserDataLoadedState(userData));
    } catch (e) {
      emit(UserDataErrorState());
    }
  }
}
