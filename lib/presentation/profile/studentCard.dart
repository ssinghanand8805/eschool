import 'package:flutter/material.dart';

import '../../apiHelper/GlobalData.dart';
import '../../theme/theme_helper.dart';

class StudentDetailsCard extends StatelessWidget {
  final String? fullName;
  final String? className;
  final String? admissionNo;
  final String? rollNo;
  final String? barcodeUrl;
  final String? qrCodeUrl;
  final String? imageUrl;

  const StudentDetailsCard({
    Key? key,
    required this.fullName,
    required this.className,
    required this.admissionNo,
    required this.rollNo,
    required this.barcodeUrl,
    required this.qrCodeUrl,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 600;
        return Card(
        elevation: 0,
          //color: Colors.green.shade800,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isWideScreen) _buildWideLayout() else _buildNarrowLayout(),
                const SizedBox(height: 16),
                _buildDetailsSection(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildStudentInfo()),
        //const SizedBox(width: 16),
        _buildStudentImage(),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        _buildStudentImage(),
        const SizedBox(height: 16),
        _buildStudentInfo(),
      ],
    );
  }

  Widget _buildStudentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fullName ?? "",
            style: theme.textTheme.titleLarge!
                .copyWith(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text('Adm. No: $admissionNo',
            style: theme.textTheme.titleLarge!.copyWith(fontSize: 13)),
        Text('Roll Number: $rollNo',
            style: theme.textTheme.titleLarge!.copyWith(fontSize: 13)),
      ],
    );
  }

  Widget _buildStudentImage() {
    return CircleAvatar(
      radius: 45,
      backgroundColor: Colors.grey.shade200,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? ClipOval( // Clip the image to maintain the circular shape
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover, // Ensure the image covers the CircleAvatar
          width: 90, // Width of CircleAvatar * 2 (diameter)
          height: 90, // Height of CircleAvatar * 2 (diameter)
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.person, size: 60, color: Colors.grey);
          },
        ),
      )
          : Icon(Icons.person, size: 60, color: Colors.grey),
    );
  }




  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Barcode', barcodeUrl ?? ""),
        const SizedBox(height: 8),
        _buildDetailRow('QR Code', qrCodeUrl??""),
      ],
    );
  }

  Widget _buildDetailRow(String label, String imageUrl) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: theme.textTheme.titleLarge!.copyWith(fontSize: 13,fontWeight: FontWeight.w600),
        ),
        if (imageUrl.isNotEmpty)
          Image.network(
            imageUrl,
            height: 45,
            width: 100,
            errorBuilder: (context, error, stackTrace) {
              // This will handle the error when the image URL is incorrect or fails to load
              return Text(
                'Image not available',
                style: theme.textTheme.titleLarge!
                    .copyWith(fontSize: 13,),
              );
            },
          )
        else
          Text(
            'Not available',
            style: theme.textTheme.titleLarge!
                .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
      ],
    );
  }

}


class StudentParentDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> studentData;

   StudentParentDetailsWidget({Key? key, required this.studentData}) : super(key: key);
  String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFamilyMemberCard(context, 'Father', studentData['father']),
                const SizedBox(height: 16),
                _buildFamilyMemberCard(context, 'Mother', studentData['mother']),
                const SizedBox(height: 16),
                _buildFamilyMemberCard(context, 'Guardian', studentData['guardian']),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFamilyMemberCard(BuildContext context, String title, Map<String, dynamic> data) {
    return  Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildAvatar(data['pic']),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.person, data['name']),
                      _buildInfoRow(Icons.phone, data['phone']),
                      if (data['occupation'] != null)
                        _buildInfoRow(Icons.work, data['occupation']),
                      if (data['relation'] != null)
                        _buildInfoRow(Icons.family_restroom, data['relation']),
                      if (data['email'] != null)
                        _buildInfoRow(Icons.email, data['email']),
                      if (data['address'] != null)
                        _buildInfoRow(Icons.location_on, data['address']),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String? imageUrl) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: imageUrl != null && imageUrl.isNotEmpty
          ? NetworkImage('$baseUrlFromPref$imageUrl')
          : const AssetImage('assets/projectImages/placeholder_user.png') as ImageProvider,
    );
  }

  Widget _buildInfoRow(IconData icon, String? text) {
    if (text == null || text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}