import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInfoWidget extends StatelessWidget {
  const DeveloperInfoWidget({super.key});

  // Helper function to open URLs
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Developer Name
            const Text(
              'Developer:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ravi Kumar',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Contact Information
            const Text(
              'Contact:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _launchUrl('mailto:rkapps.ravi+tracker_app@gmail.com'),
              child: const Text(
                'Email: rkapps.ravi+tracker_app@gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),

            // Social Media Links
            const Text(
              'Follow Me:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.public),
                  onPressed: () => _launchUrl('https://rkumarkravi.github.io'),
                  tooltip: 'Website',
                ),
                IconButton(
                  icon: const Icon(Icons.supervised_user_circle),
                  onPressed: () => _launchUrl('https://www.linkedin.com/in/ravi-kumar-83b9b2150/'),
                  tooltip: 'LinkedIn',
                ),
              ],
            ),

            const SizedBox(height: 24),

            // About the Developer
            const Text(
              'About Me:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Hi, I am Ravi Kumar, a passionate Flutter developer with a love for building efficient and user-friendly mobile applications. Feel free to reach out if you have any questions or feedback!',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
