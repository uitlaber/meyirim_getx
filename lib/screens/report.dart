import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/partials/project/fond_card.dart';
import 'package:meyirim/partials/project/status.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

// ignore: must_be_immutable
class ReportScreen extends StatelessWidget {
  YoutubePlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    final report = Get.arguments['report'];
    if (report == null) Get.back();
    SwiperController _swiperController = SwiperController();

    if (report.getTranslated('video_url') != null) {
      var videoId = YoutubePlayerController.convertUrlToId(
          report.getTranslated('video_url'));
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
        title: Text('Отчет', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FondCard(
                  fond: report.fond,
                  padding: EdgeInsets.all(10),
                  actions: [
                    IconButton(
                        onPressed: () {
                          shareReport(report);
                        },
                        icon: Icon(Icons.share))
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
                        if (report.photos.asMap().containsKey(index)) {
                          return InkWell(
                            onTap: () => {
                              //@Todo Превью медиа отчетов
                              // Navigator.pushNamed(
                              //   context,
                              //   PreviewImage.routeName,
                              //   arguments: PreviewImageArguments(
                              //       photos: report.photos,
                              //       videoUrl: report.videoUrl),
                              // )
                            },
                            child: CachedNetworkImage(
                              imageUrl: report.getPhoto(index),
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
                        if (!report.photos.asMap().containsKey(index)) {
                          _videoPlayerController.play();
                        } else {
                          _videoPlayerController?.pause();
                        }
                      },
                      itemCount: report.getTranslated('video_url') != null
                          ? report.photos.length + 1
                          : report.photos.length,
                      pagination: new SwiperPagination(),
                    ),
                  ),
                ),
                ProjectStatus(
                  project: report.project,
                  isItem: true,
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(report.getTranslated('title'),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(report.getTranslated('description'),
                      style: TextStyle(fontSize: 15)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
