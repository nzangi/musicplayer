import 'package:dartz/dartz.dart';
import 'package:music_player/data/models/auth/create_user_request.dart';
import 'package:music_player/data/models/auth/signin_user_request.dart';

abstract class AuthRepository{
  Future<Either> signUp(CreateUserRequest request);
  Future<Either> signIn(SignInUserRequest request);
  Future<Either> getUser();
}