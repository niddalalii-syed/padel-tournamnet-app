import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tournament_manager/app/app.router.dart';
import 'package:tournament_manager/views/all_participants/participants/all_participant_vm.dart';

class AllParticipantView extends StatelessWidget {
  const AllParticipantView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => AllParticipantVM(),
        onViewModelReady: (viewModel) => viewModel.fetchParticipants(),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 58, 57, 57),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              title: viewModel.participants > 0
                  ? Text(
                      'Participants (${viewModel.participants})',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Text(
                      'Participants',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
            body: Center(
              child: Column(
                children: [
                  addTile(
                    icon: Icons.add,
                    title: 'New Competitor',
                    subtitle: 'Add a new competitor to the tournament',
                    onTap: () async {
                      NavigationService().replaceWithAddtoAllParticipantView();
                    },
                  ),
                  20.verticalSpace,
                  viewModel.userService.allParticipantsData!.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: viewModel
                                .userService.allParticipantsData!.length,
                            itemBuilder: (context, index) {
                              final participant = viewModel
                                  .userService.allParticipantsData![index];
                              return playerTile(
                                imageUrl: participant['imageUrl'] ?? '',
                                participantName: participant['name'] ?? '',
                                onTap: () {
                                  NavigationService()
                                      .replaceWithEditAllParticipantView(
                                    participantName: participant['name'] ?? '',
                                  );
                                },
                              );
                            },
                          ),
                        )
                      : Text(
                          'No participants found',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }
}

Widget addTile({
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
        color: const Color(0xFFFF7F27),
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
        color: Colors.grey,
      ),
    ),
    onTap: onTap,
  );
}

Widget playerTile({
  required String imageUrl,
  required String participantName,
  required VoidCallback onTap,
}) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    leading: Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.person,
                      color: const Color(0xFFFF7F27), size: 24.sp);
                },
              )
            : Icon(Icons.person, color: const Color(0xFFFF7F27), size: 24.sp),
      ),
    ),
    title: Text(
      participantName,
      style: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    onTap: onTap,
  );
}
