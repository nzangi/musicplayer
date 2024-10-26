import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/entities/song/song.dart';
import 'package:music_player/domain/usecase/song/get_favourite_songs.dart';
import 'package:music_player/presentation/profile/bloc/favourite_songs_state.dart';
import 'package:music_player/service_locator.dart';

class FavouriteSongsCubit extends Cubit<FavouriteSongsState>{
  FavouriteSongsCubit() : super(FavouriteSongsLoading());

  List<SongEntity> favouriteSongs = [];

  Future<void> getFavouriteSongs() async{
    var result = await serviceLocator<GetFavouriteSongsUseCase>().call();
    
    result.fold((l){
      emit(FavouriteSongsFailure());

    }, (r){
      favouriteSongs = r;
      emit(FavouriteSongsLoaded(favouriteSongs : favouriteSongs));
    });
  }
  void removeSong(int index){
    favouriteSongs.removeAt(index);
    emit(FavouriteSongsLoaded(favouriteSongs : favouriteSongs));
  }
}