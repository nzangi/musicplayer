import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player/common/widgets/button/basic_app_button.dart';
import 'package:music_player/presentation/choose_mode/pages/choose_mode.dart';
import 'package:music_player/core/configs/theme/app_colors.dart';
import 'package:music_player/core/assets/app_images.dart';
import 'package:music_player/core/assets/app_vectors.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(AppImages.introductionBackgroundImage))),
          ),
          Container(
            color: Colors.black.withOpacity(0.15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AppVectors.logo)),
                const Spacer(),
                const Text(
                  'Enjoy Listening to Music',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 21,
                ),
                const Text(
                  'Welcome to listen to your favourite music in the world. We have different albums for different artist in the world. Enjoy your favourite Music.',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                      fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 21,),
                AppButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ChooseModePage())
                  );
                }, title: "Get Started")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
