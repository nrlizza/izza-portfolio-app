import 'package:flutter/material.dart';

class NewForm extends StatefulWidget {
  const NewForm({super.key});

  @override
  State<NewForm> createState() => _NewFormState();
}

class _NewFormState extends State<NewForm> with TickerProviderStateMixin {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  // Animation controllers
  late AnimationController _fadeInController;
  late AnimationController _slideController;
  late AnimationController _scaleButtonController;

  // State for animations
  bool _isSubmitted = false;
  bool _isButtonPressed = false;

  // Custom color palette (consistent with profil_page.dart)
  static const Color _primary = Color(0xFF73555F);
  static const Color _primaryLight = Color(0xFFA17D88);
  static const Color _primaryDark = Color(0xFF5D434B);
  static const Color _cardBg = Color(0xFFF8F5F6);
  static const Color _hintDark = Color(0xFF6B7280);

  @override
  void initState() {
    super.initState();
    // Animation untuk fade in form fields
    _fadeInController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    // Animation untuk slide form fields
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    // Animation untuk scale submit button
    _scaleButtonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Start animations
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _fadeInController.forward();
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _fadeInController.dispose();
    _slideController.dispose();
    _scaleButtonController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isButtonPressed = true;
      });

      // Trigger scale animation
      _scaleButtonController.forward().then((_) {
        _scaleButtonController.reverse();
      });

      // Simulate a short delay then show success
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          _isSubmitted = true;
        });
      });

      // After showing success, navigate back
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Data saved successfully!"),
              backgroundColor: _primary,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Data"),
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Header section with Hero avatar ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_primaryDark, _primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  // Hero animation: avatar "flies" from ProfilPage to here
                  Hero(
                    tag: 'profile-avatar',
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      backgroundImage: const AssetImage("assets/izza.jpeg"),
                      child: null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Fill the form below",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- Form section ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name field with SlideTransition
                    _buildAnimatedField(
                      delay: 0,
                      label: "Full Name",
                      controller: _nameController,
                      hint: "Enter full name",
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name cannot be empty';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Email field with SlideTransition
                    _buildAnimatedField(
                      delay: 100,
                      label: "Email",
                      controller: _emailController,
                      hint: "example@email.com",
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Phone field with SlideTransition
                    _buildAnimatedField(
                      delay: 200,
                      label: "Phone Number",
                      controller: _phoneController,
                      hint: "+62 xxx xxxx xxxx",
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number cannot be empty';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Message field with SlideTransition
                    _buildAnimatedField(
                      delay: 300,
                      label: "Message",
                      controller: _messageController,
                      hint: "Write your message here...",
                      icon: Icons.message_outlined,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Message cannot be empty';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 28),

                    // --- Submit button with ScaleTransition + AnimatedContainer ---
                    Center(
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 1.0, end: 1.08).animate(
                          CurvedAnimation(parent: _scaleButtonController, curve: Curves.easeInOut),
                        ),
                        child: GestureDetector(
                          onTap: _isSubmitted ? null : _submitForm,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                            width: _isButtonPressed ? 60 : double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: _isSubmitted
                                  ? Colors.green
                                  : _primary,
                              borderRadius: BorderRadius.circular(
                                _isButtonPressed ? 30 : 14,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: _primary.withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: _isSubmitted
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 28,
                                    )
                                  : _isButtonPressed
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : const Text(
                                          "Send",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // --- Success message with AnimatedOpacity ---
                    AnimatedOpacity(
                      opacity: _isSubmitted ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: Colors.green.shade600, size: 20),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "Data sent successfully! Returning to main page...",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper: Animated form field dengan SlideTransition + FadeTransition ---
  Widget _buildAnimatedField({
    required int delay,
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required String? Function(String?) validator,
  }) {
    // Delay untuk staggered animation
    final delayFraction = delay / 400.0;
    
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.3, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: Interval(
            delayFraction.clamp(0.0, 1.0),
            (delayFraction + 0.4).clamp(0.0, 1.0),
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _fadeInController,
            curve: Interval(
              delayFraction.clamp(0.0, 1.0),
              (delayFraction + 0.4).clamp(0.0, 1.0),
              curve: Curves.easeOut,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(label),
            const SizedBox(height: 6),
            TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              decoration: _inputDecoration(
                hint: hint,
                icon: icon,
              ),
              validator: validator,
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper: field label ---
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1E293B),
      ),
    );
  }

  // --- Helper: consistent input decoration ---
  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: _hintDark, fontSize: 14),
      prefixIcon: Icon(icon, color: _primaryLight, size: 20),
      filled: true,
      fillColor: _cardBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }
}
