import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                      prefixIcon: Icon(Icons.search, color: Colors.white54, size: 20),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.tune, color: Colors.white),
            ],
          ),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.purple,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            tabs: [
              Tab(text: 'Top'),
              Tab(text: 'Live'),
              Tab(text: 'Creators'),
              Tab(text: 'Videos'),
              Tab(text: 'Sounds'),
              Tab(text: 'Hashtags'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _TopTabView(),
            const Center(
              child: Text('Live', style: TextStyle(color: Colors.white)),
            ),
            const Center(
              child: Text('Creators', style: TextStyle(color: Colors.white)),
            ),
            const Center(
              child: Text('Videos', style: TextStyle(color: Colors.white)),
            ),
            const Center(
              child: Text('Sounds', style: TextStyle(color: Colors.white)),
            ),
            const Center(
              child: Text('Hashtags', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader('Video'),
        const SizedBox(height: 12),
        _buildVideoGrid(),
        const SizedBox(height: 24),
        _buildAdvertisement(),
        const SizedBox(height: 24),
        _buildSectionHeader('Users'),
        const SizedBox(height: 12),
        _buildUserList(),
        const SizedBox(height: 24),
        _buildSectionHeader('Sounds'),
        const SizedBox(height: 12),
        _buildSoundList(),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.purpleAccent,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildVideoGrid() {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1517841905240-472988babdf9'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Stack(
              children: [
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Row(
                    children: [
                      Icon(Icons.play_arrow, color: Colors.white, size: 14),
                      Text(
                        '1k2',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAdvertisement() {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'CENTER ADVERTISEMENT',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return Column(
      children: [
        _buildUserItem('Lisa', '@lisa', '3.4M Followers', true),
        const SizedBox(height: 16),
        _buildUserItem('Taylor swift', '@taylor_swift', '3.4M Followers', false),
        const SizedBox(height: 16),
        _buildUserItem('Milan', '@milan', '3.4M Followers', true),
      ],
    );
  }

  Widget _buildUserItem(String name, String username, String followers, bool isFollowing) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text('$username • $followers', style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: isFollowing ? Colors.white10 : Colors.purple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: Text(isFollowing ? 'Follow' : 'Unfollow'),
        ),
      ],
    );
  }

  Widget _buildSoundList() {
    return Column(
      children: [
        _buildSoundItem('Save your tears', '@lisa', '05:00', '1k4'),
        const SizedBox(height: 16),
        _buildSoundItem('Money', '@lisa_blackpink', '05:00', '1k4'),
        const SizedBox(height: 16),
        _buildSoundItem('Fall in love', '@lisa_blackpink', '05:00', '1k4'),
      ],
    );
  }

  Widget _buildSoundItem(String title, String author, String duration, String count) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1470225620780-dba8ba36b745'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(author, style: const TextStyle(color: Colors.white54, fontSize: 12)),
              Text(duration, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.file_download_outlined, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                count,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
