import 'package:flutter/material.dart';

void showAvatarPicker(
  BuildContext context, {
  required Function(String) onAvatarSelected,
}) {
  final maleAvatars = [
    'assets/images/avatar/male1.jpg',
    'assets/images/avatar/male2.jpg',
    'assets/images/avatar/male3.jpg',
    'assets/images/avatar/male4.jpg',
    'assets/images/avatar/male5.jpg',
    'assets/images/avatar/male6.jpg',
    'assets/images/avatar/male7.jpg',
  ];

  final femaleAvatars = [
    'assets/images/avatar/female1.jpg',
    'assets/images/avatar/female2.jpg',
    'assets/images/avatar/female3.jpg',
    'assets/images/avatar/female4.jpg',
    'assets/images/avatar/female5.jpg',
    'assets/images/avatar/female6.jpg',
  ];

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: 500,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color.fromRGBO(131, 133, 240, 1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Select Avatar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                indicatorColor: Color.fromRGBO(
                  131,
                  133,
                  240,
                  1,
                ), // Purple indicator
                tabs: [Tab(text: 'Male'), Tab(text: 'Female')],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildAvatarGrid(maleAvatars, onAvatarSelected),
                    _buildAvatarGrid(femaleAvatars, onAvatarSelected),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildAvatarGrid(
  List<String> avatarPaths,
  Function(String) onAvatarSelected,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.builder(
      itemCount: avatarPaths.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final path = avatarPaths[index];
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onAvatarSelected(path);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(4),
            child: CircleAvatar(
              backgroundImage: AssetImage(path),
              radius: 40,
              backgroundColor: Colors.white12,
            ),
          ),
        );
      },
    ),
  );
}
