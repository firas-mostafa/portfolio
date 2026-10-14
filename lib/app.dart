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
      // Ambient glow that re-tints per active section (color set from JS).
      // Sits above the opaque particle canvas, below the scrollable content.
      div(classes: 'ambient-glow', []),
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
            'https://fonts.googleapis.com/css2?family=Inter:wght@300;400&family=JetBrains+Mono:wght@400&family=Montserrat:wght@700;800;900&display=swap'),
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
            'overflow-y': 'auto',
            'scroll-behavior': 'smooth',
          },
        ),
        css('a').styles(color: Color.inherit, textDecoration: const TextDecoration(line: TextDecorationLine.none)),
        // Section base
        css('section').styles(
          minHeight: 100.vh,
          padding: Padding.symmetric(horizontal: 24.px, vertical: 80.px),
          raw: {
            'position': 'relative',
            'box-sizing': 'border-box',
            'display': 'flex',
            'flex-direction': 'column',
            'justify-content': 'center',
          },
        ),
        // Responsive: desktop gets left gutter for side-nav and scroll-snap
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.snap-main').styles(
            raw: {
              'scroll-snap-type': 'y proximity',
            },
          ),
          css('section').styles(
            padding: Padding.only(left: 240.px, right: 120.px, top: 80.px, bottom: 80.px),
            raw: {
              'scroll-snap-align': 'start',
            },
          ),
        ]),
        // Respect users who prefer reduced motion: disable smooth scroll and
        // CSS transitions/animations site-wide (JS-driven effects are gated too).
        css.media(const MediaQuery.raw('(prefers-reduced-motion: reduce)'), [
          css('html, body, .snap-main').styles(raw: {'scroll-behavior': 'auto'}),
          css('*').styles(raw: {
            'transition-duration': '0.001ms !important',
            'animation-duration': '0.001ms !important',
            'animation-iteration-count': '1 !important',
          }),
        ]),
      ];
}
