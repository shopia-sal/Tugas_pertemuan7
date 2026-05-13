import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/user_session.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _prosesLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF16213e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Konfirmasi Logout',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Apakah kamu yakin ingin keluar?',
          style: GoogleFonts.poppins(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Batal',
              style: GoogleFonts.poppins(color: Colors.white54),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              AuthService().logout();
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFe94560),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Logout',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final session = UserSession();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WBI Store Profile",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFe94560),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _prosesLogout(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e), 
              Color(0xFF16213e), 
              Color(0xFF0f3460), 
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 8),
              CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xFFe94560),
                child: Text(
                  '${(session.firstName ?? '?')[0]}${(session.lastName ?? '?')[0]}'
                      .toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                session.namaLengkap,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '@${session.username ?? '-'}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFFe94560),
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Informasi Akun',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFe94560),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              _buildCard(
                icon: Icons.badge,
                label: 'ID',
                nilai: '#${session.id?.toString() ?? '-'}',
              ),
              _buildCard(
                icon: Icons.email,
                label: 'Email',
                nilai: session.email ?? '-',
              ),
              _buildCard(
                icon: Icons.person,
                label: 'Gender',
                nilai: session.gender ?? '-',
              ),
              _buildCard(
                icon: Icons.lock,
                label: 'Access Token',
                nilai: session.token != null
                    ? '${session.token!.substring(0, 20)}...'
                    : '-',
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Status Sesi',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFe94560),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              _buildCard(
                icon: Icons.verified_user,
                label: 'Status Login',
                nilai: '✅ Aktif',
              ),
              _buildCard(
                icon: Icons.storage,
                label: 'Sumber Data',
                nilai: 'dummyjson.com/auth/login',
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildCard({
    required IconData icon,
    required String label,
    required String nilai,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.07),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white12),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFFe94560), 
        ),
        title: Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white54, 
            fontSize: 12,
          ),
        ),
        subtitle: Text(
          nilai,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
