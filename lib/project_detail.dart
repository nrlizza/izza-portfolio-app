import 'package:flutter/material.dart';

// --- Project Data Model ---
class ProjectData {
  final String title;
  final List<String> technologies;
  final String description;
  final List<String> features;
  final List<String> techStack;
  final String githubUrl;
  final String liveUrl;
  final String heroImage; // Asset path or empty for placeholder
  final List<String> screenshots; // Asset paths

  ProjectData({
    required this.title,
    required this.technologies,
    required this.description,
    required this.features,
    required this.techStack,
    required this.githubUrl,
    required this.liveUrl,
    this.heroImage = "",
    this.screenshots = const [],
  });
}

// --- Project Definitions ---
final Map<String, ProjectData> projectsData = {
  "Masak Yuk": ProjectData(
    title: "Masak Yuk",
    technologies: ["Flutter", "Express.js", "PostgreSQL"],
    description:
        "Masak Yuk is a recipe application that helps users find, save, and organize food recipes, making cooking more practical and enjoyable.",
    features: [
      "Search recipes",
      "Save favorite recipes",
      "Browse recipe categories",
      "Detailed cooking instructions",
      "User-friendly interface"
    ],
    techStack: ["Flutter", "Express.js", "PostgreSQL"],
    githubUrl: "https://github.com/nrlizza/MasakYuk.git",
    liveUrl: "https://youtube.com/shorts/PFzcSmOuLxQ?si=W7czkXqUMZBESURe",
    screenshots: [
      "assets/masak yuk 1.png",
      "assets/masak yuk 2.png",
      "assets/masak yuk 3.png",
    ],
  ),
  "EdVent": ProjectData(
    title: "EdVent",
    technologies: ["Vue.js", "Express.js", "Supabase"],
    description:
        "EdVent is a platform to manage competitions and events, including participant registration, submissions, announcements, and event activities efficiently in one integrated system.",
    features: [
      "Competition management",
      "Participant registration",
      "Submission system",
      "Event announcements",
      "Admin dashboard",
      "User management"
    ],
    techStack: ["Vue.js", "Express.js", "Supabase"],
    githubUrl: "https://github.com/nrlizza/infolomba-fe.git",
    liveUrl: "https://youtu.be/ivf1AfOGKqM?si=mTz7JMa1AMlXr4YX",
    screenshots: [
      "assets/edvent 1.png",
      "assets/edvent 2.png",
      "assets/edvent 3.png",
    ],
  ),
  "TeachLink": ProjectData(
    title: "TeachLink",
    technologies: ["Next.js", "Elysia.js", "Supabase"],
    description:
        "TeachLink is a volunteer-based educational platform that connects learners with volunteer teachers. The platform helps students find learning assistance while providing volunteers with opportunities to gain teaching experience.",
    features: [
      "Volunteer registration",
      "Tutor matching system",
      "Learning opportunity discovery",
      "Volunteer experience management",
      "Educational community platform",
      "User profiles and communication"
    ],
    techStack: ["Next.js", "Elysia.js", "Supabase"],
    githubUrl: "https://github.com/Dhikaaapr/TeachLink.git",
    liveUrl: "https://youtube.com", // Update with actual URL
    screenshots: [],
  ),
};

// --- Color Palette (consistent with profil_page.dart) ---
class ProjectDetailColors {
  static const Color primary = Color(0xFF73555F);
  static const Color primaryLight = Color(0xFFA17D88);
  static const Color primaryDark = Color(0xFF5D434B);
  static const Color background = Color(0xFFFFFFFF);
  static const Color cardBg = Color(0xFFF8F5F6);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textMedium = Color(0xFF64748B);
  static const Color accentMauve = Color(0xFF8B6B78);
}

// ============================================================
//  PROJECT DETAIL PAGE
// ============================================================
class ProjectDetailPage extends StatefulWidget {
  final String projectName;

  const ProjectDetailPage({super.key, required this.projectName});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage>
    with TickerProviderStateMixin {
  late ProjectData project;
  int _currentScreenshotIndex = 0;
  late PageController _pageController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    project = projectsData[widget.projectName] ?? projectsData.values.first;
    _pageController = PageController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectDetailColors.background,
      body: FadeTransition(
        opacity: _fadeController,
        child: CustomScrollView(
          slivers: [
            // --- App Bar with back button ---
            SliverAppBar(
              expandedHeight: 140,
              pinned: true,
              backgroundColor: ProjectDetailColors.primary,
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
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ProjectDetailColors.primaryDark,
                        ProjectDetailColors.primaryLight,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        project.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- Content ---
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // About Project Section
                  _section(
                    title: "About Project",
                    child: Text(
                      project.description,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.8,
                        color: ProjectDetailColors.textDark,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),

                  // Key Features Section
                  _section(
                    title: "Key Features",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: project.features
                          .map((feature) => _featureItem(feature))
                          .toList(),
                    ),
                  ),

                  // Technology Stack Section
                  _section(
                    title: "Technology Stack",
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: project.techStack
                          .map((tech) => _stackChip(tech))
                          .toList(),
                    ),
                  ),

                  // Project Links Section
                  _section(
                    title: "Project Links",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _actionButton(
                          label: "GitHub Repository",
                          icon: Icons.code,
                          onTap: () {
                            // TODO: Open URL
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Opening GitHub repository..."),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _actionButton(
                          label: "Live Demo / Video",
                          icon: Icons.play_circle_outline,
                          onTap: () {
                            // TODO: Open URL
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Opening live demo..."),
                              ),
                            );
                          },
                          isPrimary: false,
                        ),
                      ],
                    ),
                  ),

                  // Screenshots Gallery Section
                  if (project.screenshots.isNotEmpty)
                    _section(
                      title: "Project Screenshots",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Screenshot Carousel
                          Container(
                            height: 240,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(
                                    () => _currentScreenshotIndex = index);
                              },
                              itemCount: project.screenshots.length,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    project.screenshots[index],
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            _screenshotPlaceholder(),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Screenshot Indicator Dots
                          Center(
                            child: Wrap(
                              spacing: 6,
                              children: List.generate(
                                project.screenshots.length,
                                (index) => Container(
                                  width: _currentScreenshotIndex == index
                                      ? 24
                                      : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: _currentScreenshotIndex == index
                                        ? ProjectDetailColors.primary
                                        : ProjectDetailColors.cardBg,
                                  ),
                                ),
                              ),
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
      ),
    );
  }

  // --- Widget Helpers ---

  Widget _section({required String title, required Widget child}) {
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
              color: ProjectDetailColors.textDark,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _featureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 12),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: ProjectDetailColors.accentMauve,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(
                fontSize: 14,
                color: ProjectDetailColors.textDark,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stackChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ProjectDetailColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ProjectDetailColors.accentMauve.withOpacity(0.3),
        ),
      ),
      child: Text(
        tech,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: ProjectDetailColors.textDark,
        ),
      ),
    );
  }

  Widget _screenshotPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ProjectDetailColors.cardBg,
            ProjectDetailColors.cardBg.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image,
            size: 48,
            color: ProjectDetailColors.textMedium.withOpacity(0.5),
          ),
          const SizedBox(height: 8),
          Text(
            "Screenshot tidak tersedia",
            style: TextStyle(
              color: ProjectDetailColors.textMedium.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isPrimary
              ? ProjectDetailColors.primary
              : ProjectDetailColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: isPrimary
              ? null
              : Border.all(
                  color: ProjectDetailColors.primary.withOpacity(0.3),
                ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: ProjectDetailColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isPrimary
                  ? Colors.white
                  : ProjectDetailColors.primary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isPrimary
                    ? Colors.white
                    : ProjectDetailColors.primary,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
