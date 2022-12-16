import 'dart:developer';

import 'package:ekang_flutter/core/theme/siekangcolors.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:ekang_flutter/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef PageChangedCallback = Function(
    RouteSettings routeSettings, bool isLibrary);

final key = GlobalKey<_SiEkangToolbarState>();

class SiEkangToolbar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final PageChangedCallback onPageChanged;

  // Constructor
  SiEkangToolbar({required this.onPageChanged})
      : preferredSize = const Size.fromHeight(128.0),
        super(key: key) {
    log('route : $onPageChanged');
  }

  @override
  State<SiEkangToolbar> createState() =>  _SiEkangToolbarState();
}

class _SiEkangToolbarState extends State<SiEkangToolbar> {
  final TextEditingController textController = TextEditingController();

  // Focus nodes are necessary
  final textFieldFocusNode = FocusNode();

  String? currentPageName;

  final double toolbarHeight = 128.0;
  bool isLibrary = false;
  final String searchField = 'Recherche impossible';

  void updateRoute(String currentPageName, bool isLibrary) {
    log('updateRoute() | name : $currentPageName, is library : $isLibrary');
    currentPageName = currentPageName;
    this.isLibrary = isLibrary;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
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
                child: TextFormField(
                  autocorrect: false,
                  controller: textController,
                  style: const TextStyle(color: Colors.white),
                  // Set Focus Node
                  focusNode: textFieldFocusNode,
                  decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      // Hint color and style
                      labelText: 'Rechercher...',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintMaxLines: 1,
                      isDense: true,
                      suffixIconConstraints: const BoxConstraints(
                        minWidth: 2,
                        minHeight: 2,
                      ),
                      suffixIcon: InkWell(
                          child: const Icon(Icons.clear,
                              size: 24, color: Colors.white),
                          onTap: () {
                            log('clear icon pressed');

                            // Unfocus all focus nodes
                            textFieldFocusNode.unfocus();

                            // Disable text field's focus node request
                            textFieldFocusNode.canRequestFocus = false;

                            // Do your stuff
                            textController.clear();

                            //Enable the text field's focus node request after some delay
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              textFieldFocusNode.canRequestFocus = true;
                            });
                          }),
                      suffixIconColor: Colors.white
                      // Clear button icon
                      ),
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
    textController.dispose();
    super.dispose();
  }
}