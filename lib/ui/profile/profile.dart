import 'package:ekang_flutter/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/theme/siekangcolors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

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
                              throw Exception("Test crashlytics exception");
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
