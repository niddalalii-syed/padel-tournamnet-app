// ignore_for_file: unused_import

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/views/tournament_options.dart/tournament_option_vm.dart';

class TournamentOptionView extends StatelessWidget {
  final String tournamentName;
  final String originalTitle;
  final int index;
  final tournamentData;

  const TournamentOptionView(
      {super.key,
      required this.tournamentName,
      required this.originalTitle,
      required this.index,
      this.tournamentData});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TournamentOptionVM(),
      onViewModelReady: (viewModel) =>
          viewModel.fetchParticipants(originalTitle),
      builder: (context, viewModel, child) {
        return viewModel.isBusy
            ? const Scaffold(
                backgroundColor: Color.fromARGB(255, 58, 57, 57),
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: const Color.fromARGB(255, 58, 57, 57),
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: Colors.transparent,
                  title: Text(tournamentName,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                body: Center(
                  child: Column(
                    children: [
                      // tournamentData['adminUid'] == user!.uid
                      //     ?
                      tournamentTile(
                        icon: Icons.info,
                        title: "Tournament Details",
                        subtitle: "View or modify the Tournament Details",
                        onTap: () {
                          NavigationService().navigateToTournamentDetailsView(
                              tournamentName: originalTitle, index: index);
                        },
                      ),
                      // : const SizedBox(),

                      // tournamentData['adminUid'] == user.uid
                      //     ?
                      tournamentTile(
                        icon: Icons.group,
                        title: "Participants",
                        subtitle:
                            "Add or modify the participants on this Tournament",
                        onTap: () {
                          NavigationService().replaceWithParticipantView(
                            originalTitle: originalTitle,
                            index: index,
                          );
                        },
                      ),
                      // : SizedBox(),
                      // ignore: prefer_is_empty
                      if (viewModel.userService.allParticipantsData!.length >
                              1 &&
                          viewModel.userService.listOfMatches.isEmpty)
                        tournamentTile(
                          icon: Icons.sports_tennis,
                          title: "Create Matches",
                          subtitle:
                              "Start the tournament with the current participants",
                          onTap: () {
                            log('Creating matches for $originalTitle');
                            NavigationService().replaceWithCreateMatchesView(
                              tournamentName: tournamentName,
                              originalTitle: originalTitle,
                              index: index,
                            );
                          },
                        ),

                      if (viewModel.userService.listOfMatches.isNotEmpty)
                        tournamentTile(
                          icon: Icons.scoreboard,
                          title: "Scoreboard",
                          subtitle: "View and enter scores",
                          onTap: () {
                            NavigationService().replaceWithScoreboardView(
                              tournamentName: tournamentName,
                              originalTitle: originalTitle,
                              index: index,
                              tournamentData: tournamentData,
                            );
                          },
                        ),

                      if (viewModel.userService.listOfMatches.isNotEmpty)
                        tournamentTile(
                          icon: FontAwesomeIcons.trophy,
                          title: "Standings",
                          subtitle: "View the standings",
                          onTap: () {
                            NavigationService().replaceWithStandingView(
                              tournamentTitle: originalTitle,
                            );
                          },
                        ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget tournamentTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      leading: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: const Color(0xFFFF7F27), // Match icon background color
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24.sp,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          fontSize: 12.sp,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}
