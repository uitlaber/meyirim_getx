import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/models/fond.dart';
import 'package:meyirim/models/region.dart';

class FondCard extends StatelessWidget {
  final Fond fond;
  final EdgeInsetsGeometry padding;
  final List<Widget> actions;

  const FondCard({Key key, this.fond, this.padding, this.actions})
      : super(key: key);

  // @override
  // void initState() {
  //   getRegion();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: padding ?? EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: CachedNetworkImage(
                        imageUrl: fond.getAvatar,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fond.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        Text(fond.region.name ?? 'Не выбрано',
                            style: TextStyle(
                                color: HexColor('#999999'), fontSize: 11)),
                      ],
                    )
                  ],
                ),
              ),
              ...actions ?? []
              // IconButton(
              //     icon: Icon(
              //       Icons.chevron_right,
              //       size: 30,
              //       color: HexColor('#999999'),
              //     ),
              //     onPressed: () {})
            ],
          ),
        ),
        Divider(height: 0)
      ],
    );
  }
}
