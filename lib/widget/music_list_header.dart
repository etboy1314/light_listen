import 'package:flutter/material.dart';
import 'package:light_listen/constans/screens.dart';

class MusicListHeader extends StatelessWidget implements PreferredSizeWidget {
  MusicListHeader({this.musicNum, this.collectNum, this.onPressed1, this.onPressed2});

  final musicNum;
  final num collectNum;
  final onPressed1;
  final onPressed2;

  @override
  Widget build(BuildContext context) {
    String countStr;
    if (collectNum >= 100000) {
      countStr = (collectNum / 10000).toStringAsFixed(1);
      countStr = "$countStr万";
    } else
      countStr = collectNum.toString();
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(suSetWidth(30.0))),
      child: Container(
        color: Colors.white,
        child: InkWell(
//          onTap: onTap,
          child: SizedBox.fromSize(
            size: preferredSize,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ActionChip(
                    label: Text('播放全部（共${musicNum}首）', style: Theme.of(context).textTheme.subtitle),
                    backgroundColor: Colors.white,
                    avatar: Image.asset(
                      'images/controller/play.png',
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                  Spacer(),
                  ActionChip(
                    labelPadding: EdgeInsets.zero,
                    avatar: Icon(Icons.add, color: Colors.white),
                    label: Text(
                      "收藏（${countStr}）",
                      style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                    pressElevation: 0.0,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
