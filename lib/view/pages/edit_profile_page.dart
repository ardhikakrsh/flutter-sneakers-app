import 'package:flutter/material.dart';
import 'package:ppb_test/components/my_button.dart';
import 'package:ppb_test/service/auth/auth_service.dart';
import 'package:ppb_test/service/database/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService db = FirestoreService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();

  String? userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    setState(() {
      isLoading = true;
    });

    final user = AuthService().getCurrentUser();
    if (user != null) {
      userId = user.uid;

      try {
        // First try to get user doc using UID
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            nameController.text = userDoc['name'] ?? user.displayName ?? '';
            phoneController.text = userDoc['phone'] ?? 'Phone number not set';
            addressController.text = userDoc['address'] ?? 'Location not set';
            instagramController.text =
                userDoc['instagram'] ?? 'Instagram not set';
          });
        } else {
          // If user doc doesn't exist by UID, try to find by email
          final querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: user.email)
              .limit(1)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            final doc = querySnapshot.docs.first;
            setState(() {
              nameController.text = doc['name'] ?? user.displayName ?? '';
              phoneController.text = doc['phone'] ?? 'Phone number not set';
              addressController.text = doc['address'] ?? 'Location not set';
              instagramController.text =
                  doc['instagram'] ?? 'Instagram not set';
            });
          } else {
            // Initialize with default values if no document found
            setState(() {
              nameController.text = user.displayName ?? '';
              addressController.text = 'Location not set';
            });
          }
        }
      } catch (e) {
        // Handle any errors
        showSnackBar("Error loading profile: ${e.toString()}", isError: true);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  void saveUserData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final user = AuthService().getCurrentUser();
      if (user != null) {
        try {
          // Update display name in Firebase Auth
          await user.updateDisplayName(nameController.text);

          // Prepare data to update
          Map<String, dynamic> userData = {
            'name': nameController.text,
            'phone': phoneController.text,
            'address': addressController.text,
            'instagram': instagramController.text,
            'updatedAt': DateTime.now(),
          };

          // Check if user document exists by UID
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          if (userDoc.exists) {
            // Update existing document by UID
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .update(userData);
          } else {
            // Try to find and update document by email
            final querySnapshot = await FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: user.email)
                .limit(1)
                .get();

            if (querySnapshot.docs.isNotEmpty) {
              // Update existing document found by email
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(querySnapshot.docs.first.id)
                  .update(userData);
            } else {
              // Create new document with UID as document ID
              userData['email'] = user.email;
              userData['createdAt'] = DateTime.now();

              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .set(userData);
            }
          }

          // Reload user to update display name
          await user.reload();

          showAnimation(
            'Profile updated!',
            'assets/lotties/login.json',
            true,
          );
        } catch (e) {
          showAnimation(
            'Failed to update profile: ${e.toString()}',
            'assets/lotties/error.json',
            false,
          );
        }
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService().getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Profile Photo
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : const AssetImage('assets/icons/logo1.png')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user?.displayName ?? nameController.text,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, color: Colors.blue),
                      Text(addressController.text.isNotEmpty
                          ? addressController.text
                          : "Location not set"),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Profile Edit Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildEditableField(
                            Icons.person, "Full Name", nameController),
                        // Display email (read-only)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            initialValue: user?.email ?? '',
                            enabled: false,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.email, color: Colors.blue),
                              labelText: "Email (cannot be changed)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                            ),
                          ),
                        ),
                        buildEditableField(
                            Icons.phone, "Phone Number", phoneController),
                        buildEditableField(
                            Icons.location_on, "Address", addressController),
                        buildEditableField(Icons.photo_camera, "Instagram",
                            instagramController),
                        const SizedBox(height: 20),
                        MyButton(
                          text: 'Save Changes',
                          icon: Icons.save,
                          onPressed: saveUserData,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Input Field Widget
  Widget buildEditableField(
      IconData icon, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (label == "Full Name" && (value == null || value.isEmpty)) {
            return "Please enter your name";
          }
          return null;
        },
      ),
    );
  }

  void showAnimation(String message, String animationPath, bool isSuccess) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                animationPath,
                fit: BoxFit.fill,
                height: 200.0,
                width: 200.0,
                repeat: false,
              ),
              Text(
                message,
                style: TextStyle(
                  color: isSuccess ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
      if (isSuccess) {
        Navigator.pop(
            context); // Return to previous screen after successful update
      }
    });
  }

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    instagramController.dispose();
    super.dispose();
  }
}
