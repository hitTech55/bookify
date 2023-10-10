
import 'package:bookify/presentation/bloc/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final RoundedLoadingButtonController _googleLoadingButtonController = RoundedLoadingButtonController();
  @override
  void dispose() {
    _googleLoadingButtonController.stop();
    super.dispose();
  }
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                const Icon(
                  Icons.bookmark_add_sharp,
                  size: 100,
                  color: Colors.red,
                ),
                const SizedBox(height: 75),
                Text(
                    "Hello Again!",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 52,
                    )
                ),
                Text(
                    'Welcome back, you\'ve been missed',
                    style: GoogleFonts.sansitaSwashed(
                        fontSize: 18
                    )
                ),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (context) => AuthProvider(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Consumer<AuthProvider>(
                      builder: (context,auth,child) {
                        if(auth.hasError) {
                          _googleLoadingButtonController.stop();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundedLoadingButton(
                                controller: _googleLoadingButtonController,
                                successColor: Colors.green,
                                onPressed: (){
                                  auth.signInWithGoogle(context);
                                },
                                width: MediaQuery.of(context).size.width * 0.80,
                                elevation: 0,
                                borderRadius: 25,
                                color: Colors.red,
                                child: Wrap(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.google,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width:20),
                                    Text(
                                      "Login with Google",
                                      style: GoogleFonts.almarai(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )
                                    )
                                  ],
                                )
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
