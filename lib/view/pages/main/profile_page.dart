import 'package:flutter/material.dart';
import 'package:ppb_test/components/my_edit_button.dart';
import 'package:ppb_test/service/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ppb_test/view/pages/profile/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> userData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      isLoading = true;
    });

    final user = AuthService().getCurrentUser();
    if (user != null) {
      try {
        // First try to get user doc using UID
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userData = userDoc.data() ?? {};
          });
        } else {
          // If user doc doesn't exist by UID, try to find by email
          final querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: user.email)
              .limit(1)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              userData = querySnapshot.docs.first.data();
            });
          }
        }
      } catch (e) {
        // Handle error silently
        print("Error loading user data: $e");
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService().getCurrentUser();

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Header with profile photo
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: user?.photoURL != null
                              ? NetworkImage(user!.photoURL!)
                              : const AssetImage('assets/icons/app_logo.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          userData['name'] ?? user?.displayName ?? 'No Name',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on, color: Colors.blue),
                            Text(
                              userData['address'] ?? "Not Set Location",
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: MyEditButton(
                            text: 'Edit Profile',
                            icon: Icons.edit,
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfilePage()),
                              );
                              _loadUserData();
                            },
                          ),
                        ),

                        // Account Information
                        const SizedBox(height: 50),
                        // Email (always show from Firebase Auth)
                        buildInfoRow(
                            Icons.email, "Email", user?.email ?? 'No Email'),

                        // Other fields from Firestore
                        if (userData['phone'] != null &&
                            userData['phone'].isNotEmpty)
                          buildInfoRow(
                              Icons.phone, "Phone Number", userData['phone']),

                        if (userData['instagram'] != null &&
                            userData['instagram'].isNotEmpty)
                          buildInfoRow(Icons.photo_camera, "Instagram",
                              userData['instagram']),

                        // Empty state message if no social profiles added
                        if (userData['phone'] == null ||
                            userData['phone'].isEmpty &&
                                userData['instagram'] == null ||
                            userData['instagram'].isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 50),
                            child: Text(
                              "Click 'Edit Profile' to add more information.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Widget for Account Information rows
  Widget buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
