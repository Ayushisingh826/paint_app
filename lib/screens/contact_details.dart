import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paint_app/screens/gradient_background.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  void _launchPhone(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchSocial(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget buildCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8)],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          title: const Text("Contact Us"),
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const Text(
                "You can get in touch with us through below platforms. Our team will reach out to you as soon as it would be possible.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),
      
              // Customer Support
              buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Customer Support",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: const Icon(Icons.phone, color: Colors.black),
                      title: const Text("Contact Number"),
                      subtitle: const Text("+1 (555) 123-4567"),
                      onTap: () => _launchPhone("+15551234567"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.black),
                      title: const Text("Email Address"),
                      subtitle: const Text("help@acmeco.com"),
                      onTap: () => _launchEmail("help@acmeco.com"),
                    ),
                  ],
                ),
              ),
      
              // Social Media
              buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Social Media",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
                      title: const Text("Instagram"),
                      subtitle: const Text("@acmeco"),
                      onTap: () => _launchSocial("https://instagram.com/acmeco"),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
                      title: const Text("Twitter"),
                      subtitle: const Text("@acmeco"),
                      onTap: () => _launchSocial("https://twitter.com/acmeco"),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                      title: const Text("Facebook"),
                      subtitle: const Text("@acmeco"),
                      onTap: () => _launchSocial("https://facebook.com/acmeco"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
