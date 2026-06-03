import 'package:flutter/material.dart';
import 'package:praktikum/project_detail.dart';

// --- Portfolio Detail Page untuk menampilkan project dengan gambar ---
class PortfolioDetailPage extends StatefulWidget {
  final String projectName;

  const PortfolioDetailPage({super.key, required this.projectName});

  @override
  State<PortfolioDetailPage> createState() => _PortfolioDetailPageState();
}

class _PortfolioDetailPageState extends State<PortfolioDetailPage> {
  late ProjectData project;

  @override
  void initState() {
    super.initState();
    project = projectsData[widget.projectName] ?? projectsData.values.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: CustomScrollView(
        slivers: [
          // --- Hero Image AppBar ---
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: const Color(0xFF73555F),
            foregroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeaderImage(),
            ),
          ),

          // --- Main Content ---
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Title and Tech Stack
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.technologies.join(" • "),
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF1E293B).withOpacity(0.65),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Deskripsi Project
                _buildSection(
                  title: "Tentang Project",
                  child: Text(
                    project.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.8,
                      color: Color(0xFF1E293B),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),

                // Screenshots Gallery
                if (project.screenshots.isNotEmpty)
                  _buildSection(
                    title: "Screenshot Project",
                    child: _buildScreenshotsGallery(),
                  ),

                // Key Features
                _buildSection(
                  title: "Fitur Utama",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: project.features
                        .map((feature) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 6, right: 12),
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF8B6B78),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF1E293B),
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),

                // Technology Stack
                _buildSection(
                  title: "Tech Stack",
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: project.techStack
                        .map((tech) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F5F6),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF8B6B78).withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                tech,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),

                // Project Links (Buttons)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (project.githubUrl.isNotEmpty)
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "GitHub: ${project.githubUrl}",
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.code),
                          label: const Text("Lihat di GitHub"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF73555F),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      const SizedBox(height: 12),
                      if (project.liveUrl.isNotEmpty)
                        OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Demo: ${project.liveUrl}",
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.play_circle_outline),
                          label: const Text("Lihat Demo / Video"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF73555F),
                            side: const BorderSide(
                              color: Color(0xFF73555F),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Build Header Image dengan Image.asset() ---
  Widget _buildHeaderImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF5D434B), Color(0xFFA17D88)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // Display first screenshot atau placeholder
        if (project.screenshots.isNotEmpty)
          Image.asset(
            project.screenshots[0],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(
                  Icons.image,
                  size: 80,
                  color: Colors.white.withOpacity(0.3),
                ),
              );
            },
          )
        else
          Center(
            child: Icon(
              Icons.project_outline,
              size: 80,
              color: Colors.white.withOpacity(0.3),
            ),
          ),

        // Overlay untuk darkening
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Build Screenshots Gallery dengan Image.asset() ---
  Widget _buildScreenshotsGallery() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          project.screenshots.length,
          (index) => Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 12,
              right: index == project.screenshots.length - 1 ? 0 : 12,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                project.screenshots[index],
                width: 160,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 160,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F5F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.image,
                      size: 48,
                      color: const Color(0xFF64748B).withOpacity(0.5),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper: Build Section ---
  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
