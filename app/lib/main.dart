import 'package:flutter/material.dart';
import 'music_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat(reverse: true);

    _animation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 1),
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1, end: 0),
          weight: 1,
        ),
      ],
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.8,
                colors: [
                  Color.lerp(Colors.red, Colors.white, _animation.value)!,
                  Color.lerp(Colors.white, Colors.lightBlue, _animation.value)!,
                  Color.lerp(
                      Colors.deepPurpleAccent, Colors.white, _animation.value)!,
                ],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Soundscape',
                        style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isPressed = true;
                          });
                          Future.delayed(const Duration(milliseconds: 200), () {
                            setState(() {
                              _isPressed = false;
                            });
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (MusicScreen()),
                              ));
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: _isPressed
                              ? MediaQuery.of(context).size.width * 0.48
                              : MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(200, 255, 255, 255),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/logo.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Real-time, immersive, generative musical environments.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 100),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isPressed = true;
                          });
                          Future.delayed(const Duration(milliseconds: 200), () {
                            setState(() {
                              _isPressed = false;
                            });
                          });
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: _isPressed
                              ? MediaQuery.of(context).size.width * 0.65
                              : MediaQuery.of(context).size.width * 0.6,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF1DB954),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Link to Spotify (optional)',
                              style: TextStyle(
                                fontFamily: 'ProductSans',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 7, 7, 7),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
