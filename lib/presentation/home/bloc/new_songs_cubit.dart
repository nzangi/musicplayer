import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/usecase/song/get_new_songs.dart';
import 'package:music_player/presentation/home/bloc/new_songs_state.dart';
import 'package:music_player/service_locator.dart';

class NewsSongsCubit extends Cubit<NewSongsState>{

  NewsSongsCubit()  : super(NewSongsLoading());

  Future<void> getNewSongs() async {
    var returnedSongs = await serviceLocator<GetNewSongsUseCase>().call();
    returnedSongs.fold((l){
      emit(NewSongsLoadingFailure());
    }, (data){
      emit(NewSongsLoaded(songs: data));
    });

  }

}