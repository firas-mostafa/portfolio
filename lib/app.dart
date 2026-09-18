import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import 'sections/hero.dart';
import 'sections/stack.dart';
import 'sections/projects_overview.dart';
import 'sections/projects.dart';
import 'sections/contact.dart';
import 'components/side_nav.dart';
import 'components/particles.dart';
import 'constants/content.dart';

// Root portfolio component. Single-page: all sections stacked vertically with Scroll Snap.
class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      // Background interactive particle layer (client-only canvas).
      const ParticleBackground(),
      // Fixed side navigation (desktop).
      const SideNav(),
      // Main scrollable content.
      main_(id: 'top', classes: 'snap-main', [
        const HeroSection(),
        const StackSection(),
        const ProjectsOverviewSection(),
        for (final p in projects) ProjectSection(project: p),
        const ContactSection(),
      ]),
    ]);
  }

  // ---- Global styles ----
  @css
  static List<StyleRule> get styles => [
        css.import(
            'https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;500;700&family=JetBrains+Mono:wght@100;500;900&family=Montserrat:wght@100;600;700;900&display=swap'),
        css('*').styles(boxSizing: BoxSizing.borderBox),
        css('html, body').styles(
          margin: Margin.zero,
          padding: Padding.zero,
          width: 100.vw,
          height: 100.vh,
          backgroundColor: const Color('#131313'),
          color: const Color('#e2e2e2'),
          fontFamily: const FontFamily.list([FontFamily('Inter'), FontFamilies.sansSerif]),
          raw: {
            'overflow-x': 'hidden',
            'scroll-behavior': 'smooth',
          },
        ),
        css('.snap-main').styles(
          width: 100.percent,
          height: 100.vh,
          raw: {
            'position': 'relative',
            'z-index': '1',
            'overflow-y': 'scroll',
            'scroll-snap-type': 'y mandatory',
            'scroll-behavior': 'smooth',
          },
        ),
        css('a').styles(color: Color.inherit, textDecoration: const TextDecoration(line: TextDecorationLine.none)),
        // Section base for snap
        css('section').styles(
          minHeight: 100.vh,
          padding: Padding.symmetric(horizontal: 24.px, vertical: 80.px),
          raw: {
            'position': 'relative',
            'scroll-snap-align': 'start',
            'scroll-snap-stop': 'always',
            'box-sizing': 'border-box',
            'display': 'flex',
            'flex-direction': 'column',
            'justify-content': 'center',
          },
        ),
        // Responsive: desktop gets left gutter for the side-nav
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('section').styles(padding: Padding.only(left: 240.px, right: 120.px, top: 80.px, bottom: 80.px)),
        ]),
      ];
}
