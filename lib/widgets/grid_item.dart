import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String title;
  GridItem(this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  color: Theme.of(context).colorScheme.primary,
                  child: Image.network(
                    'https://surdotv.az/uploads/min-bir-ilme---197_29.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
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
                    onTap: () {/* ... */},
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
          SizedBox(
            height: 3,
          ),
          Container(
            height: 20,
            alignment: Alignment.bottomLeft,
            child: Text('footer text here -> $title'),
          ),
        ],
      ),
    );
  }
}