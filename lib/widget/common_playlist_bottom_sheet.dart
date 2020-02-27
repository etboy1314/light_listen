import 'package:flutter/material.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/light_listen_route_helper.dart';
import 'package:light_listen/provider/music_player_manager.dart';
import 'package:provider/provider.dart';

class CommonPlayListBottomSheet extends StatefulWidget {
  @override
  _CommonPlayListBottomSheetState createState() => _CommonPlayListBottomSheetState();

  CommonPlayListBottomSheet();
}

class _CommonPlayListBottomSheetState extends State<CommonPlayListBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MusicPlayerManager>(builder: (BuildContext context, MusicPlayerManager player, Widget child) {
      return Container(
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(suSetWidth(20.0))),
          child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ActionChip(
                          label: Text('列表循环（${player.musics.length}）', style: Theme.of(context).textTheme.subtitle),
                          backgroundColor: Colors.white,
                          avatar: Image.asset(
                            'images/player/play_type_1.png',
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.clear_all),
                          onPressed: () {
                            player.removeAllMusics();
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: player.musics.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            player.musics[index].name,
                            style: TextStyle(color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                          subtitle: Text(
                            player.musics[index].artists,
                            style: TextStyle(color: Colors.black, fontSize: 12.0),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                player.removeMusicAt(index);
                              }),
                          onTap: () {
                            player.curIndex = index;
                            player.play();
                          },
                        );
                      },
                    ),
                  )
                ],
              )),
        ),
      );
    });
  }
}
