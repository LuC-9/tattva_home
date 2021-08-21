import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tattva_home/screens/home_screen.dart';
import 'signup.dart';
import 'homepage.dart';

 void main() async => Login();


class Login extends StatelessWidget {
  Future<bool> hasUserLogged() async {
    ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
    if (currentUser == null) {
      return false;
    }
    //Validates that the user's session token is valid
    final ParseResponse parseResponse =
    await ParseUser.getCurrentUserFromServer(
        currentUser.get<String>('sessionToken'));

    if (!parseResponse.success) {
      //Invalid session. Logout
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tattva',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<bool>(
          future: hasUserLogged(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Scaffold(
                  body: Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  ),
                );
                break;
              default:
                if (snapshot.data==true && snapshot.data != null) {
                  return HomeScreen();
                } else {
                  return LoginPage();
                }
            }
          }),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  child: Image.asset(
                      'assets/images/logo.png'),
                ),
                Center(
                  child: const Text('Tattva Home',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: controllerUsername,
                  enabled: !isLoggedIn,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Username'),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controllerPassword,
                  enabled: !isLoggedIn,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Password'),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: isLoggedIn ? null : () => doUserLogin(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Sign Up'),
                    onPressed: () => navigateToSignUp(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Reset Password'),
                    onPressed: () => navigateToResetPassword(),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void doUserLogin() async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false,
      );
    } else {
      Message.showError(context: context, message: response.error.message);
    }
  }

  void navigateToUser() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false,
    );
  }

  void navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    );
  }

  void navigateToResetPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordPage()),
    );
  }
}



/*class UserPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    void doUserLogout() async {
      var response = await currentUser.logout();
      if (response.success) {
        Message.showSuccess(
            context: context,
            message: 'User was successfully logout!',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false,
              );
            });
      } else {
        Message.showError(context: context, message: response.error.message);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('User logged in - Current User'),
        ),
        body: FutureBuilder<ParseUser>(
            future: getUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  );
                  break;
                default:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text('Hello, ${snapshot.data!.username}')),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 50,
                          /*child: ElevatedButton(
                            child: const Text('Logout'),
                            onPressed: () => doUserLogout(),
                          ),*/
                        ),
                      ],
                    ),
                  );
              }
            }));
  }
}*/

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reset Password'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: controllerEmail,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'E-mail'),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 50,
                child: ElevatedButton(
                  child: const Text('Reset Password'),
                  onPressed: () => doUserResetPassword(),
                ),
              )
            ],
          ),
        ));
  }

  void doUserResetPassword() async {final ParseUser user = ParseUser(null, null, controllerEmail.text.trim());
  final ParseResponse parseResponse = await user.requestPasswordReset();
  if (parseResponse.success) {
    Message.showSuccess(
        context: context,
        message: 'Password reset instructions have been sent to email!',
        onPressed: () {
          Navigator.of(context).pop();
        });
  } else {
    Message.showError(context: context, message: parseResponse.error.message);
  }







  }
}

class Message {
  static void showSuccess(
      {@required BuildContext context,
        @required String message,
        @required VoidCallback onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (onPressed != null) {
                  onPressed();
                }
              },
            ),
          ],
        );
      },
    );
  }

  static void showError(
      {@required BuildContext context,
        @required String message,
        VoidCallback onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(message),
          actions: <Widget>[
            new ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (onPressed != null) {
                  onPressed();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
