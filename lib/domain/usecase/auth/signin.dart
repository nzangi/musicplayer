import 'package:dartz/dartz.dart';
import 'package:music_player/core/usecase/usecase.dart';
import 'package:music_player/data/models/auth/create_user_request.dart';
import 'package:music_player/data/models/auth/signin_user_request.dart';
import 'package:music_player/domain/repository/auth/auth.dart';
import 'package:music_player/service_locator.dart';

class SignInUseCase implements UseCase<Either,SignInUserRequest>{
  @override
  Future<Either> call({SignInUserRequest ? params}) async {
    return serviceLocator<AuthRepository>().signIn(params!);
  }

}