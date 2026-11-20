import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const CvApp());


class Donnees {
  static const identifiant = 'asnath';
  static const motDePasse = '1234';

  static const nom = 'Asnath Kanyabire';
  static const titre = 'Étudiante en Informatique et Gestion';
  static const photo = 'assets/images/asnath.jpg';

  static int get age {
    final n = DateTime.now();
    var a = n.year - 2005;
    if (n.month < 8 || (n.month == 8 && n.day < 15)) a--;
    return a;
  }

  static const infos = <List<dynamic>>[
    [Icons.cake_outlined, 'Date de naissance', '15 août 2005'],
    [Icons.place_outlined, 'Lieu de naissance', 'Bunagana'],
    [Icons.flag_outlined, 'Nationalité', 'Congolaise'],
    [Icons.favorite_border, 'État civil', 'Célibataire'],
  ];

  static const formation = [
    ['L3 — Informatique et gestion', 'ISIG Goma'],
  ];

  static const experiences = [
    ['Stage académique', 'REGIDESO'],
  ];

  static const competences = [
    'Informatique',
    'Word',
    'Bases de données',
    'Programmation',
  ];

  static const langues = ['Français', 'Anglais', 'Kiswahili'];
  static const qualites = ['Patiente', 'Curieuse', 'Sérieuse', 'Persévérante'];

  static const interets = <List<dynamic>>[
    [Icons.devices_rounded, 'Technologie'],
    [Icons.menu_book_rounded, 'Lecture'],
    [Icons.lightbulb_outline_rounded, 'Apprentissage'],
  ];

  static const famille = <Membre>[
    Membre('Kanyabire', 'Père', 'assets/images/pere.jpg', parent: true),
    Membre('Françoise', 'Mère', 'assets/images/mere.jpg', parent: true),
    Membre('Eugide', 'Frère', 'assets/images/eugide.jpg'),
    Membre('Danielle', 'Frère', 'assets/images/danielle.jpg'),
    Membre('Aline', 'Sœur', 'assets/images/aline.jpg'),
    Membre('Denise', 'Sœur', 'assets/images/denise.jpg'),
    Membre('Zawadi', 'Sœur', 'assets/images/zawadi.jpg'),
  ];
  static const rangFamille = '6e';

  static const telephone = '+243 976 217 745';
  static const email = 'asnathkanyabire@gmail.com';
  static const adresse = 'Goma, Nord-Kivu, RD Congo';
}

class Membre {
  final String nom;
  final String lien;
  final String photo;
  final bool parent;
  const Membre(this.nom, this.lien, this.photo, {this.parent = false});
}


const kBg = Color(0xFFFAF8F5);
const kSurface = Color(0xFFFFFFFF);
const kInk = Color(0xFF1A1917);
const kInk2 = Color(0xFF5C5852);
const kInk3 = Color(0xFF918B82);
const kHair = Color(0xFFEDE9E3);
const kAccent = Color(0xFFC96442);
const kAccentSoft = Color(0xFFFAEDE6);
const kDanger = Color(0xFFC94A2E);
const kDangerSoft = Color(0xFFFDEEEC);

TextStyle tx(
  double size, {
  FontWeight w = FontWeight.w400,
  Color c = kInk,
  double? h,
  double? ls,
}) =>
    GoogleFonts.manrope(
      fontSize: size,
      fontWeight: w,
      color: c,
      height: h,
      letterSpacing: ls,
    );

// ============================================================================
// APP
// ============================================================================
class CvApp extends StatelessWidget {
  const CvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Asnath',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kAccent,
          brightness: Brightness.light,
        ).copyWith(primary: kAccent, surface: kSurface, onSurface: kInk),
        scaffoldBackgroundColor: kBg,
        splashFactory: InkSparkle.splashFactory,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kAccent,
          selectionColor: kAccent.withOpacity(0.18),
          selectionHandleColor: kAccent,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ============================================================================
// WIDGETS PARTAGÉS
// ============================================================================
class Photo extends StatelessWidget {
  final String asset;
  final String nom;
  final double w;
  final double h;
  final double radius;
  final BoxFit fit;
  const Photo({
    super.key,
    required this.asset,
    required this.nom,
    this.w = 56,
    this.h = 56,
    this.radius = 16,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final initiale = nom.isNotEmpty ? nom[0].toUpperCase() : '?';
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        asset,
        width: w,
        height: h,
        fit: fit,
        errorBuilder: (_, __, ___) => Container(
          width: w,
          height: h,
          color: kAccentSoft,
          alignment: Alignment.center,
          child: Text(initiale, style: tx(w * 0.4, w: FontWeight.w700, c: kAccent)),
        ),
      ),
    );
  }
}

class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
        child: Text(text.toUpperCase(),
            style: tx(11, w: FontWeight.w700, c: kInk3, ls: 1.2)),
      );
}

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  const AppCard({super.key, required this.child, this.padding, this.onTap});

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
    return Material(
      color: kSurface,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: onTap == null
          ? content
          : InkWell(onTap: onTap, child: content),
    );
  }
}

/// Apparition en fondu + léger glissement — animée à chaque build initial.
class FadeSlide extends StatelessWidget {
  final Widget child;
  final int delay;
  const FadeSlide({super.key, required this.child, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 380 + delay * 60),
      curve: Curves.easeOutCubic,
      builder: (_, v, c) => Opacity(
        opacity: v.clamp(0.0, 1.0),
        child: Transform.translate(offset: Offset(0, 14 * (1 - v)), child: c),
      ),
      child: child,
    );
  }
}

void showToast(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(msg, style: tx(13, w: FontWeight.w500, c: Colors.white)),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 96),
      backgroundColor: kInk,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
}

// ============================================================================
// LOGIN
// ============================================================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idCtrl = TextEditingController();
  final _mdpCtrl = TextEditingController();
  bool _hide = true;
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _error = null;
      _loading = true;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    if (_idCtrl.text.trim().toLowerCase() == Donnees.identifiant &&
        _mdpCtrl.text == Donnees.motDePasse) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 450),
          pageBuilder: (_, __, ___) => const MainShell(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
    } else {
      setState(() {
        _loading = false;
        _error = 'Identifiant ou mot de passe incorrect.';
      });
    }
  }

  @override
  void dispose() {
    _idCtrl.dispose();
    _mdpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 44, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar avec anneau accent
              Center(
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [kAccent, kAccent.withOpacity(0.55)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: kBg),
                    child: ClipOval(
                      child: Image.asset(
                        Donnees.photo,
                        width: 88,
                        height: 88,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 88,
                          height: 88,
                          color: kAccentSoft,
                          alignment: Alignment.center,
                          child: Text('A',
                              style: tx(34, w: FontWeight.w800, c: kAccent)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text('Bienvenue',
                  textAlign: TextAlign.center,
                  style: tx(30, w: FontWeight.w800, h: 1.1, ls: -0.6)),
              const SizedBox(height: 8),
              Text("Connectez-vous pour consulter le CV d'Asnath",
                  textAlign: TextAlign.center,
                  style: tx(14, c: kInk2, h: 1.5)),
              const SizedBox(height: 44),

              _Field(
                label: 'Identifiant',
                controller: _idCtrl,
                hint: 'Entrez votre identifiant',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              _Field(
                label: 'Mot de passe',
                controller: _mdpCtrl,
                hint: '••••••••',
                obscure: _hide,
                onSubmitted: (_) => _submit(),
                suffix: IconButton(
                  iconSize: 20,
                  splashRadius: 20,
                  icon: Icon(
                    _hide
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: kInk3,
                  ),
                  onPressed: () => setState(() => _hide = !_hide),
                ),
              ),

              if (_error != null) ...[
                const SizedBox(height: 14),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: kDangerSoft,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    const Icon(Icons.error_outline,
                        size: 16, color: kDanger),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(_error!,
                          style: tx(12.5,
                              w: FontWeight.w500, c: kDanger)),
                    ),
                  ]),
                ),
              ],

              const SizedBox(height: 32),
              SizedBox(
                height: 54,
                child: FilledButton(
                  onPressed: _loading ? null : _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: kInk,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: kInk.withOpacity(0.55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2.2, color: Colors.white),
                        )
                      : Text('Se connecter',
                          style: tx(15,
                              w: FontWeight.w700, c: Colors.white)),
                ),
              ),

              const SizedBox(height: 20),
             
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final Widget? suffix;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  const _Field({
    required this.label,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.suffix,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(label, style: tx(13, w: FontWeight.w600)),
        ),
        TextField(
          controller: controller,
          obscureText: obscure,
          cursorColor: kAccent,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          style: tx(15, w: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: tx(15, c: kInk3),
            filled: true,
            fillColor: kSurface,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: kHair),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: kHair),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: kAccent, width: 1.6),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// MAIN SHELL + BOTTOM NAV
// ============================================================================
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _i = 0;

  void _logout() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => const LoginPage(),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      AccueilPage(onLogout: _logout),
      const FamillePage(),
      const ContactPage(),
    ];
    return Scaffold(
      backgroundColor: kBg,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: KeyedSubtree(key: ValueKey(_i), child: pages[_i]),
      ),
      bottomNavigationBar:
          _BottomNav(index: _i, onChange: (v) => setState(() => _i = v)),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChange;
  const _BottomNav({required this.index, required this.onChange});

  static const _items = [
    (icon: Icons.home_outlined, active: Icons.home_rounded, label: 'Accueil'),
    (icon: Icons.people_outline_rounded,
        active: Icons.people_rounded,
        label: 'Famille'),
    (icon: Icons.mail_outline_rounded,
        active: Icons.mail_rounded,
        label: 'Contact'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kSurface,
        border: Border(top: BorderSide(color: kHair)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              for (int i = 0; i < _items.length; i++)
                Expanded(child: _navItem(i)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(int i) {
    final active = i == index;
    final it = _items[i];
    return InkWell(
      onTap: () => onChange(i),
      splashColor: kAccent.withOpacity(0.08),
      highlightColor: kAccent.withOpacity(0.04),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) => ScaleTransition(
              scale: anim.drive(Tween(begin: 0.85, end: 1.0)),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: Icon(
              active ? it.active : it.icon,
              key: ValueKey(active),
              size: 24,
              color: active ? kAccent : kInk3,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            it.label,
            style: tx(11,
                w: active ? FontWeight.w700 : FontWeight.w500,
                c: active ? kAccent : kInk3),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ACCUEIL
// ============================================================================
class AccueilPage extends StatelessWidget {
  final VoidCallback? onLogout;
  const AccueilPage({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mon CV',
                      style: tx(13, w: FontWeight.w600, c: kInk2)),
                  Material(
                    color: kSurface,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: onLogout,
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.logout_rounded,
                            size: 18, color: kInk2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Hero
              FadeSlide(
                child: AppCard(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2),
                            Text('Asnath',
                                style: tx(24,
                                    w: FontWeight.w800,
                                    h: 1.1,
                                    ls: -0.6)),
                            Text('Kanyabire',
                                style: tx(24,
                                    w: FontWeight.w800,
                                    h: 1.1,
                                    ls: -0.6)),
                            const SizedBox(height: 10),
                            Text(Donnees.titre,
                                style: tx(12.5, c: kInk2, h: 1.45)),
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: kAccentSoft,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.place_rounded,
                                      size: 12, color: kAccent),
                                  const SizedBox(width: 4),
                                  Text('Goma, RDC',
                                      style: tx(11,
                                          w: FontWeight.w600,
                                          c: kAccent)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Photo(
                        asset: Donnees.photo,
                        nom: Donnees.nom,
                        w: 76,
                        h: 94,
                        radius: 14,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Stats
              FadeSlide(
                delay: 1,
                child: AppCard(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      _stat('${Donnees.age}', 'ans'),
                      _vDivider(),
                      _stat('L3', 'niveau'),
                      _vDivider(),
                      _stat('${Donnees.experiences.length}', 'stage'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Informations
              FadeSlide(delay: 2, child: const SectionLabel('Informations')),
              FadeSlide(
                delay: 2,
                child: AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (int i = 0; i < Donnees.infos.length; i++) ...[
                        if (i > 0)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(height: 1, color: kHair),
                          ),
                        _infoRow(Donnees.infos[i]),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Formation
              FadeSlide(delay: 3, child: const SectionLabel('Formation')),
              FadeSlide(
                delay: 3,
                child: AppCard(
                  child: _timelineItem(
                    Icons.school_rounded,
                    Donnees.formation[0][0],
                    Donnees.formation[0][1],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Expérience
              FadeSlide(delay: 4, child: const SectionLabel('Expérience')),
              FadeSlide(
                delay: 4,
                child: AppCard(
                  child: _timelineItem(
                    Icons.work_rounded,
                    Donnees.experiences[0][0],
                    Donnees.experiences[0][1],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Compétences
              FadeSlide(delay: 5, child: const SectionLabel('Compétences')),
              FadeSlide(
                  delay: 5, child: AppCard(child: _chips(Donnees.competences))),

              const SizedBox(height: 24),

              // Langues
              FadeSlide(delay: 6, child: const SectionLabel('Langues')),
              FadeSlide(
                  delay: 6, child: AppCard(child: _chips(Donnees.langues))),

              const SizedBox(height: 24),

              // Qualités
              FadeSlide(delay: 7, child: const SectionLabel('Qualités')),
              FadeSlide(
                  delay: 7, child: AppCard(child: _chips(Donnees.qualites))),

              const SizedBox(height: 24),

              // Intérêts
              FadeSlide(
                  delay: 8,
                  child: const SectionLabel("Centres d'intérêt")),
              FadeSlide(
                delay: 8,
                child: AppCard(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    children: [
                      for (int i = 0; i < Donnees.interets.length; i++) ...[
                        if (i > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            child: Container(height: 1, color: kHair),
                          ),
                        _interestRow(Donnees.interets[i]),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(String v, String l) => Expanded(
        child: Column(
          children: [
            Text(v, style: tx(20, w: FontWeight.w800)),
            const SizedBox(height: 2),
            Text(l, style: tx(11.5, c: kInk3, w: FontWeight.w500)),
          ],
        ),
      );

  Widget _vDivider() => Container(width: 1, height: 28, color: kHair);

  Widget _infoRow(List info) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  color: kAccentSoft, borderRadius: BorderRadius.circular(8)),
              child: Icon(info[0] as IconData, size: 16, color: kAccent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(info[1] as String,
                  style: tx(13, c: kInk2, w: FontWeight.w500)),
            ),
            Text(info[2] as String,
                style: tx(13.5, w: FontWeight.w700)),
          ],
        ),
      );

  Widget _timelineItem(IconData icon, String title, String sub) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: kAccentSoft, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, size: 20, color: kAccent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text(title, style: tx(14.5, w: FontWeight.w700, h: 1.3)),
                const SizedBox(height: 4),
                Text(sub,
                    style:
                        tx(12.5, c: kInk3, w: FontWeight.w500)),
              ],
            ),
          ),
        ],
      );

  Widget _chips(List<String> items) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: items
            .map((e) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: kBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kHair),
                  ),
                  child: Text(e, style: tx(12.5, w: FontWeight.w600)),
                ))
            .toList(),
      );

  Widget _interestRow(List item) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: kAccentSoft, borderRadius: BorderRadius.circular(10)),
              child: Icon(item[0] as IconData, size: 18, color: kAccent),
            ),
            const SizedBox(width: 14),
            Text(item[1] as String,
                style: tx(14, w: FontWeight.w600)),
          ],
        ),
      );
}

// ============================================================================
// FAMILLE
// ============================================================================
class FamillePage extends StatelessWidget {
  const FamillePage({super.key});

  void _detail(BuildContext context, Membre m) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kSurface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                    color: kHair, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(height: 24),
              Photo(asset: m.photo, nom: m.nom, w: 100, h: 100, radius: 50),
              const SizedBox(height: 16),
              Text(m.nom, style: tx(22, w: FontWeight.w800)),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: kAccentSoft,
                    borderRadius: BorderRadius.circular(6)),
                child: Text(m.lien.toUpperCase(),
                    style: tx(10.5,
                        w: FontWeight.w700, c: kAccent, ls: 0.8)),
              ),
              const SizedBox(height: 16),
              Text("${m.lien} d'Asnath", style: tx(13, c: kInk3)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final parents = Donnees.famille.where((m) => m.parent).toList();
    final fratrie = Donnees.famille.where((m) => !m.parent).toList();

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              FadeSlide(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ma famille',
                          style: tx(28,
                              w: FontWeight.w800, ls: -0.6)),
                      const SizedBox(height: 6),
                      Text(
                          'Asnath est la ${Donnees.rangFamille} de la famille Kanyabire.',
                          style: tx(13.5, c: kInk2, h: 1.5)),
                    ],
                  ),
                ),
              ),

              FadeSlide(delay: 1, child: const SectionLabel('Parents')),
              FadeSlide(
                delay: 1,
                child: Row(
                  children: [
                    for (int i = 0; i < parents.length; i++) ...[
                      if (i > 0) const SizedBox(width: 12),
                      Expanded(child: _parentCard(context, parents[i])),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 24),

              FadeSlide(
                  delay: 2,
                  child: SectionLabel('Frères & Sœurs · ${fratrie.length}')),
              FadeSlide(
                delay: 2,
                child: AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (int i = 0; i < fratrie.length; i++) ...[
                        if (i > 0)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(height: 1, color: kHair),
                          ),
                        _siblingRow(context, fratrie[i]),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _parentCard(BuildContext context, Membre m) => AppCard(
        padding: const EdgeInsets.all(16),
        onTap: () => _detail(context, m),
        child: Column(
          children: [
            Photo(asset: m.photo, nom: m.nom, w: 64, h: 64, radius: 32),
            const SizedBox(height: 12),
            Text(m.nom,
                style: tx(14, w: FontWeight.w700),
                textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(m.lien,
                style: tx(11.5, c: kInk3, w: FontWeight.w500)),
          ],
        ),
      );

  Widget _siblingRow(BuildContext context, Membre m) => InkWell(
        onTap: () => _detail(context, m),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Photo(asset: m.photo, nom: m.nom, w: 42, h: 42, radius: 21),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.nom, style: tx(14, w: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(m.lien,
                        style: tx(12, c: kInk3, w: FontWeight.w500)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  size: 20, color: kInk3),
            ],
          ),
        ),
      );
}

// ============================================================================
// CONTACT
// ============================================================================
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _open(BuildContext context, String url) async {
    final ok = await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) showToast(context, "Impossible d'ouvrir");
  }

  Future<void> _copy(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) showToast(context, 'Copié dans le presse-papiers');
  }

  @override
  Widget build(BuildContext context) {
    final tel = Donnees.telephone.replaceAll(' ', '');
    final wa = 'https://wa.me/${tel.replaceAll('+', '')}';

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              FadeSlide(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Contact',
                          style: tx(28, w: FontWeight.w800, ls: -0.6)),
                      const SizedBox(height: 6),
                      Text('Restons en contact.',
                          style: tx(13.5, c: kInk2, h: 1.5)),
                    ],
                  ),
                ),
              ),

              FadeSlide(delay: 1, child: const SectionLabel('Actions')),
              FadeSlide(
                delay: 1,
                child: Row(
                  children: [
                    _actionCard(context, Icons.call_rounded, 'Appeler',
                        () => _open(context, 'tel:$tel')),
                    const SizedBox(width: 12),
                    _actionCard(context, Icons.mail_rounded, 'E-mail',
                        () => _open(context, 'mailto:${Donnees.email}')),
                    const SizedBox(width: 12),
                    _actionCard(context, Icons.chat_rounded, 'WhatsApp',
                        () => _open(context, wa)),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              FadeSlide(delay: 2, child: const SectionLabel('Coordonnées')),
              FadeSlide(
                delay: 2,
                child: AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _contactRow(
                        context,
                        Icons.phone_rounded,
                        'Téléphone',
                        Donnees.telephone,
                        () => _open(context, 'tel:$tel'),
                        () => _copy(context, Donnees.telephone),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(height: 1, color: kHair),
                      ),
                      _contactRow(
                        context,
                        Icons.email_rounded,
                        'E-mail',
                        Donnees.email,
                        () => _open(context, 'mailto:${Donnees.email}'),
                        () => _copy(context, Donnees.email),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(height: 1, color: kHair),
                      ),
                      _contactRow(
                        context,
                        Icons.location_on_rounded,
                        'Adresse',
                        Donnees.adresse,
                        null,
                        () => _copy(context, Donnees.adresse),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: Text('Appui long pour copier',
                    style: tx(11.5, c: kInk3)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionCard(BuildContext context, IconData icon, String label,
      VoidCallback onTap) {
    return Expanded(
      child: AppCard(
        padding: const EdgeInsets.symmetric(vertical: 18),
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: kAccentSoft,
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, size: 22, color: kAccent),
            ),
            const SizedBox(height: 10),
            Text(label,
                style: tx(12.5, w: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _contactRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    VoidCallback? onTap,
    VoidCallback onLongPress,
  ) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: kAccentSoft,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, size: 18, color: kAccent),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style:
                          tx(11.5, c: kInk3, w: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(value,
                      style: tx(14, w: FontWeight.w600)),
                ],
              ),
            ),
            Icon(
              onTap == null
                  ? Icons.content_copy_rounded
                  : Icons.arrow_outward_rounded,
              size: 16,
              color: kInk3,
            ),
          ],
        ),
      ),
    );
  }
}