import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:tournament_manager/views/standing_view/standing_vm.dart';

class StandingView extends StatelessWidget {
  final String tournamentTitle;
  const StandingView({super.key, required this.tournamentTitle});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StandingViewModel>.reactive(
      viewModelBuilder: () => StandingViewModel(),
      onViewModelReady: (model) => model.fetchStandings(tournamentTitle),
      builder: (context, model, child) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 58, 57, 57),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          title: Text("Standings",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 20)),
        ),
        body: model.isBusy
            ? const Scaffold(
                backgroundColor: Color.fromARGB(255, 58, 57, 57),
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text(
                        'Rank',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Player',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'P',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'W',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'D',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'L',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'PF',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'PA',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Pts',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    model.standings.length,
                    (index) {
                      final player = model.standings[index];
                      final isTop3 = index < 3;

                      return DataRow(
                        color: isTop3
                            ? WidgetStateProperty.all<Color>(
                                const Color(0xFFFF7F27).withOpacity(0.2))
                            : null,
                        cells: [
                          DataCell(
                            Text(
                              '${index + 1}', // Dynamic Rank
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              model.buildPlayerName(player['name']),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              player['played'].toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              player['win'].toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              player['draw'].toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              player['loss'].toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              player['pf'].toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              player['pa'].toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              player['points'].toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
