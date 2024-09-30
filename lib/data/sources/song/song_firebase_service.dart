import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_player/data/models/song/song.dart';
import 'package:music_player/domain/entities/song/song.dart';
import 'package:music_player/domain/usecase/song/is_favourite_song.dart';
import 'package:music_player/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewSongs();
  Future<Either> getNewPlayList();
  Future<Either> addOrRemoveFavouriteSong(String songId); 
  Future<bool> isFavourite(String songId);

}

class SongFirebaseServiceImplementation extends SongFirebaseService {
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavourite = await serviceLocator<IsFavouriteSongUseCase>().call(
          params : element.reference.id
        );
        songModel.isFavourite = isFavourite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return const Left('An error occurred,Please try again.');
    }
  }

  @override
  Future<Either> getNewPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());

        bool isFavourite = await serviceLocator<IsFavouriteSongUseCase>().call(
            params : element.reference.id
        );

        songModel.isFavourite = isFavourite;
        songModel.songId = element.reference.id;

        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return const Left('An error occurred,Please try again.');
    }
  }

  @override
  Future<Either> addOrRemoveFavouriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      late bool isFavourite;

      var user = firebaseAuth.currentUser;
      String uid = user!.uid;
      QuerySnapshot favouriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uid)
          .collection('Favourites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favouriteSongs.docs.isNotEmpty) {
        await favouriteSongs.docs.first.reference.delete();
        isFavourite = false;
      } else {
        await firebaseFirestore
            .collection('Users')
            .doc(uid)
            .collection('Favourites')
            .add({'songId': songId, 'addedDate': Timestamp.now()});
        isFavourite = true;
      }
      return Right(isFavourite);

    } catch (e) {
      return const Left('An Error Occurred');
    }
  }


  @override
  Future<bool> isFavourite(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uid = user!.uid;
      QuerySnapshot favouriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uid)
          .collection('Favourites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favouriteSongs.docs.isNotEmpty) {
        return true;

      } else {
        return false;
      }

    } catch (e) {
      return false;
    }
  }
}
