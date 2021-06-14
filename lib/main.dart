import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice4health/recording/recording_screen.dart';

import 'common/app_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await handlePermission();
    });
  }

  Future<void> handlePermission() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      handlePermission();
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lisence'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                    children: [
                      TextSpan(text: 'Điều khoản sử dụng: \n'),
                      TextSpan(
                          text:
                              '- Khi sử dụng ứng dụng này bạn đồng ý cho phép gửi dữ liệu về cho chương trình:\n'),
                      TextSpan(
                          text: '* Các thông tin bạn nhập trên màn hình.\n'),
                      TextSpan(text: '* Dữ liệu hình ảnh bạn ghi âm.\n'),
                      TextSpan(text: '* Mã điện thoại của bạn.\n'),
                      TextSpan(
                          text:
                              '* Phần mễm sẽ không thu thập dữ liệu nào khác ngoài những điều nêu trên.\n'),
                      TextSpan(
                          text:
                              '- Các dữ liệu chỉ sử dụng cho mục đích nghiên cứu khoa học.\n')
                    ],
                  ),
                ),
              ),
              AppButton(
                onButtonPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      RecordingScreen.route(), (route) => false);
                },
                text: 'Đồng ý',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
