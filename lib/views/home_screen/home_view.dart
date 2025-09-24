import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.locator.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/views/create_matches/randomly/create_matches_view.dart';
import 'package:tournament_manager/views/home_screen/home_vm.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeVM(),
        builder: (context, viewModel, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color.fromARGB(255, 58, 57, 57),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('Home', style: TextStyle(color: Colors.white)),
            ),
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              locator<NavigationService>()
                                  .navigateToAllParticipantView();
                            },
                            child: Container(
                              width: 0.4.sw,
                              height: 0.15.sh,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 237, 135, 9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: EdgeInsets.only(top: 0.02.sh),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: 0.215.sw,
                                    child: Icon(Icons.person_add_alt_1,
                                        color: Colors.white, size: 40.sp),
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    "Add Participant",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          30.horizontalSpace,
                          GestureDetector(
                            onTap: () {
                              locator<NavigationService>()
                                  .clearStackAndShow(Routes.tournamentView);
                            },
                            child: Container(
                              width: 0.4.sw,
                              height: 0.15.sh,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 237, 135, 9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: EdgeInsets.only(top: 0.02.sh),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: 0.2.sw,
                                    child: Icon(FontAwesomeIcons.trophy,
                                        color: Colors.white, size: 40.sp),
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    "Tournaments",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0.05.sw),
                        child: sectionSubtitle(
                          'Match Rules',
                          icon: Icons.rule,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0.05.sw),
                        child: Text(
                          '''
- You have 1 week to complete your match

- Home game is First Name of the match so they choose venue and surface

- 1st to 2 sets wins 

- If Court time finishes before match is finished then continue another day or match will be a draw no matter the score. 

- If someone gets injured, match is won 2-1 by opponent until player returns
                              ''',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
