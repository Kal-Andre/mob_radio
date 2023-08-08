import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class OnlineRadioApp extends StatefulWidget {
  @override
  _OnlineRadioAppState createState() => _OnlineRadioAppState();
}

class _OnlineRadioAppState extends State<OnlineRadioApp> {
  final String stationName = "Lambano Radio";
  final String currentProgram = "Morning Show";
  final String streamUrl = "https://lambano.com/radiostream"; 

  late AudioPlayer audioPlayer;
  PlayerState playerState = PlayerState.STOPPED;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        playerState = state;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  void playOrPause() async {
    if (playerState == PlayerState.PLAYING) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(streamUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Online Radio"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              stationName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Now Playing: $currentProgram",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: Icon(
                playerState == PlayerState.PLAYING
                    ? Icons.pause
                    : Icons.play_arrow,
                size: 48,
              ),
              onPressed: playOrPause,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OnlineRadioApp(),
  ));
}
