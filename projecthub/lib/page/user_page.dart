import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final String name;
  final String urlImage;

  const UserPage({
    Key? key,
    required this.name,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(
            "My Portfolio",
            style: TextStyle(
              color: Colors.white,          // Set text color to white
              fontWeight: FontWeight.bold, // Make the text bold
              fontSize: 20,                 // Optional: increase font size
            ),
          ),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(urlImage),
                ),
                const SizedBox(height: 16),
                Text(
                  name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cybersecurity | Full-Stack Developer',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                buildSectionTitle("About Me"),
                Text(
                  "I'm a motivated and innovative tech enthusiast with a strong foundation in cybersecurity and full-stack development. "
                  "I bring real-world problem-solving to digital transformation initiatives with efficient, secure, and scalable solutions.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                buildSectionTitle("Skills"),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    buildSkillChip("Python"),
                    buildSkillChip("Flutter"),
                    buildSkillChip("Java"),
                    buildSkillChip("Dart"),
                    buildSkillChip("Spring Boot"),
                    buildSkillChip("MongoDB"),
                    buildSkillChip("Firebase"),
                    buildSkillChip("React"),
                    buildSkillChip("Docker"),
                    buildSkillChip("Nmap"),
                    buildSkillChip("Burp Suite"),
                  ],
                ),
                const SizedBox(height: 24),
                buildSectionTitle("Projects"),
                buildProjectCard(
                  title: "SecureVault",
                  description:
                      "CLI password manager with encryption and MySQL (Python).",
                ),
                buildProjectCard(
                  title: "Malware Analysis Sandbox",
                  description:
                      "Dockerized malware lab with Wireshark for analysis.",
                ),
                buildProjectCard(
                  title: "Doodle Dash",
                  description:
                      "Real-time multiplayer Skribbl.io clone in Flutter.",
                ),
                buildProjectCard(
                  title: "LiveVibe",
                  description:
                      "Twitch-style live streaming & chat platform (Flutter).",
                ),
                buildProjectCard(
                  title: "TalentTrack",
                  description:
                      "Employee management system with Flutter + Spring Boot.",
                ),
                buildProjectCard(
                  title: "Business Automation Suite",
                  description:
                      "Python scripts for reporting, scheduling & email automation.",
                ),
                const SizedBox(height: 24),
                buildSectionTitle("Achievements"),
                buildAchievement("Top 4 Finalist – NASA Space Apps Challenge (AR Web App)"),
                buildAchievement("Hosted CTF with 75+ cybersecurity participants"),
                buildAchievement("Trained 150+ students in cybersecurity (80+ topics)"),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add your action here
                  },
                  icon: Icon(Icons.download, color: Colors.white),
                  label: Text("Download Resume"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white, // ✅ This sets text/icon color
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),

              ],
            ),
          ),
        ),
      );

  Widget buildSectionTitle(String title) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Container(
          height: 2,
          width: 60,
          color: Colors.deepPurple,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildSkillChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.deepPurple[50],
      labelStyle: TextStyle(color: Colors.deepPurple),
      shape: StadiumBorder(
        side: BorderSide(color: Colors.deepPurple),
      ),
    );
  }

  Widget buildProjectCard({required String title, required String description}) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description, style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget buildAchievement(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.deepPurple),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
