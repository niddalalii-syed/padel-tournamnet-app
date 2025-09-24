import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:tournament_manager/views/splash_screen/splash_vm.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      viewModelBuilder: () => SplashVM(),
      builder: (context, vModel, child) {
        return Scaffold(
          backgroundColor: Colors.black,
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
                  Center(
                    child: Text(
                      'Welcome to \nAKI\'S TENNIS LEAGUE',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
