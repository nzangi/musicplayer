import 'package:dartz/dartz.dart';
import 'package:music_player/core/usecase/usecase.dart';
import 'package:music_player/data/models/auth/signin_user_request.dart';
import 'package:music_player/domain/repository/auth/auth.dart';
import 'package:music_player/service_locator.dart';

class GetUserUseCase implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({ params}) async {
    return serviceLocator<AuthRepository>().getUser();
  }

}