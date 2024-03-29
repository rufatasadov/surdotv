import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/detail_screen.dart';

class GridItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;

  GridItem({this.id, this.title, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 160,

      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      height: double.infinity,

                      //  width: double.infinity,
                      // padding: EdgeInsets.all(20),
                      color: Theme.of(context).colorScheme.primary,

                      child: CachedNetworkImage(
                        imageUrl: imgUrl,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    //   child: Image.network(
                    //     imgUrl,
                    //     fit: BoxFit.fill,
                    // ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                      child: InkWell(
                        splashColor: Colors.green,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(DetailScreen.routeName, arguments: {
                            'id': id,
                          });
                        },
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          ConstrainedBox(
            constraints: new BoxConstraints(
              minHeight: 35.0,
              maxHeight: 60.0,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
