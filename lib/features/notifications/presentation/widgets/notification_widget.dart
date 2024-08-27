import 'package:ekang_flutter/core/utils/constants.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<NotificationWidget> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(128.0),
          child: SiEkangToolbar(
            title: Constants.notificationsTitle,
            onTextChanged: null,
          )),
      body: Center(
        child: ElevatedButton(
          child: const Text('Notification route'),
          onPressed: () {},
        ),
      ),
    );
  }
}
