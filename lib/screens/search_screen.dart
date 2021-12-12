import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/models/video_item.dart';
import 'package:surdotv_app/providers/search.dart';
import 'package:surdotv_app/widgets/bottom_nav_bar.dart';
import 'package:surdotv_app/widgets/grid_item.dart';

import '../widgets/common_widgets.dart';

class SearchScreen extends StatefulWidget {
  static const route_name = '/search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController edt = new TextEditingController();
  List<VideoItem> _videos = [];
  var _isLoading = false;

  final List<String> _mostSearched = [
    'Yerli filmlər',
    'Qısametrajlı filmlər',
    'Qısametrajlı filmlər'
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Do something here
        if (edt.text == '') {
          return true;
        } else {
          setState(() {
            edt.text = '';
          });
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.undo))],
          centerTitle: true,
          elevation: 0,
          title: logoMSize,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
          leading: '' != ''
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      edt.text = '';
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  color: Colors.black,
                )
              : null,
        ),
        //  bottomNavigationBar: BottomNavBar(selectedBar: 3),
        body: Container(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: edt,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (txt) {
                    _doSearch(context, txt);
                  },
                  decoration: myInputDecoration(
                    aHintText: 'Axtar ...',
                    aSuffixIcon: Icons.search,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _mostSearched
                      .map((e) => OutlinedButton(
                            onPressed: () {
                              edt.text = e;

                              _doSearch(context, e);
                            },
                            child: Text(e),
                            style: outlinedButtonStyle,
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 5 / 4,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: _videos.length,
                        itemBuilder: ((ctx, i) => GridTile(
                              child: GridItem(
                                  id: _videos[i].id,
                                  imgUrl: _videos[i].getImageUrl,
                                  title: _videos[i].videoHead),
                            )),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doSearch(BuildContext context, String txt) {
    setState(() {
      _isLoading = true;
    });

    final searchData = Provider.of<SearchData>(context, listen: false);
    searchData.fetchData(txt).then((_) {
      setState(() {
        _videos = searchData.items;
        _isLoading = false;
      });
    });
  }
}
