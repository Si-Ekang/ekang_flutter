
import 'package:ekang_flutter/core/theme/siekangcolors.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth >= 500
                          ? 500
                          : constraints.maxWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Content of row
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(16)),
                          backgroundColor: MaterialStateProperty.all(
                              SiEkangColors.primary),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: SiEkangColors.primary),
                                  borderRadius:
                                  BorderRadius.circular(16.0))),
                        ),
                        // Button content
                        child: const Row(
                          children: [
                            // Display Goggle Image
                            Image(
                              image: AssetImage(Assets.imagesGooglegColor),
                              width: 36,
                              height: 36,
                            ),
                            // Text
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              child: Text(
                                'Connectez-vous avec votre Compte Google',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        onPressed: () {

                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}