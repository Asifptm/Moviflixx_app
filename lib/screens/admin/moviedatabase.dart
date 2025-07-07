import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviefliix/provider/movie_provider.dart';
import 'package:moviefliix/utils/confirm_dialog.dart';
import 'package:moviefliix/utils/error/no_data.dart';
import 'package:moviefliix/utils/error/no_internet.dart';
import 'package:moviefliix/widgets/detalis.dart';
import 'package:moviefliix/widgets/ui/custom_serachinput.dart';
import 'package:moviefliix/widgets/ui/moviesearch_card.dart';
import '../../services/movie_service.dart';

class MovieDatabaseScreen extends ConsumerStatefulWidget {
  const MovieDatabaseScreen({super.key});

  @override
  ConsumerState<MovieDatabaseScreen> createState() =>
      _MovieDatabaseScreenState();
}

class _MovieDatabaseScreenState extends ConsumerState<MovieDatabaseScreen> {
  final Set<String> selectedMovieIds = {};

  void toggleSelection(String id) {
    setState(() {
      selectedMovieIds.contains(id)
          ? selectedMovieIds.remove(id)
          : selectedMovieIds.add(id);
    });
  }

  Future<void> deleteSelected() async {
    if (selectedMovieIds.isEmpty) return;

    final confirmed = await showConfirmDialog(
      context: context,
      title: "Delete Movies",
      content: "Are you sure you want to delete the selected movies?",
    );

    if (confirmed != true) return;

    try {
      // Optional: show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      for (final id in selectedMovieIds) {
        await MovieService.deleteMovie(id);
      }

      Navigator.of(context).pop(); // Close the loading dialog
      ref.invalidate(movieStreamProvider);
      setState(() => selectedMovieIds.clear());

      // Optional: show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selected movies deleted successfully.'),
          backgroundColor: Colors.deepPurple,
        ),
      );
    } catch (e) {
      Navigator.of(context).pop(); // Close the loading dialog if error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete movies: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieAsync = ref.watch(movieStreamProvider);
    final searchQuery = ref.watch(movieSearchQueryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        foregroundColor: Colors.white,
        title:
            selectedMovieIds.isEmpty
                ? const Text("Movie Database")
                : Text("${selectedMovieIds.length} selected"),
        actions: [
          if (selectedMovieIds.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: deleteSelected,
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(movieStreamProvider);
          await Future.delayed(const Duration(milliseconds: 300));
        },
        color: Colors.deepPurpleAccent,
        backgroundColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchBar(
                    hintText: "Search movies...",
                    onChanged: (query) {
                      ref.read(movieSearchQueryProvider.notifier).state = query;
                    },
                  ),
                  const SizedBox(height: 8),
                  movieAsync.when(
                    data: (movies) {
                      final filtered =
                          searchQuery.trim().isEmpty
                              ? movies
                              : movies
                                  .where(
                                    (m) => m.title.toLowerCase().contains(
                                      searchQuery.toLowerCase(),
                                    ),
                                  )
                                  .toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.deepPurple,
                                  Colors.purpleAccent,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.deepPurple.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              "${filtered.length} ${filtered.length == 1 ? "movie" : "movies"} found",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            thickness: 1,
                            color: Colors.white12,
                            indent: 4,
                            endIndent: 4,
                          ),
                        ],
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: movieAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (err, stack) => const NoInternetConnection(
                      icon: FeatherIcons.alertTriangle,
                      title: "Something went wrong",
                      caption: "An error occurred while loading movies.",
                    ),
                data: (movies) {
                  final filtered =
                      searchQuery.trim().isEmpty
                          ? movies
                          : movies
                              .where(
                                (m) => m.title.toLowerCase().contains(
                                  searchQuery.toLowerCase(),
                                ),
                              )
                              .toList();

                  if (filtered.isEmpty) {
                    return const NoMoviesFound(
                      icon: FeatherIcons.film,
                      title: "No Movies Found",
                      caption: "There are no matching movies.",
                    );
                  }

                  return ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    // Inside itemBuilder:
                    itemBuilder: (context, index) {
                      final movie = filtered[index];
                      final isSelected = selectedMovieIds.contains(movie.title);

                      return MovieCard(
                        movie: movie,
                        isSelected: isSelected,
                        onTap: () {
                          if (selectedMovieIds.isNotEmpty) {
                            toggleSelection(movie.title);
                          } else {
                            // Navigate to detail screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MovieDetailScreen(movie: movie),
                              ),
                            );
                          }
                        },
                        onLongPress: () => toggleSelection(movie.title),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
