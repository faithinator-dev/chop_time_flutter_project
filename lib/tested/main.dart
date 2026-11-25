// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: UnboardingApp()));
}

class UnboardingApp extends StatefulWidget {
  const UnboardingApp({super.key});

  @override
  State<UnboardingApp> createState() => _UnboardingAppState();
}

class _UnboardingAppState extends State<UnboardingApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _titleAnimation;
  late Animation<double> _subtitleAnimation;
  late Animation<double> _buttonAnimation;

  final List<String> posters = [
    "assets/images/sourced/related_1.jpg",
    "assets/images/sourced/related_2.jpg",
    "assets/images/sourced/related_3.jpg",
    "assets/images/sourced/related_1.jpg",
    "assets/images/sourced/related_2.jpg",
    "assets/images/sourced/hero.jpg",
    "assets/images/sourced/related_1.jpg",
    "assets/images/sourced/related_2.jpg",
    "assets/images/sourced/related_3.jpg",
    "assets/images/sourced/related_1.jpg",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _titleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.easeOut),
      ),
    );

    _subtitleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
      ),
    );

    _buttonAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      body: Stack(
        children: [
          // 1. MOVING POSTER WALL - 3 Columns
          Row(
            children: [
              Expanded(
                child: _PosterColumn(images: posters, reverse: false, speed: 1),
              ),
              Expanded(
                child: _PosterColumn(
                  images: posters.reversed.toList(),
                  reverse: true,
                  speed: 1,
                ),
              ),
              Expanded(
                child: _PosterColumn(images: posters, reverse: false, speed: 1),
              ),
            ],
          ),

          // 2. DARK GRADIENT OVERLAY - So text is readable
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: .2),
                  const Color(0xFF0A0A1A).withValues(alpha: 0.85),
                  const Color(0xFF0A0A1A),
                ],
                stops: const [0.0, 0.4, 0.75, 1.0],
              ),
            ),
          ),

          // 3. TEXT + BUTTON - Staggered Fade Up
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  AnimatedBuilder(
                    animation: _titleAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _titleAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - _titleAnimation.value)),
                          child: child,
                        ),
                      );
                    },
                    child: const Text(
                      'Watch Every Movie',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  AnimatedBuilder(
                    animation: _subtitleAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _subtitleAnimation.value,
                        child: Transform.translate(
                          offset: Offset(
                            0,
                            20 * (1 - _subtitleAnimation.value),
                          ),
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      'Stream, download and book anywhere you are',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Button
                  AnimatedBuilder(
                    animation: _buttonAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _buttonAnimation.value,
                        child: Transform.scale(
                          scale: 0.8 + (0.2 * _buttonAnimation.value),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEC4899), Color(0xFF06B6D4)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFEC4899,
                            ).withValues(alpha: 0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, _, _) => const HomeScreen(),
                                transitionsBuilder: (_, anim, _, child) {
                                  return FadeTransition(
                                    opacity: anim,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0, 0.3),
                                        end: Offset.zero,
                                      ).animate(anim),
                                      child: child,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          child: const Center(
                            child: Text(
                              'Enter Now',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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

// THE AUTO-SCROLLING COLUMN
class _PosterColumn extends StatefulWidget {
  final List<String> images;
  final bool reverse;
  final double speed;

  const _PosterColumn({
    required this.images,
    required this.reverse,
    required this.speed,
  });

  @override
  State<_PosterColumn> createState() => _PosterColumnState();
}

class _PosterColumnState extends State<_PosterColumn> {
  late ScrollController _scrollController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Auto scroll forever
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (!_scrollController.hasClients) return;
      double maxScroll = _scrollController.position.maxScrollExtent;
      double current = _scrollController.offset;
      double next = current + (widget.reverse ? -0.8 : 0.8);

      if (next >= maxScroll) {
        _scrollController.jumpTo(0);
      } else if (next <= 0) {
        _scrollController.jumpTo(maxScroll);
      } else {
        _scrollController.jumpTo(next);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Repeat list 3 times so it never looks empty
    final repeated = [...widget.images, ...widget.images, ...widget.images];

    return ListView.builder(
      controller: _scrollController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: repeated.length,
      itemBuilder: (context, index) {
        return Container(
          height: 180,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: DecorationImage(
              image: NetworkImage(repeated[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

// DUMMY HOME SCREEN - For the transition
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text('Welcome to Home', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
