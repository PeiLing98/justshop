import 'package:final_year_project/components/video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SellerBusinessVideo extends StatefulWidget {
  final String businessVideo;
  const SellerBusinessVideo({Key? key, required this.businessVideo})
      : super(key: key);

  @override
  _SellerBusinessVideoState createState() => _SellerBusinessVideoState();
}

class _SellerBusinessVideoState extends State<SellerBusinessVideo> {
  VideoPlayerController controller = VideoPlayerController.network("");

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.businessVideo)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.pause());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color.fromARGB(250, 233, 221, 221),
          border: Border.all(width: 1, color: Colors.grey)),
      child: ClipRRect(
          child: widget.businessVideo != ""
              ? VideoPlayerBuilder(controller: controller)
              : null),
    );
  }
}
