import 'package:dartz/dartz.dart';
import 'package:music_player/core/usecase/usecase.dart';
import 'package:music_player/data/repository/song/song.dart';
import 'package:music_player/service_locator.dart';

class GetNewSongsUseCase implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) async {
    return serviceLocator<SongRepositoryImplementation>().getNewSongs();
  }

}