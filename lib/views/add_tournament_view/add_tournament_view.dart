// ignore_for_file: await_only_futures

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tournament_manager/views/add_tournament_view/add_tournament_vm.dart';
// import 'package:tournament_manager/views/create_matches/randomly/create_matches_view.dart';

class NewTournamentView extends StatelessWidget {
  const NewTournamentView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NewTournamentVM(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 58, 57, 57),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              'New Tournament',
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: model.back,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tournament Name',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFF7F27),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Choose a name for your Tournament',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Form(
                    key: model.formKey,
                    child: TextFormField(
                        cursorColor: const Color(0xFFFF7F27),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                        decoration: const InputDecoration(
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
                          hintText: 'Enter tournament name',
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                        onChanged: (value) =>
                            model.tournamentNameController.text = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a tournament name';
                          }

                          if (value.isNotEmpty) {
                            for (int i = 0;
                                i <
                                    model.userService.allTournamentsData!
                                        .length;) {
                              if (model.userService.allTournamentsData![i]
                                      ['tournamentName'] ==
                                  value.trimRight()) {
                                return 'Tournament already exists';
                              } else {
                                i++;
                              }
                            }
                          }

                          if (value.isNotEmpty) {
                            //  viewModel
                            //                               .userService
                            //                               .allTournamentsName!
                            for (int i = 0;
                                i <
                                    model.userService.allTournamentsName!
                                        .length;) {
                              if (model.userService.allTournamentsName![i]
                                      ['tournamentName'] ==
                                  value.trimRight()) {
                                return 'Tournament Name already associated with an existing tournament';
                              } else {
                                i++;
                              }
                            }
                          }

                          return null;
                        }),
                  ),
                  // SizedBox(height: 8.h),
                  // Text(
                  //   'You can create a new tournament by watching a short advertisement or by removing ads for a whole year. Thanks for helping us to keep the app free.',
                  //   style: GoogleFonts.poppins(
                  //     fontSize: 14.sp,
                  //     color: Colors.black54,
                  //   ),
                  // ),
                  SizedBox(height: 24.h),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7F27),
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 24.w,
                        ),
                      ),
                      child: Text(
                        'Create Tournament',
                        style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      onPressed: () async {
                        int tId = await model.generateSixDigitId();
                        String accPass = await model.generatePassword();
                        String admPass = await model.generatePassword();

                        model.createTournament(tId, accPass, admPass);
                      },
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
