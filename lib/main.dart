import 'package:audioplayers/audio_cache.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyApp());

AudioPlayer audioPlayer = AudioPlayer(playerId: 'my_unique_playerId');
var player = AudioCache(fixedPlayer: audioPlayer);

bool _isPlaying = false;
var currentTime = "00:00";
var completeTime = "00:00";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text("Sangeet"),
          leading: Icon(Icons.music_note),
        ),
        body: Column(
          children: <Widget>[
            Card(
              shadowColor: Colors.lightBlue,
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.album),
                title: Text("Music of the Era"),
                subtitle: Text("#1"),
                trailing: IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () => audioPlayer.stop(),
                ),
                onTap: () => player.play('audio/a1.mp3'),
              ),
            ),
            Card(
              shadowColor: Colors.lightBlue,
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.album),
                title: Text("Music of the Era"),
                subtitle: Text("#2"),
                trailing: IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () => audioPlayer.stop(),
                ),
                onTap: () => player.play('audio/a2.mp3'),
              ),
            ),
            Card(
              shadowColor: Colors.lightBlue,
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.album),
                title: Text("Music From Web"),
                subtitle: Text("Tap to Play"),
                trailing: IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () => audioPlayer.stop(),
                ),
                onTap: () async {
                  int result = await audioPlayer.play(
                      "https://github.com/ad-felix/flutter-dev/raw/master/Jeena%20Jeena%20(From%20%20Badlapur%20).mp3");
                  if (result == 1) {
                    // success
                  }
                },
              ),
            ),
            Card(
              shadowColor: Colors.lightBlue,
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.album),
                title: Text("| Local Music |"),
                subtitle: Text(
                    "- Tap to Pause/Resume - \n -- $currentTime / $completeTime --"),
                isThreeLine: true,
                trailing: IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    audioPlayer.stop();
                    _isPlaying = false;
                  },
                ),
                onTap: () {
                  if (_isPlaying) {
                    audioPlayer.pause();
                    _isPlaying = false;
                  } else {
                    audioPlayer.resume();
                    _isPlaying = true;
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.lightBlueAccent,
          child: Container(
            height: 50,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.audiotrack),
          onPressed: () async {
            var filePath = await FilePicker.getFilePath();
            int status = await audioPlayer.play(filePath, isLocal: true);

            if (status == 1) {
              _isPlaying = true;
            }
            audioPlayer.onAudioPositionChanged.listen((Duration duration) {
              currentTime = duration.toString().split('.')[0];
            });
            audioPlayer.onDurationChanged.listen((Duration duration) {
              completeTime = duration.toString().split('.')[0];
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}
