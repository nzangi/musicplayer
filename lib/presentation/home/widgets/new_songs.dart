import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/common/helpers/is_dark_mode.dart';
import 'package:music_player/core/configs/contants/app_urls.dart';
import 'package:music_player/core/configs/theme/app_colors.dart';
import 'package:music_player/domain/entities/song/song.dart';
import 'package:music_player/presentation/home/bloc/new_songs_cubit.dart';
import 'package:music_player/presentation/home/bloc/new_songs_state.dart';
import 'package:music_player/presentation/song_player/pages/song_player.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewSongs(),
      child: SizedBox(
          height: 200,
          child: BlocBuilder<NewsSongsCubit, NewSongsState>(
            builder: (context, state) {
              if (state is NewSongsLoading) {
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              }
              if (state is NewSongsLoaded) {
                return _songs(state.songs);
              }
              return Container();
            },
          )),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String artist = Uri.encodeComponent(songs[index].artist);
          String title = Uri.encodeComponent(songs[index].title);
          String imageUrl =
              '${AppURLs.coverFirebaseStorage}$artist%20-%20$title.jpeg?alt=media';

          print(songs[index].artist);
          // print(imageUrl);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SongPlayerPage(
                            songEntity: songs[index],
                          )));
            },
            child: SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(imageUrl)),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 40,
                          width: 40,
                          transform: Matrix4.translationValues(10, 10, 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.isDarkMode
                                ? AppColors.darkGrey
                                : const Color(0xffE6E5E6),
                          ),
                          child: Icon(
                              color: context.isDarkMode
                                  ? const Color(0xff959595)
                                  : const Color(0xff555555),
                              Icons.play_arrow_rounded),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    songs[index].title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    songs[index].artist,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              width: 14,
            ),
        itemCount: songs.length);
  }
}
