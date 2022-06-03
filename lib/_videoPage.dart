import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Homepage
class YoutubePage extends StatefulWidget {
  @override
  _YoutubePageState createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [
    'hoVkw8VqaaQ',
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                _controller.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                log('Settings Tapped!');
              },
            ),
          ],
          onReady: () {
            _isPlayerReady = true;
          },
        ),

        builder: (context, player) => Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () async {
                _controller.pause();
                Navigator.pushNamed(context, '/homePage');
              },
              child: Icon(Icons.arrow_back),
            ),
            title: const Text(
              'Materi Video',
              style: TextStyle(color: Colors.white),
            ),
            // actions: [
            //   IconButton(onPressed: (){},icon: Icon(Icons.video_library_rounded))
            // ],
          ),
          body: ListView(
            children: [
              player,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _space,
                    _text('Title', _videoMetaData.title),
                    _space,
                    _text('Channel', _videoMetaData.author),
                    _space,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // IconButton(
                        //   icon: const Icon(Icons.skip_previous),
                        //   onPressed: _isPlayerReady
                        //       ? () => _controller.load(_ids[
                        //           (_ids.indexOf(_controller.metadata.videoId) -
                        //                   1) %
                        //               _ids.length])
                        //       : null,
                        // ),
                        IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: _isPlayerReady
                              ? () {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                  setState(() {});
                                }
                              : null,
                        ),
                        IconButton(
                          icon:
                              Icon(_muted ? Icons.volume_off : Icons.volume_up),
                          onPressed: _isPlayerReady
                              ? () {
                                  _muted
                                      ? _controller.unMute()
                                      : _controller.mute();
                                  setState(() {
                                    _muted = !_muted;
                                  });
                                }
                              : null,
                        ),
                        FullScreenButton(
                          controller: _controller,
                          color: Colors.blueAccent,
                        ),
                        // IconButton(
                        //   icon: const Icon(Icons.skip_next),
                        //   onPressed: _isPlayerReady
                        //       ? () => _controller.load(_ids[
                        //           (_ids.indexOf(_controller.metadata.videoId) +
                        //                   1) %
                        //               _ids.length])
                        //       : null,
                        // ),
                      ],
                    ),
                    _space,
                    Row(
                      children: <Widget>[
                        const Text(
                          "Volume",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Expanded(
                          child: Slider(
                            inactiveColor: Colors.transparent,
                            value: _volume,
                            min: 0.0,
                            max: 100.0,
                            divisions: 10,
                            label: '${(_volume).round()}',
                            onChanged: _isPlayerReady
                                ? (value) {
                                    setState(() {
                                      _volume = value;
                                    });
                                    _controller.setVolume(_volume.round());
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                    _space,
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: _getStateColor(_playerState),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _playerState.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  MainYoutube() {}

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700];
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900];
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);
}