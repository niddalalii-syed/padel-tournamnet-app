// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/views/scoreboard_view/scoreboard_vm.dart';

class ScoreboardView extends StatelessWidget {
  final String tournamentName;
  final String originalTitle;
  final int index;
  final tournamentData;
  const ScoreboardView({
    super.key,
    required this.tournamentName,
    required this.originalTitle,
    required this.index,
    this.tournamentData,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScoreboardVM>.reactive(
      viewModelBuilder: () => ScoreboardVM(),
      onViewModelReady: (model) => model.fetchMatchdays(originalTitle),
      builder: (context, model, child) {
        final user = FirebaseAuth.instance.currentUser;
        return model.isBusy
            ? Scaffold(
                backgroundColor: const Color.fromARGB(255, 58, 57, 57),
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'Scoreboard',
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                body: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : DefaultTabController(
                length: model.matchdays.length,
                initialIndex: index.clamp(0, model.matchdays.length - 1),
                child: Scaffold(
                  backgroundColor: const Color.fromARGB(255, 58, 57, 57),
                  appBar: AppBar(
                    iconTheme: const IconThemeData(color: Colors.white),
                    backgroundColor: Colors.transparent,
                    title: Text(
                      'Scoreboard',
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    bottom: TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: const Color(0xFFFF7F27),
                      isScrollable: true,
                      tabs: model.matchdays
                          .map(
                              (day) => Tab(text: 'Matchday ${day['matchday']}'))
                          .toList(),
                    ),
                  ),
                  body: TabBarView(children: [
                    ...model.matchdays.map((day) {
                      final matches = day['matches'];
                      final matchday = int.parse(day['matchday']);

                      return Padding(
                        padding: EdgeInsets.all(12.w),
                        child: ListView.separated(
                          itemCount: matches.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            final match = matches[index];
                            return GestureDetector(
                              onTap: () {
                                print(match['time']);
                                print(match['date']);
                                NavigationService().replaceWithScoringMatchView(
                                  player1: match['player1'],
                                  player2: match['player2'],
                                  matchday: matchday,
                                  originalTitle: originalTitle,
                                  matchIndex: index,
                                  tournamentName: tournamentName,
                                  player1Score: match['score1'] ?? 0,
                                  player2Score: match['score2'] ?? 0,
                                  date: match['date'],
                                  time: match['time'],
                                );
                              },
                              child: playerCard(match),
                            );
                          },
                        ),
                      );
                      // ignore: unnecessary_to_list_in_spreads
                    }).toList(),
                  ]),
                ),
              );
      },
    );
  }
}
// ```

// --- ✅ In `ScoringMatchVM.dart` (inside `uploadMatchdays`) ---
// Make sure you're doing:

// ```dart
// NavigationService().replaceWithScoreboardView(
//   tournamentName: tournamentName,
//   originalTitle: originalTitle,
//   index: matchDay - 1, // important: zero-based tab index
// );
// ```

// Let me know if you'd like me to paste the final versions of both files or handle tab switching with animation too.

Widget playerCard(final match) {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100.w,
                child: Column(
                  children: [
                    Text(match['player1'],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(fontSize: 16.sp)),
                    SizedBox(height: 4.h),
                    Text(match['score1'].toString(),
                        style: GoogleFonts.poppins(fontSize: 14.sp)),
                  ],
                ),
              ),
              const Spacer(),
              Text('-', style: GoogleFonts.poppins(fontSize: 20.sp)),
              const Spacer(),
              SizedBox(
                width: 100.w,
                child: Column(
                  children: [
                    Text(
                      match['player2'],
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 16.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      match['score2'].toString(),
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    ),
                  ],
                ),
              )
            ],
          ),
          if (match['date'] != "" || match['time'] != "") 4.verticalSpace,
          if (match['date'] != "" || match['time'] != "")
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.date_range,
                  color: Color(0xFFFF7F27),
                  size: 20.sp,
                ),
                Text(
                  match['date'] ?? "Not Selected",
                  style: GoogleFonts.poppins(fontSize: 14.sp),
                ),
                SizedBox(width: 20.w),
                Icon(
                  Icons.access_time,
                  color: Color(0xFFFF7F27),
                  size: 20.sp,
                ),
                Text(
                  match['time'] ?? "Not Selected",
                  style: GoogleFonts.poppins(fontSize: 14.sp),
                ),
              ],
            ),
        ],
      ),
    ),
  );
}

Widget addDate(
  final VoidCallback? onTap,
) {
  return Card(
      child: ListTile(
    leading: const Icon(Icons.date_range, color: Colors.white),
    title: Text(
      'Add Match Date',
      style: GoogleFonts.poppins(
        fontSize: 16.sp,
        color: Colors.white,
      ),
    ),
    onTap: onTap,
    tileColor: const Color(0xFFFF7F27),
  ));
}
