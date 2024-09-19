import 'package:flutter/material.dart';

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
      backgroundColor: Colors.orange.shade100,
      backgroundImage: NetworkImage(imageUrl ?? ""),
      child: imageUrl!.isEmpty
          ? const Icon(Icons.person, size: 60, color: Colors.orange)
          : null,
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
        Text('$label: ',
            style: theme.textTheme.titleLarge!
                .copyWith(fontSize: 13, )),
        // const SizedBox(width: 8),
        if (imageUrl.isNotEmpty)
          Image.network(imageUrl, height: 45, width: 100)
        else
          Text('Not available',
              style: theme.textTheme.titleLarge!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
