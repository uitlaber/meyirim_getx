import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/core/ui.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/models/project.dart';

class ProjectStatus extends StatelessWidget {
  final Project project;
  final bool isItem;

  const ProjectStatus({Key key, this.project, this.isItem = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15.0, top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (project.requiredAmount > 0)
                Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('нужно'.tr,
                            style: TextStyle(
                                color: HexColor('#B2B3B2'), fontSize: 14)),
                        Text(formatCur(project.requiredAmount),
                            style: TextStyle(
                                color: HexColor('#FF5959'),
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      ],
                    )
                  ],
                ),
              Wrap(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('собрано'.tr,
                          style: TextStyle(
                              color: HexColor('#B2B3B2'), fontSize: 14)),
                      Text(formatCur(project.collectedAmount),
                          style: TextStyle(
                              color: HexColor('#00D7FF'),
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ],
                  )
                ],
              ),
              if (project.isFinished || isItem)
                Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('участвовали'.tr,
                            style: TextStyle(
                                color: HexColor('#B2B3B2'), fontSize: 14)),
                        Wrap(
                          children: [
                            Text(formatNum(project.donationsCount),
                                style: TextStyle(
                                    color: UIColor.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(width: 10),
                            Icon(Icons.people, color: UIColor.green)
                          ],
                        ),
                      ],
                    )
                  ],
                )
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: UIColor.green,
                      onPrimary: Colors.white,
                      shadowColor: Colors.white,
                      elevation: 0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      )),
                  onPressed: () => showPayBottomSheet(context, project),
                  child: Text(
                    'помочь'.tr,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
