import 'package:flutter/material.dart';
import 'package:light_listen/widget/platform_progress_indicator.dart';

class MyFutureBuilder<T> extends StatefulWidget {
  final ValueWidgetBuilder<T> builder;
  final Widget loadingWidget;
  final Widget errorWidget;
  final Function request;

  MyFutureBuilder({this.request, this.builder, Widget loadingWidget, this.errorWidget})
      : loadingWidget = loadingWidget ?? Center(child: PlatformProgressIndicator());

  @override
  _MyFutureBuilderState<T> createState() => _MyFutureBuilderState<T>();
}

class _MyFutureBuilderState<T> extends State<MyFutureBuilder<T>> {
  Future<T> futureRequest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((call) {
      setState(() {
        futureRequest = widget.request();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return futureRequest != null
        ? FutureBuilder(
            future: futureRequest,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return widget.loadingWidget;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return widget.builder(context, snapshot.data, null);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: ActionChip(
                        label: Text("load error!"),
                        onPressed: () {
                          setState(() {
                            futureRequest = widget.request();
                          });
                        },
                      ),
                    );
                  }
              }
              return Container();
            },
          )
        : widget.loadingWidget;
  }
}
