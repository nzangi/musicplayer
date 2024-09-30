import 'package:dartz/dartz.dart';
import 'package:music_player/data/sources/song/song_firebase_service.dart';
import 'package:music_player/domain/repository/song/song.dart';
import 'package:music_player/service_locator.dart';


class SongsRepositoryImplementation extends SongsRepository{
  @override
  Future<Either> getNewSongs({params}) async {
    return await serviceLocator<SongFirebaseService>().getNewSongs();
  }

  @override
  Future<Either> getNewPlayList() async{
    return await serviceLocator<SongFirebaseService>().getNewPlayList();

  }

  @override
  Future<Either> addOrRemoveFavouriteSong(String songId) async {
    return await serviceLocator<SongFirebaseService>().addOrRemoveFavouriteSong(songId);

  }

  @override
  Future<bool> isFavourite(String songId) async {
    return await serviceLocator<SongFirebaseService>().isFavourite(songId);

  }
}