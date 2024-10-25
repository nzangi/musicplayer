import 'package:dartz/dartz.dart';

abstract class SongsRepository{
  Future<Either> getNewSongs();
  Future<Either> getNewPlayList();
  Future<Either> addOrRemoveFavouriteSong(String songId );
  Future<bool> isFavourite(String songId );
  Future<Either> getUserFavouriteSongs();


}