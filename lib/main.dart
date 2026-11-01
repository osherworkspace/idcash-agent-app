import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const navy = Color(0xFF073B67);
const cyan = Color(0xFF76BED2);
const introPreference = 'idcash_agent_intro_completed_v1';

void main() => runApp(const IdcashAgentApp());

class IdcashAgentApp extends StatelessWidget {
  const IdcashAgentApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ID-CASH Agent',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: navy),
      useMaterial3: true,
    ),
    home: const AgentFirstLaunchGate(),
  );
}

class AgentFirstLaunchGate extends StatefulWidget {
  const AgentFirstLaunchGate({super.key});

  @override
  State<AgentFirstLaunchGate> createState() => _AgentFirstLaunchGateState();
}

class _AgentFirstLaunchGateState extends State<AgentFirstLaunchGate> {
  bool? complete;
  @override
  void initState() {
    super.initState();
    _load();
  }
  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) setState(() => complete = prefs.getBool(introPreference) ?? false);
  }
  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(introPreference, true);
    if (mounted) setState(() => complete = true);
  }
  @override
  Widget build(BuildContext context) {
    if (complete == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return complete! ? const AgentWelcomeScreen() : AgentIntro(onFinish: _finish);
  }
}

class AgentIntro extends StatefulWidget {
  const AgentIntro({super.key, required this.onFinish});
  final Future<void> Function() onFinish;
  @override
  State<AgentIntro> createState() => _AgentIntroState();
}

class _AgentIntroState extends State<AgentIntro> {
  final PageController controller = PageController();
  int index = 0;
  static const slides = [
    'assets/images/onboarding_agent.png',
    'assets/images/onboarding_face.png',
    'assets/images/onboarding_idc.png',
  ];

  @override
  void dispose() { controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, top: 8),
            child: TextButton(onPressed: widget.onFinish, child: const Text('Skip')),
          ),
        ),
        Expanded(child: PageView.builder(
          controller: controller,
          itemCount: slides.length,
          onPageChanged: (value) => setState(() => index = value),
          itemBuilder: (context, slide) => Semantics(
            label: 'ID-CASH Agent introduction slide ${slide + 1} of ${slides.length}',
            child: Image.asset(
              slides[slide],
              fit: BoxFit.contain,
              width: double.infinity,
              errorBuilder: (_, __, ___) =>
                Center(child: Text('ID-CASH Agent introduction ${slide + 1}')),
            ),
          ),
        )),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(slides.length, (i) => AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: 8,
            width: i == index ? 24 : 8,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: i == index ? navy : cyan,
              borderRadius: BorderRadius.circular(8),
            ),
          ))),
        Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(width: double.infinity, child: FilledButton(
            onPressed: index == slides.length - 1
              ? widget.onFinish
              : () => controller.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut),
            child: Text(index == slides.length - 1 ? 'Get started' : 'Next'),
          )),
        ),
      ]),
    ),
  );
}

class AgentWelcomeScreen extends StatelessWidget {
  const AgentWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/app_icon.png', height: 120, width: 120, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.storefront_outlined, color: navy, size: 88)),
          const SizedBox(height: 22),
          const Text('ID-CASH Agent', style: TextStyle(
            color: navy, fontSize: 34, fontWeight: FontWeight.w800)),
          const SizedBox(height: 14),
          const Text('YOUR IDENTITY IS YOUR CASH', textAlign: TextAlign.center),
          const SizedBox(height: 32),
          const Text('Serve customers with secure cardless withdrawals and balance inquiries.',
            textAlign: TextAlign.center),
          const SizedBox(height: 28),
          const FilledButton(
            onPressed: null,
            child: Text('Agent sign-in — next integration step'),
          ),
        ],
      ),
    )),
  );
}
