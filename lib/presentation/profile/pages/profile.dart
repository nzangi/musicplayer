import 'package:flutter/material.dart';
import 'package:music_player/common/helpers/is_dark_mode.dart';
import 'package:music_player/common/widgets/appbar/my_app_bar.dart';
import 'package:music_player/core/configs/theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        backgroundColor:  AppColors.darkGrey ,
        title: Text('Profile')
      ),
      body: Column(
        children: [
          _profileInformation(context)
        ],
      ),
    );
  }
  Widget _profileInformation(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkGrey : Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30)
        )
      ),
    );
  }
}
