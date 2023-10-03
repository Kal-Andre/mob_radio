import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class OnlineRadioApp extends StatefulWidget {
  const OnlineRadioApp({super.key});

  @override
  _OnlineRadioAppState createState() => _OnlineRadioAppState();
}

class _OnlineRadioAppState extends State<OnlineRadioApp> {
  final String stationName = "Lambano Radio";
  final String currentProgram = "Morning Show";
  final String streamUrl = "https://lambano.com/radiostream"; 

  late AudioPlayer audioPlayer;
  PlayerState playerState = PlayerState.STOPPED;

  // Define variable for colour animation
  Color backgroundColor = Colors.blueAccent; // Initial color
  Color targetColor = Colors.lime; // Target color
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        playerState = state;
        // Change the target color based on the player state
        targetColor = (state == PlayerState.PLAYING) ? Colors.lime : Colors.blueAccent;
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
        title: const Text("Online Radio")
      ),

      // Wrap your content with an AnimatedContainer
         body: AnimatedContainer(
        duration: const Duration(milliseconds: 500), // Duration of the color transition
        color: backgroundColor, // Set the background color
        child: Center(
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
                onPressed: () {
                  playOrPause();
                  setState(() {
                    // Update the background color when the button is pressed
                    backgroundColor = targetColor;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
      /*body: Center(
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
}*/

void main() {
  runApp(const MaterialApp(
    home: OnlineRadioApp(),
    debugShowCheckedModeBanner: false,
  ));
}
