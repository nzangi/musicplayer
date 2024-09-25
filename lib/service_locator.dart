import 'package:get_it/get_it.dart';
import 'package:music_player/data/repository/auth/auth_repository_implementation.dart';
import 'package:music_player/data/sources/auth/auth_firebase_service.dart';
import 'package:music_player/domain/repository/auth/auth.dart';
import 'package:music_player/domain/usecase/auth/signin.dart';
import 'package:music_player/domain/usecase/auth/signup.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {

  serviceLocator.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImplementation()
  );

  serviceLocator.registerSingleton<AuthRepository>(
      AuthRepositoryImplementation()
  );

  serviceLocator.registerSingleton<SignUpUseCase>(
      SignUpUseCase()
  );

  serviceLocator.registerSingleton<SignInUseCase>(
      SignInUseCase()
  );


}
