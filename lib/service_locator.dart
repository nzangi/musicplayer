import 'package:get_it/get_it.dart';
import 'package:music_player/data/repository/auth/auth_repository_implementation.dart';
import 'package:music_player/data/repository/song/song.dart';
import 'package:music_player/data/sources/auth/auth_firebase_service.dart';
import 'package:music_player/domain/repository/auth/auth.dart';
import 'package:music_player/domain/repository/song/song.dart';
import 'package:music_player/domain/usecase/auth/signin.dart';
import 'package:music_player/domain/usecase/auth/signup.dart';
import 'package:music_player/domain/usecase/song/get_new_songs.dart';
import 'package:music_player/domain/usecase/song/get_play_list.dart';

import 'data/sources/song/song_firebase_service.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {

  serviceLocator.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImplementation()
  );

  serviceLocator.registerSingleton<SongFirebaseService>(
      SongFirebaseServiceImplementation()
  );

  serviceLocator.registerSingleton<AuthRepository>(
      AuthRepositoryImplementation()
  );

  serviceLocator.registerSingleton<SongsRepository>(
      SongsRepositoryImplementation()
  );

  serviceLocator.registerSingleton<SignUpUseCase>(
      SignUpUseCase()
  );

  serviceLocator.registerSingleton<SignInUseCase>(
      SignInUseCase()
  );

  serviceLocator.registerSingleton<GetNewSongsUseCase>(
      GetNewSongsUseCase()
  );

  serviceLocator.registerSingleton<GetPlayListUseCase>(
      GetPlayListUseCase()
  );
}
