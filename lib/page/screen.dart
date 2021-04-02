import 'package:flutter/material.dart';
import 'package:media_player/media_player.dart';
import 'package:media_player/data_sources.dart';

class RadioPlayerScreen extends StatefulWidget {
  final MediaFile source;
  final Playlist playlist;

  RadioPlayerScreen({this.source, this.playlist});

  _RadioPlayerScreenState createState() => _RadioPlayerScreenState();
}

class _RadioPlayerScreenState extends State<RadioPlayerScreen> {
  MediaPlayer player;
  int currentIndex;
  var currentSource;
  bool isPlaying = true;

  @override
  void initState() {
    player =
        MediaPlayerPlugin.create(isBackground: false, showNotification: true);
    initVideoPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  player.dispose();
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  void initVideoPlayer() async {
    await player.initialize();

    player.valueNotifier.addListener(() {
      this.currentIndex = player.valueNotifier.value.currentIndex;
      this.currentSource = player.valueNotifier.value.source;
      setState(() {});
    });

    if (widget.source != null) await player.setSource(widget.source);
    if (widget.playlist != null) await player.setPlaylist(widget.playlist);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          body: Column(
            children: <Widget>[showLogo(), playlistView()],
          ),
        ),
      ),
    );
  }

  Widget showLogo() {
    return Image.asset("image/logo.png");
  }

  Widget playlistView() {
    return (this.currentSource is Playlist)
        ? Expanded(
            child: ListView.builder(
              itemCount: widget.playlist.count,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(this.currentSource.mediaFiles[index].title),
                  trailing: IconButton(
                      onPressed: () {
                        this.player.pause();                        
                        Future.delayed(const Duration(seconds: 1), () {
                          setState(() {
                            this.player.playAt(index);
                            this.player.play();
                          });
                        });
                      },
                      icon: Icon(
                        this.currentIndex == index
                            ? Icons.pause
                            : Icons.play_arrow,
                      )),
                );
              },
            ),
          )
        : Container(
            child: Text("No Playlist"),
          );
  }
}
