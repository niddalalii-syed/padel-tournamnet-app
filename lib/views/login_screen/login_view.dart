import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:tournament_manager/service/google_sign_in.dart';
import 'package:tournament_manager/views/login_screen/login_vm.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
        onViewModelReady: (viewModel) => viewModel.checkUser(),
        viewModelBuilder: () => LoginVM(),
        builder: (context, vModel, child) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 187, 187, 187), // dark gray
                    Color(0xFF000000), // black
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150.w,
                        height: 150.h,
                        child: Image.asset(
                          'assets/AKL-LOGO.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        'Tournaments are associated to your Google Account to allow access from all your devices.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      30.verticalSpace,
                      Text(
                        'Please sign in with your Google account. Your account details are never used for any other purpose.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      40.verticalSpace,
                      ElevatedButton(
                        onPressed: () async {
                          final userCredential = await signInWithGoogle();
                          if (userCredential != null) {
                            final user = userCredential.user;
                            print("Signed in as ${user?.displayName}");
                            print("Signed in as ${user?.uid}");
                            vModel.navigateToHome();
                          } else {
                            print("Sign-in aborted or failed.");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF7F27),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 12.h,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/google.png',
                              width: 24.w,
                              height: 24.h,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Sign in with Google',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 5.verticalSpace,
                      // TextButton(
                      //     onPressed: () async {
                      //       vModel.navigateToHome();
                      //     },
                      //     child: Text(
                      //       'Continue without signing in',
                      //       style: GoogleFonts.poppins(
                      //         fontSize: 14.sp,
                      //         color: Colors.blue,
                      //       ),
                      //     )),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
