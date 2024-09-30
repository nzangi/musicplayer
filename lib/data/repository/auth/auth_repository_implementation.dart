import 'package:dartz/dartz.dart';
import 'package:music_player/data/models/auth/create_user_request.dart';
import 'package:music_player/data/models/auth/signin_user_request.dart';
import 'package:music_player/data/sources/auth/auth_firebase_service.dart';
import 'package:music_player/domain/repository/auth/auth.dart';
import 'package:music_player/service_locator.dart';

class AuthRepositoryImplementation extends AuthRepository{


  @override
  Future<Either> signIn(SignInUserRequest request) async {
    return await serviceLocator<AuthFirebaseService>().signIn(request);
  }


  @override
  Future<Either> signUp(CreateUserRequest request) async{
    return await serviceLocator<AuthFirebaseService>().signUp(request);
  }

  @override
  Future<Either> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

}