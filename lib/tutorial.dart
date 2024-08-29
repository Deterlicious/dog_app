import 'package:flutter/material.dart';
import 'package:yummly_app/recipe_list.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          _buildPage(
            context,
            title: "Selamat Datang di Aplikasi Resep",
            description: "Aplikasi ini dibuat oleh Rifki Armansyah (3202216109, Kelas 4/E) untuk membantu Anda menemukan resep-resep lezat.",
          ),
          _buildPage(
            context,
            title: "Temukan Resep",
            description: "Jelajahi berbagai resep menarik dan nikmati hidangan dari seluruh dunia, hasil karya Rifki Armansyah.",
          ),
          _buildPage(
            context,
            title: "Simpan Favorit Anda",
            description: "Bookmark resep favorit Anda dan akses kapan saja. Dibuat oleh Rifki Armansyah (3202216109, Kelas 4/E).",
            isLastPage: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context,
      {required String title,
      required String description,
      bool isLastPage = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        if (isLastPage)
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const RecipeList()));
            },
            child: const Text("Get Started"),
          ),
      ],
    );
  }
}
