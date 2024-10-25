
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/usecase/auth/get_user.dart';
import 'package:music_player/presentation/profile/bloc/profile_info_state.dart';
import 'package:music_player/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState>{
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await serviceLocator<GetUserUseCase>().call();

    user.fold((l){
      print("Failed to get user: $l");  // Debugging line to see the error
      emit(ProfileInfoFailure());
    }, (userEntity){
      emit(ProfileInfoLoaded(userEntity: userEntity));
    });

  }

}