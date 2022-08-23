import 'package:animax/modules/dashboard/anime_viewer/Season/SeasonController.dart';
import 'package:animax/utils/services/AnimeService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../core/models/anime_detail/anime_detail.dart';
import 'Season/SeasonViewer.dart';

class AnimeViewer extends StatefulWidget {
  AnimeDetail animeDetail;

  AnimeViewer(this.animeDetail);

  @override
  State<AnimeViewer> createState() => _AnimeViewerState();
}

class _AnimeViewerState extends State<AnimeViewer> {
  SeasonController seasonController = Get.put(SeasonController());

  @override
  Widget build(BuildContext context) {
    List<Video> videos = List<Video>.from(widget.animeDetail.videos!);
    Widget _playView(BuildContext context) {
      final controller = seasonController.controller;
      if (controller.value.isInitialized) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              VideoPlayer(seasonController.controller),
              _ControlsOverlay(controller: seasonController.controller),
              VideoProgressIndicator(
                seasonController.controller,
                colors: VideoProgressColors(playedColor: Colors.green.shade600),
                allowScrubbing: true,
              ),
            ],
          ),
        );
      } else {
        return const AspectRatio(
            aspectRatio: 16 / 9, child: Center(child: Text("Loading ...")));
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Obx(() => seasonController.playVideo.value
                    ? _playView(context)
                    : animeBackDrop()),
                Positioned(
                    top: 25,
                    left: 15,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green.shade600,
                          borderRadius: BorderRadius.circular(40)),
                      child: IconButton(
                          color: Colors.white,
                          tooltip: "Back",
                          onPressed: () => {Get.back()},
                          icon: const Icon(Icons.arrow_back_outlined)),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.animeDetail.name ?? "",
                      style: const TextStyle(fontSize: 30),
                      textAlign: TextAlign.left),
                  const SizedBox(
                    height: 7,
                  ),
                  Text('${widget.animeDetail.dateOfRelease}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      widget.animeDetail.videos!.isNotEmpty
                          ? TextButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                              label: const Text(
                                "Play",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(
                                Icons.play_circle,
                                color: Colors.white,
                              ),
                              onPressed: () => {
                                seasonController.playVideo.value = false,
                                seasonController.playVideo.refresh(),
                                seasonController.onTapVideo(
                                    videos.first.videoBlobFile!.vbId!)
                              },
                            )
                          : const SizedBox(),
                      widget.animeDetail.videos!.isNotEmpty
                          ? const SizedBox(
                              width: 10,
                            )
                          : const SizedBox(),
                      OutlinedButton.icon(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          side: const BorderSide(color: Colors.white),
                        ),
                        label: const Text(
                          "My List",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          addToMyList(widget.animeDetail.aid);
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        label: const Text(
                          "Trailer",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () => {},
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.animeDetail.description ?? "",
                    style: const TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SeasonViewer(videos,
                      isSeason: widget.animeDetail.animeType == 'single'
                          ? false
                          : true,
                      key: const ValueKey(100)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    seasonController.controller.dispose();
    super.dispose();
  }

  Image animeBackDrop() {
    return Image.network(
      widget.animeDetail.animeBackdrop ?? "",
      height: 300,
      fit: BoxFit.fitHeight,
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  _ControlsOverlay({Key? key, required this.controller}) : super(key: key);

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration(),
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;
  RxBool playing = false.obs;
  RxDouble speedVal = RxDouble(1);
  RxBool noMute = false.obs;

  @override
  Widget build(BuildContext context) {
    debugPrint('${controller.value.isPlaying}');
    playing.value = controller.value.isPlaying;
    debugPrint('${controller.value.duration.inMinutes}');
    noMute.value = (controller.value.volume) > 0;
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: Obx(
            () => playing.value
                ? const SizedBox.shrink()
                : Container(
                    color: Colors.black26,
                    child: const Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 100.0,
                        semanticLabel: 'Play',
                      ),
                    ),
                  ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (!playing.value) {
              playing.value = true;
              controller.play();
            } else {
              playing.value = false;
              controller.pause();
            }
            playing.refresh();
          },
        ),
        Positioned(
            bottom: 10,
            left: 5,
            child: InkWell(
              child: Obx(
                () => Tooltip(
                  message: noMute.value ? "Mute" : "UnMute",
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Obx(() => noMute.value
                        ? const Icon(Icons.volume_up)
                        : const Icon(Icons.volume_off)),
                  ),
                ),
              ),
              onTap: () {
                if (noMute.value) {
                  noMute.value = false;
                  controller.setVolume(0);
                } else {
                  noMute.value = true;
                  controller.setVolume(1.0);
                }
                noMute.refresh();
              },
            )),
        // Align(
        //   alignment: Alignment.bottomLeft,
        //   child: PopupMenuButton<Duration>(
        //     initialValue: controller.value.captionOffset,
        //     tooltip: 'Caption Offset',
        //     onSelected: (Duration delay) {
        //       controller.setCaptionOffset(delay);
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return <PopupMenuItem<Duration>>[
        //         for (final Duration offsetDuration in _exampleCaptionOffsets)
        //           PopupMenuItem<Duration>(
        //             value: offsetDuration,
        //             child: Text('${offsetDuration.inMilliseconds}ms'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
        //     ),
        //   ),
        // ),
        Align(
          alignment: Alignment.bottomRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
              speedVal.value = speed;
              speedVal.refresh();
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Text('${speedVal.value}x'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
