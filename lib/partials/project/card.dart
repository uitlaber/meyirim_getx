import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/partials/project/fond_card.dart';
import 'package:meyirim/partials/project/status.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({Key key, @required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed('/project', arguments: {'project': project}),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white),
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  /**
                   * Фото
                   */
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Hero(
                      tag: project.id,
                      child: CachedNetworkImage(
                        imageUrl: project.getPhoto(0),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter),
                          ),
                        ),
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                      child: Container(
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                        end: const Alignment(0.0, 0),
                        begin: const Alignment(0.0, 0.5),
                        colors: <Color>[
                          const Color(0x8A000000),
                          Colors.black12.withOpacity(0.0)
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                    top: 5.0,
                                    bottom: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.black.withOpacity(0.5)),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.people_alt_outlined,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${project.donationsCount}',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                    top: 5.0,
                                    bottom: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.black.withOpacity(0.5)),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.photo_camera,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${project.photos.length}',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                          Text(project.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
              ProjectStatus(
                project: project,
              ),
              Divider(height: 0),
              FondCard(
                fond: project.fond,
                padding: EdgeInsets.all(10),
                actions: [
                  IconButton(
                      onPressed: () {
                        shareProject(project);
                      },
                      icon: Icon(
                        Icons.share,
                        color: HexColor('#8B8B8B'),
                      ))
                ],
              ),
            ],
          )),
    );
  }
}
