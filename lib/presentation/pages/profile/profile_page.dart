import 'package:bookify/presentation/bloc/profile/profile_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child:(profileProvider.loading)? const CupertinoActivityIndicator(
            radius: 10,
          ):Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 80,
                backgroundImage:CachedNetworkImageProvider(
                  profileProvider.user!.profileImage!,
                ) ,
              ),
              const SizedBox(height: 20),
              Text(
                profileProvider.user!.userName!,
                style: GoogleFonts.abel(
                    fontSize:35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )
              ),
              const SizedBox(height: 20),
              Text(
                profileProvider.user!.email!,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Phone: 01234567890',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        )
      ),
    );
  }
}
