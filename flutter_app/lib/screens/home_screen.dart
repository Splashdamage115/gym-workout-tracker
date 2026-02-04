import 'package:flutter/material.dart';
import 'log_workout_screen.dart';
import 'workout_history_screen.dart';
import 'exercise_breakdown_screen.dart';
import 'missed_muscle_groups_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    
    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🏋️ Gym Workout Tracker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
            tooltip: 'About',
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildWorkoutTypeCard(
                  context,
                  'Push Day',
                  '💪',
                  'Chest, Shoulders, Triceps',
                  Colors.red,
                  'push',
                  0,
                ),
                _buildWorkoutTypeCard(
                  context,
                  'Pull Day',
                  '🔙',
                  'Back, Biceps',
                  Colors.blue,
                  'pull',
                  1,
                ),
                _buildWorkoutTypeCard(
                  context,
                  'Leg Day',
                  '🦵',
                  'Quads, Hamstrings, Glutes',
                  Colors.green,
                  'legs',
                  2,
                ),
                _buildMenuCard(
                  context,
                  'Workout History',
                  '📊',
                  Colors.orange,
                  () => _navigateWithAnimation(
                    context,
                    const WorkoutHistoryScreen(),
                  ),
                  3,
                ),
                _buildMenuCard(
                  context,
                  'Exercise Breakdown',
                  '📈',
                  Colors.purple,
                  () => _navigateWithAnimation(
                    context,
                    const ExerciseBreakdownScreen(),
                  ),
                  4,
                ),
                _buildMenuCard(
                  context,
                  'Missed Groups',
                  '🎯',
                  Colors.teal,
                  () => _navigateWithAnimation(
                    context,
                    const MissedMuscleGroupsScreen(),
                  ),
                  5,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showQuickStartDialog(context),
        icon: const Icon(Icons.play_arrow),
        label: const Text('Quick Start'),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  void _navigateWithAnimation(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Gym Workout Tracker'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Track your workouts with ease!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 12),
              Text('Features:'),
              SizedBox(height: 8),
              Text('• Push/Pull/Legs workout split'),
              Text('• 30 pre-categorized exercises'),
              Text('• Track sets, weight, and reps'),
              Text('• View workout history'),
              Text('• Exercise breakdown analysis'),
              Text('• Track missed muscle groups'),
              SizedBox(height: 12),
              Text(
                'Version 1.0.0',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  void _showQuickStartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quick Start'),
        content: const Text(
          'Choose your workout type:\n\n'
          '💪 Push Day - Chest, Shoulders, Triceps\n'
          '🔙 Pull Day - Back, Biceps\n'
          '🦵 Leg Day - Quads, Hamstrings, Glutes\n\n'
          'Then select exercises and log your sets!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateWithAnimation(
                context,
                const LogWorkoutScreen(workoutType: 'push'),
              );
            },
            child: const Text('Start Push Day'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateWithAnimation(
                context,
                const LogWorkoutScreen(workoutType: 'pull'),
              );
            },
            child: const Text('Start Pull Day'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateWithAnimation(
                context,
                const LogWorkoutScreen(workoutType: 'legs'),
              );
            },
            child: const Text('Start Leg Day'),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutTypeCard(
    BuildContext context,
    String title,
    String emoji,
    String subtitle,
    Color color,
    String workoutType,
    int index,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: Hero(
              tag: 'workout_$workoutType',
              child: Card(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _navigateWithAnimation(
                        context,
                        LogWorkoutScreen(workoutType: workoutType),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            color.withOpacity(0.7),
                            color.withOpacity(0.9),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              emoji,
                              style: const TextStyle(fontSize: 52),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    String emoji,
    Color color,
    VoidCallback onTap,
    int index,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: Card(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color.withOpacity(0.7),
                          color.withOpacity(0.9),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          emoji,
                          style: const TextStyle(fontSize: 52),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
