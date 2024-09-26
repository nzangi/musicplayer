import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_player/common/helpers/is_dark_mode.dart';
import 'package:music_player/core/assets/app_images.dart';
import 'package:music_player/core/configs/theme/app_colors.dart';

import '../../../common/widgets/appbar/my_app_bar.dart';
import '../../../core/assets/app_vectors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        hideBack: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_homeTopCard(), _tabs()],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 120,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homeTopCard),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Image.asset(AppImages.homeArtist),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        controller: _tabController,
        indicatorColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        tabs: const [
          Text(
            'News',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          Text(
            'Videos',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          Text(
            'Artist',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          Text(
            'Podcasts',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
        ]);
  }
}