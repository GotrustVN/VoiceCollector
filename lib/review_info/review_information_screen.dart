import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voice4health/common/app_button.dart';

import '../model/review_information_args.dart';

class ReviewInformationScreen extends StatefulWidget {
  ReviewInformationScreen({Key? key, required this.args}) : super(key: key);
  final ReviewInformationArgs args;

  static Route route(ReviewInformationArgs args) {
    return MaterialPageRoute(
      builder: (_) {
        return ReviewInformationScreen(
          args: args,
        );
      },
    );
  }

  @override
  _ReviewInformationScreenState createState() =>
      _ReviewInformationScreenState();
}

class _ReviewInformationScreenState extends State<ReviewInformationScreen> {
  late ReviewInformationArgs data;

  AudioPlayer audioPlayer = AudioPlayer();
  final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
    data = widget.args;
  }

  playLocal() async {
    isPlaying.value = true;
    final dirPath = await getPath();
    final filePath = '$dirPath/${data.recordFileName}';
    await audioPlayer.play(filePath, isLocal: true);
  }

  stop() async {
    isPlaying.value = false;
    await audioPlayer.stop();
  }

  Future<String> getPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Xác nhận thông tin')),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Wrap(
                  runSpacing: 8,
                  children: [
                    Text('Thông tin cá nhân:'),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding: EdgeInsets.all(8),
                      child: Wrap(
                        runSpacing: 4,
                        children: [
                          _rowData(label: 'Họ tên: ', value: data.fullName),
                          _rowData(label: 'Giới tính: ', value: data.gender),
                          _rowData(label: 'Tuổi: ', value: data.age),
                          _rowData(label: 'Cân nặng: ', value: data.weight),
                          _rowData(
                              label: 'Tình trạng sức khoẻ: ',
                              value: data.healthStatus),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text('Nghe lại ghi âm:'),
                        ValueListenableBuilder<bool>(
                          valueListenable: isPlaying,
                          builder: (context, value, child) {
                            if (value) {
                              return IconButton(
                                  icon: Icon(Icons.stop),
                                  onPressed: () {
                                    stop();
                                  });
                            }

                            return IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () {
                                  playLocal();
                                });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppButton(
                text: 'Gửi',
                onButtonPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowData({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 5,
          ),
        ),
      ],
    );
  }
}
