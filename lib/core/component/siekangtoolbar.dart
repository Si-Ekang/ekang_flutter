import 'dart:developer';

import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:flutter/foundation.dart';

const toolbarKey = GlobalObjectKey<_SiEkangToolbarState>(0);

class SiEkangToolbar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;

  // Constructor
  const SiEkangToolbar({required this.title}) : super(key: toolbarKey);

  const SiEkangToolbar.withKey({required Key key, required this.title})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(128.0);

  @override
  State<SiEkangToolbar> createState() => _SiEkangToolbarState();
}

class _SiEkangToolbarState extends State<SiEkangToolbar> {
  String? currentPageName;

  bool isLibrary = false;

  void updateRoute(String currentPageName, bool isLibrary) {
    if (kDebugMode) {
      log('updateRoute() | name : $currentPageName, is library : $isLibrary');
    }
    currentPageName = currentPageName;
    this.isLibrary = isLibrary;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: widget.preferredSize.height,
      /*title: const Text(
        Constants.appName,
        style: TextStyle(color: Colors.black),
      ),*/
      backgroundColor: SiEkangColors.primaryDark,
      /*leading: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () => Navigator.pop(context),
        color: Colors.black,
      ),*/
      flexibleSpace: Container(
        color: SiEkangColors.primaryDark,
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Image(
                image: AssetImage(Assets.imagesSiEkangLogo),
                width: 96,
                height: 96,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  widget.title!,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
