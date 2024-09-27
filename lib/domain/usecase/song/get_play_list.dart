import 'package:dartz/dartz.dart';
import 'package:music_player/core/usecase/usecase.dart';
import 'package:music_player/domain/repository/song/song.dart';
import 'package:music_player/service_locator.dart';

class GetPlayListUseCase implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) async {
    return serviceLocator<SongsRepository>().getNewPlayList();
  }

}