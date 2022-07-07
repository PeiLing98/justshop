import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerBuilder extends StatefulWidget {
  final VideoPlayerController controller;
  const VideoPlayerBuilder({Key? key, required this.controller})
      : super(key: key);

  @override
  _VideoPlayerBuilderState createState() => _VideoPlayerBuilderState();
}

class _VideoPlayerBuilderState extends State<VideoPlayerBuilder> {
  @override
  Widget build(BuildContext context) => Container(
        child: buildVideo(),
      );

  Widget buildVideo() =>
      Stack(children: [buildVideoPlayer(), basicOverlayWidget()]);

  Widget buildVideoPlayer() => VideoPlayer(widget.controller);

  Widget basicOverlayWidget() => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => widget.controller.value.isPlaying
            ? widget.controller.pause()
            : widget.controller.play(),
        child: Stack(
          children: [
            buildPlay(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildIndicator(),
            )
          ],
        ),
      );

  Widget buildIndicator() =>
      VideoProgressIndicator(widget.controller, allowScrubbing: true);

  Widget buildPlay() => widget.controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 30,
          ));
}
