import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/common/bloc/favourite/favourite_button_cubit.dart';
import 'package:music_player/common/bloc/favourite/favourite_button_state.dart';
import 'package:music_player/domain/entities/song/song.dart';

import '../../../core/configs/theme/app_colors.dart';

class MyFavouriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function ? function;
  const MyFavouriteButton({required this.songEntity, this.function ,super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteButtonCubit(),
      child: BlocBuilder<FavouriteButtonCubit, FavouriteButtonState>(
          builder: (context, state) {
        if (state is FavouriteButtonInitialize) {
          return IconButton(
              onPressed: () async {
                await context.read<FavouriteButtonCubit>().favouriteButtonUpdated(songEntity.songId);
                if(function != null){
                  function!();
                }
              },

              icon: Icon(
                songEntity.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: 35,
                color: AppColors.darkGrey,
              ));
        }
        if (state is FavouriteButtonUpdated) {
          return IconButton(
              onPressed: () {
                context.read<FavouriteButtonCubit>().favouriteButtonUpdated(songEntity.songId);
              },
              icon: Icon(
                state.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: 35,
                color: AppColors.darkGrey,
              ));
        }

        return Container();
      }),
    );
  }
}
