import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/models/donation.dart';
import 'package:meyirim/screens/project.dart';

class DonationCard extends StatelessWidget {
  final Donation donation;
  final bool isReferal;

  const DonationCard(
      {Key key, @required this.donation, @required this.isReferal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var project = donation.project;

    return InkWell(
      onTap: () => Get.dialog(new ProjectScreen(), arguments: {
        'project': project
      }), //Get.toNamed('/project', arguments: {'project': project}),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ], color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              color: Colors.red,
              width: 124,
              height: 94,
              imageUrl: project.getPhoto(0),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(19)),
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.error),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.getTranslated('title'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isReferal
                            ? HexColor('#F82E55')
                            : HexColor('#41BC73'),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(project.fond.title,
                        style: TextStyle(
                            color: HexColor('#3B3B3B'), fontSize: 12)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(formatCur(donation.amount).toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                      child: Text(formatDate(donation.paidAt),
                          style: TextStyle(
                              color: HexColor('#DBDBDB'), fontSize: 11)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
