import 'package:flutter/material.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher_string.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final String _clientId = 'almacenes-flutter';
  static const String _issuer = 'https://localhost:5001';
  final List<String> _scopes = <String>['openid', 'profile', 'email', 'wsapi'];
  String logoutUrl = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Login"),
              onPressed: () async {
                var tokenInfo =
                    await authenticate(Uri.parse(_issuer), _clientId, _scopes);
                print(tokenInfo.accessToken);
              },
            ),
            ElevatedButton(
              child: Text("Logout"),
              onPressed: () async {
                logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<TokenResponse> authenticate(
      Uri uri, String clientId, List<String> scopes) async {
    // create the client
    var issuer = await Issuer.discover(uri);
    var client = Client(issuer, clientId);

    // create a function to open a browser with an url
    urlLauncher(String url) async {
      if (await canLaunchUrlString(url)) {
        await launch(url, forceWebView: true, enableJavaScript: true);
      } else {
        throw 'Could not launch $url';
      }
    }

    // create an authenticator
    var authenticator = Authenticator(
      client,
      scopes: scopes,
      urlLancher: urlLauncher,
      port: 3000,
    );

    // starts the authentication
    var c = await authenticator.authorize();
    // close the webview when finished
    closeInAppWebView();

    var res = await c.getTokenResponse();
    setState(() {
      logoutUrl = c.generateLogoutUrl().toString();
    });
    print(res.accessToken);
    return res;
  }

  Future<void> logout() async {
    if (await canLaunchUrlString(logoutUrl)) {
      await launch(logoutUrl, forceWebView: true);
    } else {
      throw 'Could not launch $logoutUrl';
    }
    await Future.delayed(const Duration(seconds: 2));
    closeInAppWebView();
  }
}
