// Examples of new Material Design 3 features that can be added to the Instagram-like app

import 'package:flutter/material.dart';

// 1. Dynamic Color Theme Example
class ThemeExample extends StatelessWidget {
  const ThemeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practice App with Material 3',
      theme: ThemeData(
        useMaterial3: true,
        // Dynamic color based on system wallpaper (Android 12+)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        // Enhanced typography
        textTheme: Typography.material2021().black,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        textTheme: Typography.material2021().white,
      ),
      home: const InstaApp(),
    );
  }
}

// 2. SegmentedButton for Tab Navigation
class TabNavigationExample extends StatefulWidget {
  const TabNavigationExample({super.key});

  @override
  State<TabNavigationExample> createState() => _TabNavigationExampleState();
}

class _TabNavigationExampleState extends State<TabNavigationExample> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram-like App'),
        actions: [
          // Badge with notification count
          Badge(
            label: const Text('3'),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Modern tab selection with SegmentedButton
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(
                  value: 0,
                  label: Text('Stories'),
                  icon: Icon(Icons.circle_outlined),
                ),
                ButtonSegment(
                  value: 1,
                  label: Text('Posts'),
                  icon: Icon(Icons.grid_on),
                ),
                ButtonSegment(
                  value: 2,
                  label: Text('Reels'),
                  icon: Icon(Icons.play_circle_outline),
                ),
              ],
              selected: {selectedTab},
              onSelectionChanged: (Set<int> newSelection) {
                setState(() {
                  selectedTab = newSelection.first;
                });
              },
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: selectedTab,
              children: const [
                StoryTabContent(),
                PostTabContent(),
                ReelsTabContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 3. Enhanced Story Progress Indicator
class StoryProgressIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalCount;
  final Duration duration;

  const StoryProgressIndicator({
    super.key,
    required this.currentIndex,
    required this.totalCount,
    this.duration = const Duration(seconds: 5),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: List.generate(totalCount, (index) {
          return Expanded(
            child: Container(
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.5),
                color: index < currentIndex
                    ? Colors.white
                    : index == currentIndex
                        ? Colors.white.withOpacity(0.7)
                        : Colors.white.withOpacity(0.3),
              ),
              child: index == currentIndex
                  ? LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      borderRadius: BorderRadius.circular(1.5),
                    )
                  : null,
            ),
          );
        }),
      ),
    );
  }
}

// 4. Floating Action Button with Menu
class FloatingActionButtonMenu extends StatelessWidget {
  const FloatingActionButtonMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return FloatingActionButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: const Icon(Icons.add),
        );
      },
      menuChildren: [
        MenuItemButton(
          leadingIcon: const Icon(Icons.photo_camera),
          child: const Text('Take Photo'),
          onPressed: () {},
        ),
        MenuItemButton(
          leadingIcon: const Icon(Icons.video_camera_back),
          child: const Text('Record Video'),
          onPressed: () {},
        ),
        MenuItemButton(
          leadingIcon: const Icon(Icons.photo_library),
          child: const Text('Choose from Gallery'),
          onPressed: () {},
        ),
      ],
    );
  }
}

// 5. Enhanced Post Card with Material 3 styling
class PostCard extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final List<String> imageUrls;
  final String caption;
  final bool isLiked;
  final int likeCount;

  const PostCard({
    super.key,
    required this.username,
    required this.avatarUrl,
    required this.imageUrls,
    required this.caption,
    required this.isLiked,
    required this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
            ),
            title: Text(
              username,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
          // Image carousel
          SizedBox(
            height: 300,
            child: PageView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          // Action buttons
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : null,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {},
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Like count and caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$likeCount likes',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: '$username ',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: caption),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder widgets for demonstration
class InstaApp extends StatelessWidget {
  const InstaApp({super.key});
  @override
  Widget build(BuildContext context) => const TabNavigationExample();
}

class StoryTabContent extends StatelessWidget {
  const StoryTabContent({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Stories'));
}

class PostTabContent extends StatelessWidget {
  const PostTabContent({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Posts'));
}

class ReelsTabContent extends StatelessWidget {
  const ReelsTabContent({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Reels'));
}