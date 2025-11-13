import 'package:ekang_flutter/core/utils/constants.dart';
import 'package:ekang_flutter/core/widgets/ads/app_open_ad_manager.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/notifications/data/model/whats_new_model.dart';
import 'package:ekang_flutter/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:ekang_flutter/features/notifications/presentation/bloc/notifications_state.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  void initState() {
    super.initState();

    context.read<NotificationsBloc>().add(NotificationsLoadImageEvent());
  }

  @override
  void didUpdateWidget(covariant NotificationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    AppOpenAdManager().showAdIfAvailable();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<NotificationsBloc, NotificationsState>(
      listener: (context, state) {
        if (kDebugMode) {
          Fimber.d(
              "build | BlocConsumer | state: ${state.runtimeType}, value : ${state.props.toString()}");
        }

        switch (state) {
          case NotificationsLoading _:
            {}
          case NotificationsSuccess _:
            {}
          case NotificationsLoadingImageSuccess _:
            {}
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: SiEkangToolbar(
            title: Constants.notificationsTitle,
            leadingIcon: null,
            actions: null,
          ),
          body: Center(
              child: Column(children: [
            null == context.read<NotificationsBloc>().imageData
                ? SiEkangLoader(30, 30)
                : SizedBox(
                    width: 72,
                    height: 72,
                    child: ClipOval(
                      child: Image.memory(
                        context.read<NotificationsBloc>().imageData,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
            ElevatedButton(
              child: const Text('Notification route'),
              onPressed: () {},
            ),
            switch (state) {
              NotificationsSuccess _ =>
                Expanded(child: _buildWhatsNewList(state.model)),
              _ => SizedBox(width: 0, height: 0),
            }
          ])),
        );
      },
    );
  }

  Widget _buildWhatsNewList(WhatsNewModel model) {
    Fimber.d("_buildWhatsNewList() | feature list : ${model.features.length}");

    return ListView.builder(
      shrinkWrap: true,
      itemCount: model.features.length,
      itemBuilder: (context, index) {
        var title = model.features[index].title;
        var message = model.features[index].message;
        var tags = model.features[index].tags;
        var timestamp = model.features[index].timestamp;

        return Material(
            child: Card(
          child: ListTile(
            title: Text(title),
            subtitle: Text(message),
            onTap: null,
            leading: SizedBox(
              width: 24,
              height: 24,
              child: ClipOval(
                child: Image.asset(
                  Assets.imagesSiEkangLogo,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
