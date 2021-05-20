import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/core/ui.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/partials/project/fond_card.dart';
import 'package:meyirim/partials/project/status.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

// ignore: must_be_immutable
class ProjectScreen extends StatelessWidget {
  YoutubePlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    final project = Get.arguments['project'];
    if (project == null) Get.back();
    SwiperController _swiperController = SwiperController();

    if (project != null && project.videoUrl != null) {
      var videoId = YoutubePlayerController.convertUrlToId(project.videoUrl);
      _videoPlayerController = YoutubePlayerController(
        initialVideoId: videoId,
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('Проект'.tr, style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FondCard(
                  fond: project.fond,
                  padding: EdgeInsets.all(10),
                  actions: [
                    IconButton(
                      onPressed: () {
                        shareProject(project);
                      },
                      icon: Icon(Icons.share),
                      color: UIColor.blue,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: new Swiper(
                      loop: false,
                      controller: _swiperController,
                      itemBuilder: (BuildContext context, int index) {
                        if (project.photos.asMap().containsKey(index)) {
                          return InkWell(
                            onTap: () => {
                              //@Todo Превью картинок
                              // Navigator.pushNamed(
                              //   context,
                              //   PreviewImage.routeName,
                              //   arguments: PreviewImageArguments(
                              //       photos: project.photos,
                              //       videoUrl: project.videoUrl),
                              // )
                            },
                            child: CachedNetworkImage(
                              imageUrl: project.getPhoto(index),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter),
                                ),
                              ),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          );
                        } else {
                          return Container(
                              child: YoutubePlayerIFrame(
                            controller: _videoPlayerController,
                            aspectRatio: 16 / 9,
                          ));
                        }
                      },
                      onIndexChanged: (int index) {
                        if (!project.photos.asMap().containsKey(index)) {
                          _videoPlayerController.play();
                        } else {
                          _videoPlayerController?.pause();
                        }
                      },
                      itemCount: project.videoUrl != null
                          ? project.photos.length + 1
                          : project.photos.length,
                      pagination: new SwiperPagination(),
                    ),
                  ),
                ),
                ProjectStatus(
                  project: project,
                  isItem: true,
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(project.title,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child:
                      Text(project.description, style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(color: UIColor.green),
        child: (!project.isFinished)
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: UIColor.green, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () => showPayBottomSheet(context, project),
                child: Text(
                  'Помочь'.tr.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, letterSpacing: 3),
                ),
              )
            : Center(
                child: Wrap(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Проект завершен'.tr,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
