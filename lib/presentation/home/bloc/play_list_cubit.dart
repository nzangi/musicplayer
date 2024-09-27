import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/usecase/song/get_play_list.dart';
import 'package:music_player/presentation/home/bloc/play_list_state.dart';
import 'package:music_player/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState>{

  PlayListCubit()  : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await serviceLocator<GetPlayListUseCase>().call();
    returnedSongs.fold((l){
      emit(PlayListLoadingFailure());
    }, (data){
      emit(PlayListLoaded(songs: data));
    });

  }

}