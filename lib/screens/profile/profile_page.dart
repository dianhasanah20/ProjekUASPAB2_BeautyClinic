import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import '../history/history_page.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;

  const ProfilePage({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name;
  late String email;
  Uint8List? image;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            // FOTO
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.amber,
              backgroundImage:
                  image != null ? MemoryImage(image!) : null,
              child: image == null
                  ? const Icon(Icons.person,
                      size: 60, color: Colors.white)
                  : null,
            ),

            const SizedBox(height: 20),

            // NAMA
            Text(
              name,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // EMAIL
            Text(
              email,
              style: TextStyle(
                  fontSize: 16, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 40),

            // EDIT PROFILE
            profileMenu(
              icon: Icons.edit,
              title: 'Edit Profile',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      name: name,
                      email: email,
                      image: image,
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    name = result['name'];
                    email = result['email'];
                    image = result['image'];
                  });
                }
              },
            ),

            profileMenu(
              icon: Icons.history,
              title: 'Riwayat Treatment',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HistoryPage()),
                );
              },
            ),

            profileMenu(
                icon: Icons.favorite, title: 'Favorite Treatment'),

            profileMenu(
                icon: Icons.settings, title: 'Pengaturan'),

            profileMenu(
                icon: Icons.logout,
                title: 'Logout',
                color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget profileMenu({
    required IconData icon,
    required String title,
    Color color = Colors.black,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 10),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: color),
        title: Text(title,
            style: TextStyle(
                color: color, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}