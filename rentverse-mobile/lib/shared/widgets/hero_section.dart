class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return SizedBox(
      height: 600,
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              isMobile
                  ? 'https://res.cloudinary.com/.../hero_bg_mobile.png'
                  : 'https://res.cloudinary.com/.../hero_bg_desktop.png',
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'The right home is waiting for you',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Explore thousands of apartments...',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const SearchBoxProperty(),
                  const SizedBox(height: 40),
                  Image.network(
                    'https://res.cloudinary.com/.../sample-dashboard.png',
                    width: 900,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}