import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'recipe.dart';
import 'dart:convert';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetail({super.key, required this.recipe});

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  List<Map<String, dynamic>> reviews = [];

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  _loadReviews() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    List<String> reviewStrings = prefs.getStringList('reviews_${widget.recipe.id}') ?? [];
    reviews = reviewStrings
        .map((e) => jsonDecode(e) as Map<String, dynamic>) // Decode JSON string to Map
        .toList();
  });
}

  _saveReview(String reviewText, double rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final newReview = {'review': reviewText, 'rating': rating};

    setState(() {
      reviews.add(newReview);
    });

    await prefs.setStringList(
        'reviews_${widget.recipe.id}', reviews.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.recipe.imageUrl,
              child: Image.network(widget.recipe.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(widget.recipe.instructions),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _showAddReviewDialog(context);
                    },
                    child: const Text("Add Review"),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Reviews',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ..._buildReviews(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildReviews() {
    if (reviews.isEmpty) {
      return [const Text('No reviews yet!')];
    }

    return reviews
        .map((review) => ListTile(
              title: Text(review['review']),
              subtitle: RatingBarIndicator(
                rating: review['rating'],
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
            ))
        .toList();
  }

  void _showAddReviewDialog(BuildContext context) {
    final TextEditingController reviewController = TextEditingController();
    double rating = 3.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: reviewController,
                decoration: const InputDecoration(labelText: 'Your Review'),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (newRating) {
                  rating = newRating;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (reviewController.text.isNotEmpty) {
                  _saveReview(reviewController.text, rating);
                }
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
