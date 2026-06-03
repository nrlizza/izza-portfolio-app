import 'package:flutter/material.dart';
import 'package:praktikum/new_form.dart';
import 'package:praktikum/project_detail.dart';

// ============================================================
//  PROFILE PAGE - Example StatefulWidget in Flutter
//  Concepts demonstrated:
//  1. StatefulWidget & State
//  2. Scaffold, AppBar, FloatingActionButton
//  3. Stack & Positioned
//  4. Column, Row, Container
//  5. Navigator & Routing
//  6. setState() to update the UI
//  7. Hero animation (avatar between pages)
//  8. AnimatedOpacity for smooth content transitions
// ============================================================

// --- Custom Color Palette ---
class AppColors {
  static const Color primary = Color(0xFF73555F);
  static const Color primaryLight = Color(0xFFA17D88);
  static const Color primaryDark = Color(0xFF5D434B);
  static const Color background = Color(0xFFFFFFFF);
  static const Color cardBg = Color(0xFFF8F5F6);
  static const Color iconBg = Color(0xFFF8F5F6);
  static const Color chipBorder = Color(0xFFD4C5CA);
  static const Color textDark = Color(0xFF1E293B);
}

// Use StatefulWidget because this page has
//    mutable state (the active tab)
class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilPage();
}

class _ProfilPage extends State<ProfilPage> {
  //  Variabel state: menyimpan tab yang sedang aktif
  //    0 = About Me, 1 = Portfolio, 2 = Contact
  int _activePage = 0;

  //  Controls the fade-in animation for page content
  double _contentOpacity = 1.0;

  //  Profile data separated for easier modification
  final String _name = "Nurul Izza";
  final String _role = "Informatics Student";

  @override
  Widget build(BuildContext context) {
    //  MediaQuery is used to get the screen size
    //    so the layout can be responsive on all devices
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //  backgroundColor mengatur warna latar belakang halaman
      backgroundColor: AppColors.background,

      //  FloatingActionButton: a circular button that floats above content
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator.push: berpindah ke halaman baru
          // MaterialPageRoute: animasi transisi standar Material Design
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewForm()),
          );
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Add",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      //  body: konten utama halaman
      body: SingleChildScrollView(
        //  SingleChildScrollView: enables scrolling
        //    when content exceeds the screen height
        child: Stack(
          //  Stack: layers widgets on top of each other
          //    Used to create the tab button effect
          //    that "sticks" between the header and the content
          children: [
            Column(
              children: [
                _buildHeader(screenHeight, screenWidth),
                const SizedBox(height: 60),

                //  AnimatedOpacity: adds a fade animation when content changes
                AnimatedOpacity(
                  opacity: _contentOpacity,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  child: AnimatedSwitcher(
                    //  AnimatedSwitcher: adds animation when content changes
                    duration: const Duration(milliseconds: 300),
                    child: _activePage == 0
                        ? _aboutPage()
                        : (_activePage == 1 ? _portoPage() : _contactPage()),
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),

            Positioned(
              top: screenHeight * 0.29,
              left: 16,
              right: 16,
              child: _buildTabBar(),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  WIDGET HELPER: Profile Header
  // ============================================================
  Widget _buildHeader(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.33,
      width: screenWidth,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        //  borderRadius only on the bottom corners (rounded effect)
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //  Hero: creates a shared-element animation between pages
          //    The avatar will "fly" from this page to NewForm and back
          Hero(
            tag: 'profile-avatar',
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              //  Gunakan backgroundImage untuk foto dari assets
              backgroundImage: const AssetImage("assets/izza.jpeg"),
              // Jika gambar tidak ada, tampilkan icon default:
              child: null,
              // child: Icon(Icons.person, size: 50, color: AppColors.primary),
            ),
          ),

          const SizedBox(height: 12),

          //  Text widget dengan style kustom
          Text(
            _name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 4),

          //  Chip: label kecil untuk menampilkan role/jabatan
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _role,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  WIDGET HELPER: Tab Bar (navigation buttons)
  // ============================================================
  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        //  boxShadow: efek bayangan di bawah Container
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          //  Expanded: makes each button fill the same space
          Expanded(child: _tabButton("About Me", 0, Icons.person_outline)),
          Expanded(child: _tabButton("Portfolio", 1, Icons.work_outline)),
          Expanded(child: _tabButton("Contact", 2, Icons.mail_outline)),
        ],
      ),
    );
  }

  // ============================================================
  //  WIDGET HELPER: Individual Tab Button
  // ============================================================
  Widget _tabButton(String label, int index, IconData icon) {
    //  Cek apakah tab ini sedang aktif
    final bool isActive = _activePage == index;

    return GestureDetector(
      //  GestureDetector: mendeteksi gesture (tap, swipe, dll)
      onTap: () {
        //  Fade out → switch page → fade in (AnimatedOpacity)
        setState(() {
          _contentOpacity = 0.0;
        });

        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            _activePage = index;
            _contentOpacity = 1.0;
          });
        });
      },
      child: AnimatedContainer(
        //  AnimatedContainer: Container dengan animasi otomatis
        //    saat propertinya berubah
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          //  Warna berubah berdasarkan status aktif/tidak
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? Colors.white : AppColors.textDark.withOpacity(0.65),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : AppColors.textDark.withOpacity(0.65),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  CONTENT TAB 1: About Me
  // ============================================================
  Widget _aboutPage() {
    //  Key digunakan oleh AnimatedSwitcher untuk membedakan widget
    return Container(
      key: const ValueKey("about"),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("About Me"),

          //  Card: Container dengan bayangan dan sudut membulat bawaan
          Card(
            elevation: 0,
            color: AppColors.cardBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _infoRow(Icons.person, "Name", "Nurul Izza"),
const Divider(height: 20),

_infoRow(Icons.location_on, "Address", "East Jakarta"),
const Divider(height: 20),

_infoRow(Icons.school, "Major", "Informatics Engineering"),
const Divider(height: 20),

_infoRow(Icons.cake, "Year of Entry", "2023"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          _sectionTitle("Skills"),

          //  Wrap: like Row, but automatically wraps to next line when full
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _skillChip("Flutter"),
_skillChip("Elysia.js"),
_skillChip("JavaScript"),
_skillChip("Express.js"),
_skillChip("Next.js"),
_skillChip("Vue.js"),
_skillChip("Supabase"),
_skillChip("UI/UX Design"),
_skillChip("Python"),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  CONTENT TAB 2: Portfolio
  // ============================================================
  Widget _portoPage() {
    return Container(
      key: const ValueKey("porto"),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Portfolio"),

          _portoCard(
            "Masak Yuk",
            "Flutter + Express.js + PostgreSQL",
            Icons.restaurant_menu,
          ),

          const SizedBox(height: 12),

          _portoCard(
            "EdVent",
            "Vue.js + Express.js + Supabase",
            Icons.school,
          ),

          const SizedBox(height: 12),

          _portoCard(
            "TeachLink",
            "Next.js + Elysia.js + Supabase",
            Icons.people_outline,
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  CONTENT TAB 3: Contact
  // ============================================================
  Widget _contactPage() {
    return Container(
      key: const ValueKey("contact"),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Contact me"),
          Card(
            elevation: 0,
            color: AppColors.cardBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _infoRow(Icons.email, "Email", "izzanurul215@gmail.com"),
                  const Divider(height: 20),
                  _infoRow(Icons.phone, "WhatsApp", "+62 823 1234 9525"),
                  const Divider(height: 20),
                  _infoRow(Icons.code, "GitHub", "github.com/nrlizza"),
                  const Divider(height: 20),
                  _infoRow(Icons.link, "LinkedIn", "linkedin.com/in/nurulizza"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  SMALL WIDGET HELPERS (reusable components)
  // ============================================================

  //  Widget section title
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  //  Widget info row (icon + label + value)
  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        //  Container dengan warna latar untuk icon
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.iconBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        //  Expanded agar teks mengisi sisa ruang
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 11, color: AppColors.textDark.withOpacity(0.75)),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //  Widget chip for displaying skills
  Widget _skillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.iconBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.chipBorder),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  //  Widget card untuk portfolio - navigable ke detail page
  Widget _portoCard(String title, String tech, IconData icon) {
    return GestureDetector(
      onTap: () {
        //  Navigasi ke halaman detail project dengan Hero animation
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailPage(projectName: title),
          ),
        );
      },
      child: Card(
        elevation: 0,
        color: AppColors.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          //  ListTile: widget praktis untuk baris dengan icon, judul, subtitle
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Text(
            tech,
            style: TextStyle(fontSize: 12, color: AppColors.textDark.withOpacity(0.65)),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textDark.withOpacity(0.65)),
        ),
      ),
    );
  }
}
