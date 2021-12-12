import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/providers/categories.dart';
import 'package:surdotv_app/providers/videos.dart';
import 'package:surdotv_app/widgets/bottom_nav_bar.dart';

import '../widgets/home_page_block.dart';
import '../widgets/main_carousel.dart';
import '../widgets/common_widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    print(DateTime.now());
    final _catProvider = Provider.of<Categories>(
      context,
      listen: false,
    );

    if (!_catProvider.isLoaded) {
      _catProvider.fetchAll();
    }

    final _videoProvider = Provider.of<Videos>(
      context,
      listen: false,
    );

    if (!_videoProvider.isLoaded) {
      _videoProvider.fetchAll();
      print('videos loaded ${_videoProvider.items.length}');
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _categories = Provider.of<Categories>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Hero(
            tag: 'logo',
            child: logoMSize,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        // bottomNavigationBar: BottomNavBar(selectedBar: 0),
        body: !_categories.isLoaded
            ? Center(child: CircularProgressIndicator())
            : _categories.items.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(tag: '1324', child: logoMSize),
                        Text('Serverlə əlaqə yaradıla bilmədi..'),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          child: Icon(
                            Icons.refresh,
                            size: 30,
                          ),
                          onTap: () {
                            _categories.fetchAll();
                          },
                        )
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MainCarousel(),
                        HomePageBlock(
                            leftHeader: _categories.items[0].name,
                            leftIcon: vCamera, //Icons.videocam_outlined,
                            rightHeader: 'Bütün filmlər',
                            videoList: _categories.items[0].videoList,
                            catId: _categories.items[0].id),
                        SizedBox(
                          height: 5,
                        ),
                        adsBlock(context),
                        HomePageBlock(
                          leftHeader: _categories.items[1].name,
                          leftIcon:
                              svgcartoon, //Icons.videogame_asset_outlined,
                          rightHeader: 'Bütün cizgi filmlər',
                          videoList: _categories.items[1].videoList,
                          catId: _categories.items[1].id,
                        ),
                      ],
                    ),
                  ));
  }
}
