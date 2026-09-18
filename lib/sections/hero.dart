import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../constants/content.dart';

// Hero: oversized headline, name eyebrow, tagline, CTA.
class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(id: 'home', classes: 'hero', [
      div(classes: 'hero-inner', [
        span(classes: 'eyebrow', [Component.text('${Profile.name} // PORTFOLIO')]),
        h1(classes: 'hero-title', [
          Component.text(Profile.roleLine1),
          br(),
          span(classes: 'muted', [Component.text(Profile.roleLine2)]),
        ]),
        p(classes: 'hero-tagline', [Component.text(Profile.tagline)]),
        div(classes: 'hero-cta', [
          a(href: '#projects', classes: 'btn', [Component.text('View Work')]),
          a(href: '#contact', classes: 'btn-ghost', [Component.text('Get in Touch')]),
          a(href: Profile.cvPath, download: 'firas-mostafa-cv.pdf', classes: 'btn-ghost', [
            Component.text('Download CV'),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
        css('.hero').styles(
          display: Display.flex,
          raw: {'flex-direction': 'column', 'justify-content': 'center'},
        ),
        css('.eyebrow').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 11.px,
          letterSpacing: 4.px,
          textTransform: TextTransform.upperCase,
          color: const Color('rgba(255,255,255,0.4)'),
          margin: Margin.only(bottom: 24.px),
        ),
        css('.hero-title').styles(
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontWeight: FontWeight.w900,
          raw: {'font-size': 'clamp(3.4rem, 9vw, 9.5rem)', 'line-height': '0.9'},
          letterSpacing: (-4).px,
          margin: Margin.zero,
          color: Colors.white,
        ),
        css('.hero-title .muted').styles(color: const Color('rgba(255,255,255,0.25)')),
        css('.hero-tagline').styles(
          maxWidth: 560.px,
          fontSize: 18.px,
          fontWeight: FontWeight.w300,
          lineHeight: 1.6.em,
          color: const Color('rgba(255,255,255,0.6)'),
          margin: Margin.only(top: 32.px),
        ),
        css('.hero-cta').styles(
          display: Display.flex,
          gap: Gap.all(16.px),
          margin: Margin.only(top: 48.px),
          raw: {'flex-wrap': 'wrap'},
        ),
        css('.btn').styles(
          padding: Padding.symmetric(horizontal: 32.px, vertical: 16.px),
          backgroundColor: Colors.white,
          color: const Color('#131313'),
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 12.px,
          letterSpacing: 2.px,
          textTransform: TextTransform.upperCase,
          raw: {'transition': 'transform .3s'},
        ),
        css('.btn:hover').styles(raw: {'transform': 'translateY(-2px)'}),
        css('.btn-ghost').styles(
          padding: Padding.symmetric(horizontal: 32.px, vertical: 16.px),
          border: Border.all(color: const Color('rgba(255,255,255,0.2)'), width: 1.px, style: BorderStyle.solid),
          color: Colors.white,
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 12.px,
          letterSpacing: 2.px,
          textTransform: TextTransform.upperCase,
          raw: {'transition': 'border-color .3s'},
        ),
        css('.btn-ghost:hover').styles(border: Border.all(color: Colors.white, width: 1.px, style: BorderStyle.solid)),
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.hero-title').styles(fontSize: 9.vw),
        ]),
      ];
}
