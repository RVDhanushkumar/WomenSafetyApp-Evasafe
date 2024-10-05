import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'login_screen.dart'; // Ensure the correct path to your login_screen.dart

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/evasafe_open_video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(false); // Disable looping for one-time play
        _controller.play();
      });

    // Listen for when the video completes
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Expands the video to fit the entire screen
        children: [
          _controller.value.isInitialized
              ? FittedBox(
                  fit: BoxFit.cover, // Makes the video cover the entire background
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                )
              : Container(color: Colors.black), // Black background while video loads
          // Add any additional widgets on top of the video here
        ],
      ),
    );
  }
}
