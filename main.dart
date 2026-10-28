import 'package:flutter/material.dart';

void main() => runApp(const BoomgratulationsApp());

const red = Color(0xFFC8102E);
const darkRed = Color(0xFF99001B);
const paleRed = Color(0xFFFFF0F2);
const green = Color(0xFF169B45);
const gold = Color(0xFFE9A900);
const lostRed = Color(0xFFE21B2D);
const ink = Color(0xFF24212A);
const muted = Color(0xFF77717A);

class BoomgratulationsApp extends StatelessWidget {
  const BoomgratulationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boomgratulations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF7F7),
        colorScheme: ColorScheme.fromSeed(seedColor: red, primary: red),
        fontFamily: 'serif',
        appBarTheme: const AppBarTheme(
          backgroundColor: red,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class Match {
  final String league, home, away, time, score;
  final int homePos, awayPos;
  final String status;
  final String? homeForm, awayForm;
  const Match({
    required this.league, required this.home, required this.away,
    required this.time, required this.score, required this.homePos,
    required this.awayPos, required this.status, this.homeForm, this.awayForm,
  });
}

const sampleMatches = <Match>[
  Match(league: 'Premier League · England', home: 'Man City', away: 'Arsenal', time: '15:30', score: '2 - 1', homePos: 1, awayPos: 3, status: 'W', homeForm: 'W', awayForm: 'D'),
  Match(league: 'Premier League · England', home: 'Liverpool', away: 'Chelsea', time: '18:00', score: '1 - 1', homePos: 5, awayPos: 7, status: 'D', homeForm: 'W', awayForm: 'L'),
  Match(league: 'La Liga · Spain', home: 'Real Madrid', away: 'Barcelona', time: '16:15', score: '3 - 0', homePos: 2, awayPos: 4, status: 'W', homeForm: 'W', awayForm: 'L'),
  Match(league: 'Serie A · Italy', home: 'Inter Milan', away: 'AC Milan', time: '20:00', score: '1 - 0', homePos: 6, awayPos: 10, status: 'W', homeForm: 'W', awayForm: 'D'),
  Match(league: 'Bundesliga · Germany', home: 'Bayern Munich', away: 'Dortmund', time: '17:30', score: '2 - 2', homePos: 2, awayPos: 8, status: 'D', homeForm: 'D', awayForm: 'W'),
  Match(league: 'Ligue 1 · France', home: 'Marseille', away: 'Lyon', time: '20:00', score: '0 - 1', homePos: 8, awayPos: 17, status: 'L', homeForm: 'L', awayForm: 'W'),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;
  final titles = ['Fixtures', 'Live', 'Results', 'Picks', 'Account'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Container(
            width: 36, height: 36,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.sports_soccer, color: red, size: 25),
          ),
          const SizedBox(width: 10),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Boomgratulations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
            Text('Smarter picks · Bigger wins', style: TextStyle(fontSize: 10, color: Colors.white70)),
          ]),
        ]),
        actions: [
          IconButton(onPressed: () => _showInfo(context), icon: const Icon(Icons.notifications_none)),
        ],
      ),
      body: IndexedStack(index: selected, children: const [
        FixturesPage(), LivePage(), ResultsPage(), PicksPage(), AccountPage(),
      ]),
      bottomNavigationBar: NavigationBar(
        height: 66,
        selectedIndex: selected,
        onDestinationSelected: (i) => setState(() => selected = i),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFFFDDE2),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: 'Fixtures'),
          NavigationDestination(icon: Icon(Icons.sensors), selectedIcon: Icon(Icons.sensors), label: 'Live'),
          NavigationDestination(icon: Icon(Icons.scoreboard_outlined), selectedIcon: Icon(Icons.scoreboard), label: 'Result'),
          NavigationDestination(icon: Icon(Icons.stars_outlined), selectedIcon: Icon(Icons.stars), label: 'Picks'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}

void _showInfo(BuildContext context) {
  showDialog(context: context, builder: (_) => AlertDialog(
    title: const Text('Boomgratulations'),
    content: const Text('Demo interface. Connect your football data API to display verified live fixtures, standings and odds.'),
    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
  ));
}

class FixturesPage extends StatelessWidget {
  const FixturesPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
    children: [
      const PageHeading(title: 'Today’s Fixtures', subtitle: 'Wednesday · 28 October 2026', icon: Icons.calendar_month),
      const SizedBox(height: 10),
      const LegendCard(),
      const SizedBox(height: 10),
      ..._groupMatches(sampleMatches, (m) => MatchTile(match: m, showScore: false)),
    ],
  );
}

class LivePage extends StatelessWidget {
  const LivePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(12),
    children: [
      const PageHeading(title: 'Live Centre', subtitle: 'Live scores update when connected to a football API', icon: Icons.sensors),
      const SizedBox(height: 10),
      ...sampleMatches.take(4).map((m) => MatchTile(match: Match(
        league: m.league, home: m.home, away: m.away, time: "LIVE", score: m.score,
        homePos: m.homePos, awayPos: m.awayPos, status: m.status,
      ), showScore: true, live: true)),
      const ApiNotice(),
    ],
  );
}

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(12),
    children: [
      const PageHeading(title: 'Recent Results', subtitle: 'Sample scores for layout preview', icon: Icons.scoreboard),
      const SizedBox(height: 10),
      ...sampleMatches.map((m) => MatchTile(match: m, showScore: true)),
    ],
  );
}

class PicksPage extends StatelessWidget {
  const PicksPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(12),
    children: [
      const PageHeading(title: 'Today’s Picks', subtitle: 'Example picks only · not guaranteed outcomes', icon: Icons.stars),
      const SizedBox(height: 10),
      ...sampleMatches.take(5).map((m) => Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: Color(0xFFFFE0E4))),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(m.league, style: const TextStyle(fontSize: 11, color: red, fontWeight: FontWeight.bold)),
            const SizedBox(height: 7),
            Row(children: [
              Expanded(child: Text('${m.home} vs ${m.away}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
              const StatusPill(label: 'DEMO', color: gold),
            ]),
            const SizedBox(height: 7),
            const Row(children: [
              Icon(Icons.insights, size: 15, color: green),
              SizedBox(width: 5),
              Text('Over 1.5 Goals', style: TextStyle(fontSize: 12)),
              Spacer(),
              Text('Example', style: TextStyle(fontSize: 11, color: muted)),
            ]),
          ]),
        ),
      )),
      const ApiNotice(),
    ],
  );
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(12),
    children: [
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [red, darkRed]),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Row(children: [
          CircleAvatar(radius: 29, backgroundColor: Colors.white, child: Icon(Icons.person, color: red, size: 32)),
          SizedBox(width: 13),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Welcome, Football Fan', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Your match centre at a glance', style: TextStyle(color: Colors.white70, fontSize: 11)),
          ]),
        ]),
      ),
      const SizedBox(height: 12),
      const Row(children: [
        Expanded(child: StatCard(value: '24', label: 'Picks')),
        SizedBox(width: 8),
        Expanded(child: StatCard(value: '—', label: 'Wins')),
        SizedBox(width: 8),
        Expanded(child: StatCard(value: '—', label: 'Accuracy')),
      ]),
      const SizedBox(height: 12),
      ...[
        (Icons.bookmark_border, 'Saved matches'),
        (Icons.notifications_none, 'Notifications'),
        (Icons.settings_outlined, 'Settings'),
        (Icons.help_outline, 'Help & Support'),
        (Icons.info_outline, 'About Boomgratulations'),
      ].map((item) => Card(
        elevation: 0, color: Colors.white,
        child: ListTile(
          dense: true,
          leading: Icon(item.$1, color: red),
          title: Text(item.$2, style: const TextStyle(fontSize: 13)),
          trailing: const Icon(Icons.chevron_right, size: 18),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${item.$2} will be available in a future build.'))),
        ),
      )),
    ],
  );
}

List<Widget> _groupMatches(List<Match> matches, Widget Function(Match) tileBuilder) {
  final leagues = <String, List<Match>>{};
  for (final match in matches) {
    leagues.putIfAbsent(match.league, () => []).add(match);
  }
  final widgets = <Widget>[];
  leagues.forEach((league, items) {
    widgets.add(LeagueHeader(league: league));
    for (final match in items) {
      widgets.add(tileBuilder(match));
    }
    widgets.add(const SizedBox(height: 8));
  });
  return widgets;
}

class PageHeading extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  const PageHeading({super.key, required this.title, required this.subtitle, required this.icon});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFFFE0E4))),
    child: Row(children: [
      Container(width: 40, height: 40, decoration: BoxDecoration(color: paleRed, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: red)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ink)),
        const SizedBox(height: 3),
        Text(subtitle, style: const TextStyle(fontSize: 10, color: muted)),
      ])),
    ]),
  );
}

class LeagueHeader extends StatelessWidget {
  final String league;
  const LeagueHeader({super.key, required this.league});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(top: 5),
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
    decoration: const BoxDecoration(color: Color(0xFFFFE4E8), borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
    child: Row(children: [
      const Icon(Icons.emoji_events_outlined, size: 15, color: red),
      const SizedBox(width: 7),
      Expanded(child: Text(league, style: const TextStyle(fontSize: 11, color: darkRed, fontWeight: FontWeight.bold))),
      const Icon(Icons.keyboard_arrow_down, size: 17, color: darkRed),
    ]),
  );
}

class MatchTile extends StatelessWidget {
  final Match match;
  final bool showScore, live;
  const MatchTile({super.key, required this.match, required this.showScore, this.live = false});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 1),
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 11),
    decoration: const BoxDecoration(color: Colors.white),
    child: Row(children: [
      SizedBox(width: 37, child: Text(match.time, style: TextStyle(fontSize: 10, color: live ? red : muted, fontWeight: live ? FontWeight.bold : FontWeight.normal))),
      const SizedBox(width: 4),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TeamLine(name: match.home, position: match.homePos, form: match.homeForm),
        const SizedBox(height: 8),
        TeamLine(name: match.away, position: match.awayPos, form: match.awayForm),
      ])),
      const SizedBox(width: 6),
      if (showScore)
        Column(children: [
          Text(match.score, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ink)),
          const SizedBox(height: 5),
          StatusPill(label: match.status, color: statusColor(match.status)),
        ])
      else
        const Icon(Icons.chevron_right, color: muted, size: 18),
    ]),
  );
}

class TeamLine extends StatelessWidget {
  final String name;
  final int position;
  final String? form;
  const TeamLine({super.key, required this.name, required this.position, this.form});
  @override
  Widget build(BuildContext context) => Row(children: [
    Container(
      width: 21, height: 21, alignment: Alignment.center,
      decoration: BoxDecoration(color: positionColor(position), borderRadius: BorderRadius.circular(6)),
      child: Text('$position', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    ),
    const SizedBox(width: 7),
    Expanded(child: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: ink))),
    if (form != null) ...[
      const SizedBox(width: 4),
      Container(width: 18, height: 18, alignment: Alignment.center,
        decoration: BoxDecoration(color: statusColor(form!), borderRadius: BorderRadius.circular(5)),
        child: Text(form!, style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    ],
  ]);
}

Color positionColor(int position) {
  if (position <= 3) return green;
  if (position <= 15) return gold;
  return lostRed;
}

Color statusColor(String status) {
  switch (status.toUpperCase()) {
    case 'W': return green;
    case 'D': return gold;
    default: return lostRed;
  }
}

class StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  const StatusPill({super.key, required this.label, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
    child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
  );
}

class LegendCard extends StatelessWidget {
  const LegendCard({super.key});
  @override
  Widget build(BuildContext context) => Card(
    elevation: 0, color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFFFE0E4))),
    child: const Padding(
      padding: EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Form & League Position', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        SizedBox(height: 7),
        Wrap(spacing: 6, runSpacing: 6, children: [
          LegendChip(color: green, label: 'Win / 1–3'),
          LegendChip(color: gold, label: 'Draw / 4–15'),
          LegendChip(color: lostRed, label: 'Lost / Relegation'),
        ]),
      ]),
    ),
  );
}

class LegendChip extends StatelessWidget {
  final Color color;
  final String label;
  const LegendChip({super.key, required this.color, required this.label});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(color: color.withOpacity(.10), borderRadius: BorderRadius.circular(7)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 5),
      Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
    ]),
  );
}

class StatCard extends StatelessWidget {
  final String value, label;
  const StatCard({super.key, required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 15),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFFFE0E4))),
    child: Column(children: [
      Text(value, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: red)),
      const SizedBox(height: 3),
      Text(label, style: const TextStyle(fontSize: 10, color: muted)),
    ]),
  );
}

class ApiNotice extends StatelessWidget {
  const ApiNotice({super.key});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: const Color(0xFFFFF6DF), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFE3A3))),
    child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(Icons.info_outline, color: Color(0xFF966900), size: 17),
      SizedBox(width: 8),
      Expanded(child: Text('Preview data only. Connect API-Football through a secure backend before using this app for real fixtures, standings, odds or live scores.', style: TextStyle(fontSize: 10, color: Color(0xFF755600)))),
    ]),
  );
}
