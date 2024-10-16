// import 'package:flutter/material.dart';
//
// class UserProfileModal extends StatelessWidget {
//   final String email;
//   final List<Map<String, String>> groups;
//
//   const UserProfileModal({
//     Key? key,
//     required this.email,
//     required this.groups,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.close),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildProfileHeader(),
//               SizedBox(height: 24),
//               _buildInfoSection('Bio', 'No bio added yet...'),
//               _buildInfoSection('Phone', 'No phone added yet...'),
//               _buildInfoSection('Email', email),
//               _buildInfoSection('Media', 'No media shared yet...'),
//               SizedBox(height: 24),
//               _buildGroupsSection(),
//               SizedBox(height: 24),
//               _buildBlockToggle(),
//               SizedBox(height: 24),
//               _buildReportButton(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileHeader() {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 40,
//           backgroundImage: AssetImage('assets/profile_placeholder.png'),
//         ),
//         SizedBox(width: 16),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'John Doe',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 4),
//             Row(
//               children: [
//                 Container(
//                   width: 8,
//                   height: 8,
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 SizedBox(width: 4),
//                 Text('Online', style: TextStyle(color: Colors.grey[600])),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInfoSection(String title, String content) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
//           SizedBox(height: 4),
//           Text(content, style: TextStyle(fontSize: 16)),
//           Divider(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildGroupsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Groups in common', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         SizedBox(height: 8),
//         Text('2 groups', style: TextStyle(color: Colors.grey[600])),
//         SizedBox(height: 16),
//         ...groups.map((group) => _buildGroupItem(group['name']!, group['members']!)).toList(),
//       ],
//     );
//   }
//
//   Widget _buildGroupItem(String name, String members) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: Colors.blue[100],
//             radius: 24,
//             child: Icon(Icons.group, color: Colors.blue, size: 24),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                 SizedBox(height: 4),
//                 Text(members, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBlockToggle() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text('Block User', style: TextStyle(fontSize: 16)),
//         Switch(value: false, onChanged: (value) {}),
//       ],
//     );
//   }
//
//   Widget _buildReportButton(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         child: Text('Report User'),
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.red,
//           padding: EdgeInsets.symmetric(vertical: 16),
//         ),
//       ),
//     );
//   }
// }
//
// // Usage example
// void showUserProfileModal(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (BuildContext context) {
//       return FractionallySizedBox(
//         heightFactor: 0.9,
//         child: UserProfileModal(
//           email: 'sam2@sam2.com',
//           groups: [
//             {'name': 'Test', 'members': 'You, Anand Singh, San...'},
//             {'name': 'test2', 'members': 'You, Anand Singh, San...'},
//           ],
//         ),
//       );
//     },
//   );
// }