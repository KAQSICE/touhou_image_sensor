import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_pickers/image_pickers.dart';

class MobilePage extends StatefulWidget {
  @override
  State createState() {
    return MobileState();
  }
}

class MobileState extends State {
  Dio dio = Dio();

  builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      Response response = snapshot.data;
      if (snapshot.hasError) {
        return Text(snapshot.error.toString());
      }
      return ListView(
        children: <Widget>[
          Image.network(
            response.redirects[0].location.toString(),
            fit: BoxFit.fitWidth,
          ),
          RaisedButton(
            child: ListTile(
              leading: Icon(Icons.search),
              title: Text('查看大图'),
            ),
            onPressed: () {
              ImagePickers.previewImage(
                  response.redirects[0].location.toString());
            },
          ),
          RaisedButton(
            child: ListTile(
              leading: Icon(Icons.link),
              title: Text('复制链接'),
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(
                  text: response.redirects[0].location.toString()));
              FlutterToast.showToast(
                msg: '已复制到剪贴板',
                gravity: ToastGravity.BOTTOM,
              );
            },
          ),
          RaisedButton(
            child: ListTile(
              leading: Icon(Icons.save),
              title: Text('保存到相册'),
            ),
            onPressed: () {
              ImagePickers.saveImageToGallery(
                  response.redirects[0].location.toString());
              FlutterToast.showToast(
                msg: '已保存到相册',
                gravity: ToastGravity.BOTTOM,
              );
            },
          ),
          RaisedButton(
            child: ListTile(
              leading: Icon(Icons.autorenew),
              title: Text('换一换'),
            ),
            onPressed: () {
              setState(() {
                builder(context, snapshot);
              });
            },
          ),
        ],
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 200,
            child: FutureBuilder(
                future: dio.get(
                    'https://img.paulzzh.tech/touhou/random?size=wap&site=all'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return builder(context, snapshot);
                }),
          ),
        ),
      ],
    );
  }
}
