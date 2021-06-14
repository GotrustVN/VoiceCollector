part of 'recording_screen.dart';

extension RecordingExtensionChildren on _RecordingScreenState {
  void _showGenderBottomSheet() {
    showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(
            bottom: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset(
                  ImageConstants.maleIcon,
                  height: 48,
                  width: 48,
                ),
                title: Text('Nam'),
                onTap: () {
                  Navigator.of(ctx).pop('Nam');
                },
              ),
              ListTile(
                leading: Image.asset(
                  ImageConstants.femaleIcon,
                  height: 48,
                  width: 48,
                ),
                title: Text('Nữ'),
                onTap: () {
                  Navigator.of(ctx).pop('Nữ');
                },
              ),
            ],
          ),
        );
      },
    ).then((value) {
      if (value?.isNotEmpty ?? false) {
        genderCtrl.text = value!;
      }
    });
  }

  Widget floatingActionButton() {
    return FloatingActionButton(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.orange,
        ),
        child: Center(
          child: ValueListenableBuilder<RecordStatus>(
            valueListenable: recordingStatus,
            builder: (BuildContext context, RecordStatus value, Widget? child) {
              if (value == RecordStatus.Initial) {
                return Icon(
                  Icons.mic,
                  size: 36,
                );
              }
              if (value == RecordStatus.Recording) {
                return Icon(
                  Icons.stop,
                  size: 36,
                );
              }
              return Icon(
                Icons.arrow_forward,
                size: 36,
              );
            },
          ),
        ),
      ),
      onPressed: () async {
        if (recordingStatus.value == RecordStatus.Initial) {
          recordingStatus.value = RecordStatus.Recording;
          await record();
        } else if (recordingStatus.value == RecordStatus.Recording) {
          recordingStatus.value = RecordStatus.Done;
          await stopRecorder();
        } else if (recordingStatus.value == RecordStatus.Done) {
          recordingStatus.value = RecordStatus.Initial;
          Navigator.of(context)
              .push(ReviewInformationScreen.route(getInformationArgument()));
        }
      },
    );
  }
}
