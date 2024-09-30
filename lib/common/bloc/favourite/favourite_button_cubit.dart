import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/common/bloc/favourite/favourite_button_state.dart';
import 'package:music_player/domain/usecase/song/add_or_remove_favourite.dart';
import 'package:music_player/service_locator.dart';

class FavouriteButtonCubit extends Cubit<FavouriteButtonState>{
  FavouriteButtonCubit() : super(FavouriteButtonInitialize());

  void favouriteButtonUpdated(String songId) async{
    var result = await serviceLocator<AddOrRemoveFavouriteSongUseCase>().call(
      params: songId
    );
    result.fold((l){}, (isFavourite){
      emit(FavouriteButtonUpdated(isFavourite: isFavourite));
    });
  }

}