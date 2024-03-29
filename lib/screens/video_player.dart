import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import '../widgets/video_player_vimeo.dart';

class MyVideoPlayer extends StatefulWidget {
  static const route_name = '/video-player';

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  var videoId = '';
  var _maxHeight = 0.0;

  var _isFullScreen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_maxHeight == 0.0) {
      _maxHeight = MediaQuery.of(context).size.height;
    }
    if (videoId.isEmpty) {
      videoId = ModalRoute.of(context).settings.arguments;
      print('video = ' + videoId);
    }

    super.didChangeDependencies();
  }

  void _changeScreenMode() {
    if (_isFullScreen) {
      _escapeFullScreen();
    } else {
      _makeFullScreen();
    }
  }

  void _makeFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    setState(() {
      _maxHeight = MediaQuery.of(context).size.height;

      _isFullScreen = true;
    });
  }

  void _escapeFullScreen() {
    _isFullScreen = false;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    _escapeFullScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.secondary
              ..withOpacity(_isFullScreen ? 0.5 : 1),
            child: Icon(
              Icons.fullscreen,
              color: Colors.white,
            ),
            onPressed: () {
              if (_isFullScreen) {
                _escapeFullScreen();
              } else {
                _makeFullScreen();
              }
            },
          ),
          SizedBox(
            height: 6,
          ),
          FloatingActionButton(
            backgroundColor: Theme.of(context)
                .colorScheme
                .secondary
                .withOpacity(_isFullScreen ? 0.5 : 1),
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              _escapeFullScreen();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: InkWell(
              onDoubleTap: _changeScreenMode, child: MyVimeoPlayer(videoId)),
        ),
        // Positioned(
        //   top: _maxHeight - 80,
        //   left: _maxWidth - 80,
        //   child: IconButton(
        //     icon: Icon(
        //       Icons.fullscreen,
        //       size: 80,
        //     ),
        //     onPressed: () {
        //       if (!_isFullScreen) {
        //         print('object cliecked');
        //         setState(() {
        //           _makeFullScreen();
        //         });
        //       } else {
        //         print('d cliecked');
        //         _escapeFullScreen();
        //       }
        //     },
        //   ),
        // )
      ]),
    );
  }
}
