import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'owl_button.dart';
import 'owl_spacer.dart';
import 'owl_textbutton.dart';
import 'owl_textfield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = true;
  String emailError = '';
  String passwordError = '';

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> getSmsCodeFromUser(BuildContext context) async {
    String? smsCode;

    // Update the UI - wait for the user to enter the SMS code
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('SMS code:'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Sign in'),
            ),
            OutlinedButton(
              onPressed: () {
                smsCode = null;
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
          content: Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onChanged: (value) {
                smsCode = value;
              },
              textAlign: TextAlign.center,
              autofocus: true,
            ),
          ),
        );
      },
    );

    return smsCode;
  }

  authLogin({required String email, required String password}) async {
    try {
      emailError = passwordError = '';
      setState(() {});
      dynamic newUser = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = newUser.user;
      // MultiFactorSession multiFactorSession =
      //     await user.multiFactor.getSession();
    } on FirebaseAuthMultiFactorException catch (e) {
      // TODO: exception FirebaseAuthMultiFactorException is not caught

      final firstHint = e.resolver.hints.first;
      if (firstHint is! PhoneMultiFactorInfo) {
        return;
      }
      await FirebaseAuth.instance.verifyPhoneNumber(
        multiFactorSession: e.resolver.session,
        multiFactorInfo: firstHint,
        verificationCompleted: (_) {},
        verificationFailed: (_) {},
        codeSent: (String verificationId, int? resendToken) async {
          // See `firebase_auth` example app for a method of retrieving user's sms code:
          // https://github.com/firebase/flutterfire/blob/master/packages/firebase_auth/firebase_auth/example/lib/auth.dart#L591
          final smsCode = await getSmsCodeFromUser(context);

          if (smsCode != null) {
            // Create a PhoneAuthCredential with the code
            final credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: smsCode,
            );

            try {
              await e.resolver.resolveSignIn(
                PhoneMultiFactorGenerator.getAssertion(
                  credential,
                ),
              );
            } on FirebaseAuthException catch (e) {
              print(e.message);
            }
          }
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } on Exception catch (e) {
      // TODO: exception print here shows FirebaseAuthMultiFactorExceptionPlatform
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(
            "images/owl_logo.png",
            height: size.height * 0.1,
            fit: BoxFit.cover,
          ),
          const OwlSpacer(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OwlTextFormField(
                title: 'Email',
                controller: emailController,
                error: emailError,
                fieldIcon: const Icon(Icons.person),
                textColor: Colors.black87,
                borderColor: Colors.black38,
              ),
              const OwlSpacer(height: 20),
              OwlTextFormField(
                title: 'Password',
                controller: passwordController,
                error: passwordError,
                fieldIcon: const Icon(Icons.lock_open),
                suffixIcon: IconButton(
                  icon: Icon(passwordVisibility
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    passwordVisibility = !passwordVisibility;
                    setState(() {
                      // passwordController.text =
                      //     passwordController.text;
                    });
                  },
                ),
                textColor: Colors.black87,
                borderColor: Colors.black38,
                maxLines: 1,
                obscure: passwordVisibility,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: OwlTextButton(
                    onPressed: (() {
                      setState(() {});
                    }),
                    title: "Forgot Password?",
                    fontSize: 12),
              ),
              const OwlSpacer(height: 20),
              OwlButton(
                onPressed: () {
                  // isLoggedIn = true;
                  // context.beamToNamed(dashboardRoute);
                  authLogin(
                      email: emailController.text,
                      password: passwordController.text);
                  setState(() {});
                },
                elevation: 2,
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF1971C2),
                fixedSize: const Size(150, 60),
                child: const Text("Login"),
              )
            ],
          ),
        ]));
  }
}
