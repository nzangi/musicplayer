import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/common/bloc/favourite/favourite_button_cubit.dart';
import 'package:music_player/common/helpers/is_dark_mode.dart';
import 'package:music_player/common/widgets/appbar/my_app_bar.dart';
import 'package:music_player/core/configs/theme/app_colors.dart';
import 'package:music_player/presentation/profile/bloc/favourite_songs_state.dart';
import 'package:music_player/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:music_player/presentation/profile/bloc/profile_info_state.dart';
import 'package:music_player/presentation/song_player/pages/song_player.dart';

import '../../../common/widgets/favourite button/my_favourite_button.dart';
import '../../../core/configs/contants/app_urls.dart';
import '../bloc/favourite_songs_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
          backgroundColor: AppColors.darkGrey, title: Text('Profile')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_profileInformation(context),
          const SizedBox(height: 30,),
          _favouriteSongs()],
      ),
    );
  }

  Widget _profileInformation(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        decoration: BoxDecoration(
            color: context.isDarkMode ? AppColors.darkGrey : Colors.white,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
            builder: (context, state) {
          if (state is ProfileInfoLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }

          if (state is ProfileInfoLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(state.userEntity.imageURL!))),
                  ),
                  const SizedBox(height: 15,),
                  Text(state.userEntity.email!),
                  const SizedBox(height: 10,),
                  Text(state.userEntity.fullName!,style: const TextStyle(
                    fontSize: 22,fontWeight: FontWeight.bold
                  ),)
                  
                ],
              ),
            );
          }

          if (state is ProfileInfoFailure) {
            return const Text('Please try again!');
          }

          return Container();
        }),
      ),
    );
  }

  Widget _favouriteSongs(){
    return BlocProvider(create: (context) => FavouriteSongsCubit()..getFavouriteSongs(),
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('FAVORITE SONGS'),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<FavouriteSongsCubit,FavouriteSongsState>(builder: (context,state){
              if(state is FavouriteSongsLoading){
                return const CircularProgressIndicator();
              }

              if (state is FavouriteSongsLoaded){
                print('Favourite songs loaded');
                if (state.favouriteSongs.isEmpty) {
                    return const Text('No favourite songs found.');
                }
                return ListView.separated(
                  shrinkWrap: true,
                    itemBuilder: (context,index){
                      String artist = Uri.encodeComponent(state.favouriteSongs[index].artist);
                      String title = Uri.encodeComponent(state.favouriteSongs[index].title);
                      String imageUrl = '${AppURLs.coverFirebaseStorage}$artist%20-%20$title.jpeg?alt=media';
                      // print('Image URL : $imageUrl');
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> SongPlayerPage(songEntity: state.favouriteSongs[index])));
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(image: NetworkImage(
                                          imageUrl
                                      ))
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.favouriteSongs[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        state.favouriteSongs[index].artist,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400, fontSize: 10),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(state.favouriteSongs[index].duration.toString().replaceAll('.', ':')),
                                  const SizedBox(
                                    width: 20,
                                  ),

                                  MyFavouriteButton(songEntity: state.favouriteSongs[index],
                                    key: UniqueKey(),
                                    function: (){
                                    context.read<FavouriteSongsCubit>().removeSong(index);
                                  },),
                                ],
                              )
                            ],
                          ),

                      );
                    },
                    separatorBuilder: (context,index) => const SizedBox(height: 20,),
                    itemCount: state.favouriteSongs.length);
              }


              if(state is FavouriteSongsFailure){
                print('Failed to load favourite songs');
                return const Text('Please Try Again');
              }
              print('State is not FavouriteSongsLoaded');
              return Container(
              );
            })
          ],
        ),
      ),
    );
  }
}
