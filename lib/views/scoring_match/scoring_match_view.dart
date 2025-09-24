import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/views/scoring_match/scoring_match_vm.dart';

class ScoringMatchView extends StatelessWidget {
  final String player1;
  final String player2;
  final int matchday;
  final String originalTitle;
  final int matchIndex;
  final String tournamentName;
  final int player1Score;
  final int player2Score;
  final String date;
  final String time;

  const ScoringMatchView({
    super.key,
    required this.player1,
    required this.player2,
    required this.matchday,
    required this.originalTitle,
    required this.matchIndex,
    required this.tournamentName,
    required this.player1Score,
    required this.player2Score,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScoringMatchVM>.reactive(
      viewModelBuilder: () => ScoringMatchVM(),
      onViewModelReady: (viewModel) {
        viewModel.init(player1Score, player2Score, date, time);
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 58, 57, 57),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            title: Text(
              '$player1 vs $player2',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            leading: IconButton(
                onPressed: () {
                  NavigationService().replaceWithScoreboardView(
                    tournamentName: tournamentName,
                    originalTitle: originalTitle,
                    index: matchday - 1, // important: zero-based tab index
                  );
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            actions: [
              IconButton(
                icon: const Icon(Icons.check, color: Colors.white),
                onPressed: () {
                  viewModel.uploadMatchdays(
                    originalTitle,
                    matchIndex,
                    matchday,
                    player1,
                    player2,
                    tournamentName,
                  );
                },
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        player1,
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        player2,
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Checkbox(
                      fillColor:
                          WidgetStatePropertyAll(const Color(0xFFFF7F27)),
                      activeColor: const Color(0xFFFF7F27),
                      checkColor: Colors.white,
                      value: viewModel.isDraw,
                      onChanged: (value) {
                        viewModel.setDraw(value ?? false);
                      },
                    ),
                    Text(
                      'Draw',
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  'Score Input',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.sp),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                          cursorColor: const Color(0xFFFF7F27),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                          controller: viewModel.player1ScoreController,
                          enabled: !viewModel.isDraw,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Score',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                            ),
                          ),
                          onChanged: (val) =>
                              viewModel.scores[0] = int.tryParse(val) ?? 0),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: TextField(
                        cursorColor: const Color(0xFFFF7F27),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                        controller: viewModel.player2ScoreController,
                        enabled: !viewModel.isDraw,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Score',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ),
                        onChanged: (val) =>
                            viewModel.scores[1] = int.tryParse(val) ?? 0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  'Match Date & Time',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.sp),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          viewModel.selectDate(context);
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            readOnly: true,
                            cursorColor: const Color(0xFFFF7F27),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                            controller: viewModel.dateController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.date_range,
                                color: Colors.white,
                              ),
                              hintText: 'Date',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                              ),
                            ),
                            onChanged: (val) =>
                                viewModel.dateController.text = val,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          viewModel.selectTime(context);
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            readOnly: true,
                            cursorColor: const Color(0xFFFF7F27),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                            controller: viewModel.timeController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.access_time,
                                color: Colors.white,
                              ),
                              hintText: 'Time',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                              ),
                            ),
                            onChanged: (val) =>
                                viewModel.dateController.text = val,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
