import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tournament_manager/views/add_existing_tournament/add_existing_tournament_vm.dart';

class ExistingTournamentView extends StatelessWidget {
  const ExistingTournamentView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ExistingTournamentVM(),
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromARGB(255, 58, 57, 57),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              'Add Existing Tournament',
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
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: model.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tournament ID',
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
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
                          hintText: 'Enter tournament ID',
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                        onChanged: (value) =>
                            model.tournamentIdController.text = value,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a tournament ID'
                            : null,
                      ),
                      //
                      SizedBox(height: 16.h),
                      //
                      Text(
                        'Tournament Name',
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
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
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a tournament name'
                            : null,
                      ),
                      //
                      SizedBox(height: 16.h),
                      //
                      Text(
                        'Access Password',
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
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
                          hintText: 'Enter Access Password',
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                        onChanged: (value) =>
                            model.accessPasswordController.text = value,
                        validator: (value) =>
                            value!.isEmpty ? 'Please Access Password' : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),

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
                      'Add Tournament',
                      style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onPressed: () async {
                      model.createTournament(
                          model.tournamentIdController.text,
                          model.tournamentNameController.text,
                          model.accessPasswordController.text);
                    },
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
