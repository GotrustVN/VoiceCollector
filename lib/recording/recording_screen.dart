import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:voice4health/common/text_field.dart';

import '../model/review_information_args.dart';
import '../resources/images_constants.dart';
import '../review_info/review_information_screen.dart';

part 'recording_children.dart';

class RecordingScreen extends StatefulWidget {
  RecordingScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) {
        return RecordingScreen();
      },
    );
  }

  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

enum RecordStatus { Initial, Recording, Done }

class _RecordingScreenState extends State<RecordingScreen> {
  final TextEditingController genderCtrl = TextEditingController(text: 'Nam');
  final TextEditingController ageCtrl = TextEditingController();
  final TextEditingController weightCtrl = TextEditingController();
  final TextEditingController healthStatusCtrl = TextEditingController();
  final TextEditingController fullNameCtrl = TextEditingController();

  //
  final ValueNotifier<RecordStatus> recordingStatus =
      ValueNotifier<RecordStatus>(RecordStatus.Initial);

  String filePath = '';
  String fileName = '';
  @override
  void initState() {
    super.initState();
  }

  Future<void> record() async {
    await Record.start(
      path: await getPath(), // required
      encoder: AudioEncoder.AAC, // by default
      bitRate: 128000, // by default
    );
  }

  Future<void> stopRecorder() async {
    // Stop recording
    await Record.stop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('Trang kê khai thông tin')),
        body: InkWell(
          onTap: () {
            if (FocusScope.of(context).hasFocus) {
              FocusScope.of(context).unfocus();
            }
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Wrap(
                  runSpacing: 8,
                  children: [
                    CustomTextField(
                      controller: genderCtrl,
                      readOnly: true,
                      onTap: _showGenderBottomSheet,
                      hintText: 'Giới tính',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    CustomTextField(
                      controller: ageCtrl,
                      hintText: 'Tuổi',
                      textInputType: TextInputType.number,
                    ),
                    CustomTextField(
                      controller: weightCtrl,
                      hintText: 'Cân nặng',
                      textInputType: TextInputType.number,
                    ),
                    CustomTextField(
                      controller: healthStatusCtrl,
                      hintText: 'Tình trạng sức khoẻ',
                      maxlines: 5,
                    ),
                    CustomTextField(
                      controller: fullNameCtrl,
                      hintText: 'Họ và Tên (Không bắt buộc)',
                    ),
                  ],
                ),
                ValueListenableBuilder<RecordStatus>(
                  valueListenable: recordingStatus,
                  builder: (context, value, child) {
                    if (value == RecordStatus.Done) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        leading: Text('File:'),
                        title: Text(fileName),
                        trailing: IconButton(
                            icon: Icon((Icons.close)),
                            onPressed: () {
                              recordingStatus.value = RecordStatus.Initial;
                            }),
                      );
                    }
                    return ListTile();
                  },
                ),
                Expanded(
                  child: Center(child: Text('User Guide')),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: floatingActionButton(),
      ),
    );
  }

  ReviewInformationArgs getInformationArgument() => ReviewInformationArgs(
      gender: genderCtrl.text,
      age: ageCtrl.text,
      weight: weightCtrl.text,
      healthStatus: healthStatusCtrl.text,
      fullName: fullNameCtrl.text,
      recordFileName: fileName);

  Future<String> getPath() async {
    if (filePath.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.m4a';
      filePath = dir.path + '/' + fileName;
    }
    return filePath;
  }
}
