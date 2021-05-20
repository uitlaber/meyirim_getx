import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/models/indigent.dart';

class IndigentCard extends StatelessWidget {
  final Indigent indigent;
  final bool isVerifed;

  const IndigentCard(
      {Key key, @required this.indigent, @required this.isVerifed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          {}, //Get.toNamed('/project', arguments: {'project': project}),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                CachedNetworkImage(
                  color: Colors.red,
                  width: 45,
                  height: 45,
                  imageUrl: indigent.getPhoto(0),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
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
                SizedBox(height: 10),
                Text(
                  timeAgo(indigent.dateCreated),
                  style: TextStyle(
                    fontSize: 10,
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      indigent.fullname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(indigent.note ?? '',
                        style: TextStyle(
                            color: HexColor('#3B3B3B'), fontSize: 12)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(indigent.address ?? '',
                        style: TextStyle(
                            color: HexColor('#3B3B3B'), fontSize: 10)),
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
