import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/views/setting_view/setting_vm.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SettingVM(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 58, 57, 57),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text('Setting', style: TextStyle(color: Colors.white)),

            // IconButton(
            //   icon: const Icon(
            //     Icons.logout,
            //     color: Colors.white,
            //   ),
            //   onPressed: () async {

            //   },
            // ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // do you wish to logout
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Text(
                        'Do you wish to logout?',
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                      ),
                      onPressed: () async {
                        await GoogleSignIn().signOut();
                        await FirebaseAuth.instance.signOut();

                        final prefs = await SharedPreferences.getInstance();
                        prefs.remove('googleUserId');
                        prefs.setBool("isloggedIn", false);
                        NavigationService().clearStackAndShow(Routes.loginView);
                      },
                      child: Text(
                        'Logout',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Text(
                    'Do you wish to Delete your account?',
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                    ),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final idToken = prefs.getString('idToken');
                      final accessToken = prefs.getString('accessToken');
                      log("idToken=$idToken&accessToken=$accessToken");
                      // log('http://localhost:51100/delete-user?idToken=$idToken&accessToken=$accessToken');
                      await GoogleSignIn().signOut();
                      await FirebaseAuth.instance.signOut();

                      prefs.remove('googleUserId');
                      prefs.setBool("isloggedIn", false);
                      NavigationService().clearStackAndShow(Routes.loginView);
                      model.launchURL(
                          "https://atl.veloxis.co?idToken=$idToken&accessToken=$accessToken");
                      // NavigationService().navigateTo(Routes.deleteUserView);
                      // final prefs = await SharedPreferences.getInstance();

                      // final idToken = await prefs.getString('idToken');
                      // final accessToken = await prefs.getString('accessToken');
                      // log('?idToken=$idToken&accessToken=$accessToken');
                    },
                    child: Text(
                      'Delete Account',
                      style: GoogleFonts.poppins(
                          fontSize: 18.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
