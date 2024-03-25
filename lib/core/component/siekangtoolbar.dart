import 'dart:developer';

import 'package:ekang_flutter/core/theme/siekangcolors.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

typedef PageChangedCallback = Function(
    RouteSettings routeSettings, bool isLibrary);
typedef TextChangedCallback = Function(String inputText);

const toolbarKey = GlobalObjectKey<_SiEkangToolbarState>(0);

class SiEkangToolbar extends StatefulWidget {
  final Size preferredSize = const Size.fromHeight(128.0);

  final PageChangedCallback onPageChanged;
  final TextChangedCallback onTextChanged;

  // Constructor
  SiEkangToolbar({required this.onPageChanged, required this.onTextChanged})
      : super(key: toolbarKey) {
    if (kDebugMode) log('route : $onPageChanged');
    if (kDebugMode) log('onTextChanged : $onTextChanged');
  }

  @override
  State<SiEkangToolbar> createState() => _SiEkangToolbarState(onTextChanged);
}

class _SiEkangToolbarState extends State<SiEkangToolbar> {
  final TextEditingController textController = TextEditingController();
  final TextChangedCallback onTextChanged;

  // Focus nodes are necessary
  final textFieldFocusNode = FocusNode();

  String? currentPageName;

  final double toolbarHeight = 128.0;
  bool isLibrary = false;
  final String searchField = 'Recherche impossible';

  _SiEkangToolbarState(TextChangedCallback this.onTextChanged);

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
                              if (kDebugMode) log('clear icon pressed');

                              // Unfocus all focus nodes
                              textFieldFocusNode.unfocus();

                              // Disable text field's focus node request
                              textFieldFocusNode.canRequestFocus = false;

                              // Do your stuff
                              textController.clear();
                              onTextChanged('');

                              //Enable the text field's focus node request after some delay
                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                textFieldFocusNode.canRequestFocus = true;
                              });
                            }),
                        suffixIconColor: Colors.white
                        // Clear button icon
                        ),
                    onChanged: (String newText) {
                      if (kDebugMode) log('onChanged | newText : $newText');

                      SemanticsService.announce(
                          '\$$newText', Directionality.of(context));

                      onTextChanged(newText);
                    }),
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
