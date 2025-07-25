import 'dart:async';
import 'dart:convert' show json;

import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

// import 'src/sign_in_button.dart';

/// To run this example, replace this value with your client ID, and/or
/// update the relevant configuration files, as described in the README.
String? clientId = "AIzaSyAz3Jio5eh-J2BJCvBu1e3Sm7wMeJCR8EY";

/// To run this example, replace this value with your server client ID, and/or
/// update the relevant configuration files, as described in the README.
String? serverClientId = "473333502274-9e31kmcgh1jgo4h3drneid8trmuufnj2.apps.googleusercontent.com";

/// The scopes required by this application.
// #docregion Initialize
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);
// #enddocregion Initialize

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
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      if (kDebugMode) {
        Fimber.d('onCurrentUserChanged | listen');
      }

// #docregion CanAccessScopes
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      if (kDebugMode) {
        Fimber.d('onCurrentUserChanged | isAuthorized: $isAuthorized');
      }
      // However, on web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }
// #enddocregion CanAccessScopes

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    _googleSignIn.signInSilently();
  }

  // Calls the People API REST endpoint for the signed-in user to retrieve information.
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    if (kDebugMode) {
      Fimber.d(' _handleGetContact | ${user.email}');
    }

    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      if (kDebugMode) {
        Fimber.e(' _handleGetContact | statusCode | ${response.statusCode}');
      }
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);

    if (kDebugMode) {
      Fimber.e(' namedContact : $namedContact');
    }

    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    if (kDebugMode) {
      Fimber.d(' _pickFirstNamedContact | ${data['connections']}');
    }
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
        (dynamic name) =>
            (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  // This is the on-click handler for the Sign In button that is rendered by Flutter.
  //
  // On the web, the on-click handler of the Sign In button is owned by the JS
  // SDK, so this method can be considered mobile only.
  // #docregion SignIn
  Future<void> _handleSignIn() async {
    if (kDebugMode) {
      Fimber.d(' _handleSignIn()');
    }
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  // #enddocregion SignIn

  // Prompts the user to authorize `scopes`.
  //
  // This action is **required** in platforms that don't perform Authentication
  // and Authorization at the same time (like the web).
  //
  // On the web, this must be called from an user interaction (button click).
  // #docregion RequestScopes
  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
    // #enddocregion RequestScopes
    setState(() {
      _isAuthorized = isAuthorized;
    });
    // #docregion RequestScopes
    if (isAuthorized) {
      unawaited(_handleGetContact(_currentUser!));
    }
    // #enddocregion RequestScopes
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody()
      /*LayoutBuilder(
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
          ))*/
      ,
    );
  }

  Widget _buildBody() {
    if (kDebugMode) {
      Fimber.d(' _buildBody()');
    }

    final GoogleSignInAccount? user = _currentUser;

    if (null == user) {
      // The user is NOT Authenticated
      Fimber.e("_buildBody() | The user is NOT Authenticated");

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          // This method is used to separate mobile from web code with conditional exports.
          // See: src/sign_in_button.dart
          /*buildSignInButton(
            onPressed: _handleSignIn,
          )*/
          ElevatedButton(
              onPressed: _handleSignIn, child: const Text('SIGN IN')),
        ],
      );
    }

    // The user is Authenticated
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ListTile(
          leading: GoogleUserCircleAvatar(
            identity: user,
          ),
          title: Text(user.displayName ?? ''),
          subtitle: Text(user.email),
        ),
        const Text('Signed in successfully.'),
        if (_isAuthorized) ...<Widget>[
          // The user has Authorized all required scopes
          Text(_contactText),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => _handleGetContact(user),
          ),
        ],
        if (!_isAuthorized) ...<Widget>[
          // The user has NOT Authorized all required scopes.
          // (Mobile users may never see this button!)
          const Text('Additional permissions needed to read your contacts.'),
          ElevatedButton(
            onPressed: _handleAuthorizeScopes,
            child: const Text('REQUEST PERMISSIONS'),
          ),
        ],
        ElevatedButton(
          onPressed: _handleSignOut,
          child: const Text('SIGN OUT'),
        ),
      ],
    );
  }
}
