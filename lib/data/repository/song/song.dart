import 'package:dartz/dartz.dart';
import 'package:music_player/data/sources/song/song_firebase_service.dart';
import 'package:music_player/domain/repository/song/song.dart';
import 'package:music_player/service_locator.dart';


class SongRepositoryImplementation extends SongsRepository{
  @override
  Future<Either> getNewSongs({params}) async {
    return await serviceLocator<SongFirebaseService>().getNewSongs();
  }
}