import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/model/music_data.dart';

class CommonMusicListItem extends StatelessWidget {
  final MusicData _data;
  final VoidCallback onTap;

  CommonMusicListItem(this._data, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Screens.width,
        height: suSetHeight(80.0),
        padding: EdgeInsets.only(left: suSetWidth(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _data.index == null
                ? Container()
                : Container(
                    alignment: Alignment.center,
                    width: suSetWidth(60),
                    height: suSetHeight(60),
                    child: Text(
                      _data.index.toString(),
                      style: Theme.of(context).textTheme.caption.copyWith(fontSize: 16),
                    ),
                  ),
            _data.picUrl == null
                ? Container()
                : ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(suSetWidth(6.0))),
                    child: ExtendedImage.network(
                      '${_data.picUrl}?param=200y200',
                      width: suSetWidth(60),
                      height: suSetHeight(60),
                      fit: BoxFit.fill,
                    ),
                  ),
            SizedBox(width: suSetWidth(20.0)),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _data.songName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle,
                  ),
//                  VEmptyView(10),
                  Text(
                    _data.artists,
                    style: Theme.of(context).textTheme.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: _data.mvId == 0
                  ? IconButton(
                      icon: Container(),
                      onPressed: null,
                      color: Colors.transparent,
                    )
                  : IconButton(
                      icon: Icon(Icons.play_circle_outline),
                      onPressed: () {},
                      color: Colors.grey,
                    ),
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
