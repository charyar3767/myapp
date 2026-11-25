import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
//  ÖZÜŇE LAÝYK ÜÝTGET
// ============================================================
const String kGreeting = 'Salam, men';
const String kName = 'Aty Familiýaňyz';
const String kRole = 'Mobil programma we web döredijisi';
const String kStatus = 'Täze taslamalar üçin elýeterli';

const String kBio =
    'Sadaja we aňsat ulanylýan programmalary, saýtlary ýasaýaryn. '
    'Flutter, PHP we MySQL bilen işleýärin. Täze taslamaňyz bar bolsa, '
    'ýazyň, bilelikde çözüw tapalyň.';

const String kEmail = 'siz@mail.com';
const String kTelegram = '@telegram_adyňyz';
const String kPhone = '+993 6X XXXXXX';

const List<String> kSkills = [
  'Flutter',
  'Dart',
  'PHP',
  'MySQL',
  'HTML we CSS',
  'UI dizaýn',
];

const List<Project> kProjects = [
  Project(
    title: 'Söhbetdeşlik programmasy',
    desc: 'Real wagtda habar alyşmak, topar çatlary we suratlar.',
    tech: 'Flutter, PHP, MySQL',
  ),
  Project(
    title: 'Internet kitaphana',
    desc: 'Kitaplary gözlemek, okamak we halanlaryňa goşmak.',
    tech: 'PHP, MySQL',
  ),
  Project(
    title: 'Portal saýty',
    desc: 'Habarlar, bildirişler we ulanyjy profilleri bir ýerde.',
    tech: 'HTML, CSS, JavaScript',
  ),
];
// ============================================================

class Project {
  final String title;
  final String desc;
  final String tech;
  const Project({required this.title, required this.desc, required this.tech});
}

class Pal {
  static const bg = Color(0xFF3A1016);
  static const sand = Color(0xFFE8D3A2);
  static const text = Color(0xFFF6EBD3);
  static const soft = Color(0xB3F6EBD3);
  static const line = Color(0x40E8D3A2);
  static const accent = Color(0xFF5CC6B8);
}

const String kSerif = 'serif';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Pal.bg,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Pal.bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Pal.sand,
          brightness: Brightness.dark,
          surface: Pal.bg,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _emblem;
  late final Animation<double> _heroText;
  late final Animation<double> _body;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..forward();
    _emblem = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.75, curve: Curves.easeOutCubic),
    );
    _heroText = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.45, 0.85, curve: Curves.easeOut),
    );
    _body = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 52, bottom: 18),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: kSerif,
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: Pal.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _hero(),
                    FadeTransition(
                      opacity: _body,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _title('Hakynda'),
                          const Text(
                            kBio,
                            style: TextStyle(
                              fontSize: 16.5,
                              height: 1.65,
                              color: Pal.soft,
                            ),
                          ),
                          _title('Başarnyklarym'),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              for (final s in kSkills) _SkillChip(label: s),
                            ],
                          ),
                          _title('Işlerim'),
                          for (final p in kProjects) _ProjectRow(project: p),
                          _title('Habarlaşmak'),
                          const _ContactRow(label: 'Email', value: kEmail),
                          const _ContactRow(label: 'Telegram', value: kTelegram),
                          const _ContactRow(label: 'Telefon', value: kPhone),
                          const SizedBox(height: 36),
                          const Text(
                            'Bellik: setire basyp göçürip bilersiň.',
                            style: TextStyle(fontSize: 13, color: Pal.soft),
                          ),
                        ],
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
  }

  Widget _hero() {
    return SizedBox(
      height: 420,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -64,
            top: 8,
            width: 280,
            height: 280,
            child: AnimatedBuilder(
              animation: _emblem,
              builder: (context, _) => CustomPaint(
                painter: GulPainter(_emblem.value),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FadeTransition(
              opacity: _heroText,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Pal.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Flexible(
                        child: Text(
                          kStatus,
                          style: TextStyle(fontSize: 14, color: Pal.soft),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    kGreeting,
                    style: TextStyle(
                      fontFamily: kSerif,
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      color: Pal.sand,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    kName,
                    style: TextStyle(
                      fontFamily: kSerif,
                      fontSize: 46,
                      height: 1.05,
                      fontWeight: FontWeight.w700,
                      color: Pal.text,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    kRole,
                    style: TextStyle(fontSize: 17, color: Pal.soft),
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

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        border: Border.all(color: Pal.line),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14.5, color: Pal.text),
      ),
    );
  }
}

class _ProjectRow extends StatelessWidget {
  final Project project;
  const _ProjectRow({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 26),
      padding: const EdgeInsets.only(left: 16),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Pal.sand, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title,
            style: const TextStyle(
              fontFamily: kSerif,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Pal.text,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            project.desc,
            style: const TextStyle(fontSize: 15, height: 1.5, color: Pal.soft),
          ),
          const SizedBox(height: 8),
          Text(
            project.tech,
            style: const TextStyle(fontSize: 13.5, color: Pal.accent),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final String label;
  final String value;
  const _ContactRow({required this.label, required this.value});

  void _copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: value));
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Pal.sand,
        duration: const Duration(seconds: 2),
        content: Text(
          '$label göçürildi',
          style: const TextStyle(color: Pal.bg, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _copy(context),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Pal.line)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(fontSize: 13.5, color: Pal.soft),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Pal.text,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.copy_rounded, size: 19, color: Pal.sand),
            ],
          ),
        ),
      ),
    );
  }
}

/// Türkmen halysyndaky "gül" nagşyndan ylham alan, ýuwaş-ýuwaşdan çekilýän nyşan.
class GulPainter extends CustomPainter {
  final double t;
  GulPainter(this.t);

  static const int _layers = 5;

  double _p(int i) => (t * _layers - i).clamp(0.0, 1.0).toDouble();

  void _poly(Canvas canvas, Offset c, double radius, int sides, double rot,
      Paint paint) {
    final path = Path();
    for (var k = 0; k < sides; k++) {
      final a = rot + 2 * math.pi * k / sides;
      final pt = Offset(
        c.dx + radius * math.cos(a),
        c.dy + radius * math.sin(a),
      );
      if (k == 0) {
        path.moveTo(pt.dx, pt.dy);
      } else {
        path.lineTo(pt.dx, pt.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  Paint _line(double a, [double w = 1.6]) => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = w
    ..strokeJoin = StrokeJoin.round
    ..color = Pal.sand.withValues(alpha: a);

  Paint _fill(double a) => Paint()
    ..style = PaintingStyle.fill
    ..color = Pal.sand.withValues(alpha: a);

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2;

    // 0: daşky segizburç we depelerindäki nokatlar
    final p0 = _p(0);
    if (p0 > 0) {
      _poly(canvas, c, r * p0, 8, -math.pi / 2, _line(0.9 * p0, 2.2));
      for (var k = 0; k < 8; k++) {
        final a = -math.pi / 2 + 2 * math.pi * k / 8;
        canvas.drawCircle(
          Offset(c.dx + r * p0 * math.cos(a), c.dy + r * p0 * math.sin(a)),
          4.5 * p0,
          _fill(0.95 * p0),
        );
      }
    }

    // 1: sekiz ujly ýyldyz (iki inedördül)
    final p1 = _p(1);
    if (p1 > 0) {
      _poly(canvas, c, r * 0.82 * p1, 4, -math.pi / 2, _line(0.75 * p1));
      _poly(canvas, c, r * 0.82 * p1, 4, -math.pi / 4, _line(0.75 * p1));
    }

    // 2: orta segizburç
    final p2 = _p(2);
    if (p2 > 0) {
      final rot = -math.pi / 2 + math.pi / 8;
      _poly(canvas, c, r * 0.56 * p2, 8, rot, _fill(0.14 * p2));
      _poly(canvas, c, r * 0.56 * p2, 8, rot, _line(0.85 * p2, 1.8));
    }

    // 3: içki kiçi ýyldyz
    final p3 = _p(3);
    if (p3 > 0) {
      _poly(canvas, c, r * 0.36 * p3, 4, -math.pi / 2, _line(0.8 * p3));
      _poly(canvas, c, r * 0.36 * p3, 4, -math.pi / 4, _line(0.8 * p3));
    }

    // 4: merkezdäki romb
    final p4 = _p(4);
    if (p4 > 0) {
      _poly(canvas, c, r * 0.14 * p4, 4, -math.pi / 2, _fill(0.95 * p4));
    }
  }

  @override
  bool shouldRepaint(covariant GulPainter old) => old.t != t;
}
