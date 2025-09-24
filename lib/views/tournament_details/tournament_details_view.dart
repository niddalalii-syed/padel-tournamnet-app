import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/views/tournament_details/tournament_details_vm.dart';

class TournamentDetailsView extends StatelessWidget {
  final String tournamentName;
  final int index;
  const TournamentDetailsView(
      {super.key, required this.tournamentName, required this.index});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => TournamentDetailsVM(),
        onViewModelReady: (viewModel) => viewModel.init(tournamentName),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 58, 57, 57),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              title: Text(viewModel.singleData['tournamentName'] ??
                  'Tournament Details'),
              titleTextStyle: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    viewModel.onSave(tournamentName, index);
                    viewModel.rebuildUi();
                  },
                  icon: Icon(Icons.check, size: 24.sp, color: Colors.white),
                ),
              ],
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tournament Name
                    Text(
                      'Tournament Name',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Form(
                      key: viewModel.tournamentFormKey,
                      child: TextFormField(
                        controller: viewModel.tournamentNameController,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        onChanged: (value) => {
                          viewModel.tournamentNameController.text = value,
                          viewModel.notifyListeners(),
                        },
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a tournament name'
                            : null,
                      ),
                    ),
                    20.verticalSpace,
                    // Created on
                    Text(
                      'Created on',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFF7F27),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      viewModel.formattedCreatedDate,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Last Updated
                    Text(
                      'Last Updated',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFF7F27),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      viewModel.formattedUpdateDate,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),

                    // Users

                    SizedBox(height: 24.h),

                    // List Tiles
                    actionTile(
                      icon: Icons.lock,
                      iconColor: Colors.white,
                      title: 'Tournament Access Details',
                      subtitle: 'Password to access the Tournament',
                      onTap: () {
                        showCustomDialog(
                            context, viewModel.singleData, tournamentName);
                      },
                    ),
                    actionTile(
                      icon: Icons.visibility_off,
                      iconColor: Colors.white,
                      title: 'Modify Tournament',
                      subtitle: 'Recreate the tournament matches',
                      onTap: () async {
                        if (viewModel.userService.allParticipantsData != null &&
                            viewModel.userService.allParticipantsData!.length !=
                                1) {
                          NavigationService().replaceWithModifyMatchesView(
                              originalTitle: tournamentName,
                              index: index,
                              tournamentName:
                                  viewModel.tournamentNameController.text);
                        } else {
                          SnackbarService().showSnackbar(
                            message: 'No participants found to modify',
                            title: 'Error',
                            duration: const Duration(seconds: 2),
                          );
                        }
                      },
                    ),
                    actionTile(
                      icon: Icons.share,
                      iconColor: Colors.white,
                      title: 'Share Tournament',
                      subtitle: 'Share the tournament with others',
                      onTap: () {
                        final user = FirebaseAuth.instance.currentUser;
                        if (viewModel.isMatches == true) {
                          viewModel.launchURL(
                              "https://flutterweb.veloxis.co/?uid=${user!.uid}&tournamentName=$tournamentName");
                        } else {
                          SnackbarService().showSnackbar(
                            message: 'No matches found to share',
                            title: 'Error',
                            duration: const Duration(seconds: 2),
                          );
                        }
                      },
                    ),
                    actionTile(
                      icon: Icons.delete,
                      iconColor: Colors.white,
                      title: 'Remove Tournament',
                      subtitle:
                          'Remove this tournament and all its data for all the users',
                      onTap: () {
                        viewModel.onDelete(tournamentName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

Widget actionTile({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
    leading: Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: iconColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: 24.sp,
      ),
    ),
    title: Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: GoogleFonts.poppins(
        fontSize: 13.sp,
        color: Colors.white70,
      ),
    ),
    onTap: onTap,
  );
}

void showCustomDialog(BuildContext context, singleData, tournamentName) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tournament Id: ${singleData['TournamentId'] ?? 'N/A'}',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Access Code: ${singleData['AccessPassword'] ?? 'N/A'}',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Tournament Name: ${tournamentName ?? 'N/A'}',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
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
