import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../constants/content.dart';

// Hero: oversized headline, name eyebrow, tagline, CTA with CV dropdown.
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
          div(classes: 'cv-dropdown', [
            button(
              classes: 'btn-ghost cv-dropdown-trigger',
              attributes: {
                'type': 'button',
                'aria-haspopup': 'true',
                'aria-expanded': 'false',
              },
              [
                Component.text('Download CV'),
                span(classes: 'cv-chevron', [Component.text('▾')]),
              ],
            ),
            div(classes: 'cv-dropdown-menu', [
              for (final cv in Profile.cvOptions)
                a(
                  href: cv.path,
                  download: cv.fileName,
                  classes: 'cv-dropdown-item',
                  [
                    span(classes: 'cv-item-title', [Component.text(cv.title)]),
                    span(classes: 'cv-item-role', [Component.text(cv.role)]),
                  ],
                ),
            ]),
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
          color: const Color('rgba(255,255,255,0.6)'),
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
        css('.hero-title .muted').styles(color: const Color('rgba(255,255,255,0.72)')),
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
          raw: {'flex-wrap': 'wrap', 'position': 'relative', 'z-index': '20'},
        ),
        css('.btn').styles(
          padding: Padding.symmetric(horizontal: 32.px, vertical: 16.px),
          backgroundColor: Colors.white,
          color: const Color('#131313'),
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 12.px,
          letterSpacing: 2.px,
          textTransform: TextTransform.upperCase,
          raw: {'transition': 'transform .3s', 'cursor': 'pointer', 'display': 'inline-flex', 'align-items': 'center', 'text-decoration': 'none'},
        ),
        css('.btn:hover').styles(raw: {'transform': 'translateY(-2px)'}),
        css('.btn-ghost').styles(
          padding: Padding.symmetric(horizontal: 32.px, vertical: 16.px),
          border: Border.all(color: const Color('rgba(255,255,255,0.2)'), width: 1.px, style: BorderStyle.solid),
          backgroundColor: Colors.transparent,
          color: Colors.white,
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 12.px,
          letterSpacing: 2.px,
          textTransform: TextTransform.upperCase,
          raw: {'transition': 'all .3s ease', 'cursor': 'pointer', 'display': 'inline-flex', 'align-items': 'center', 'text-decoration': 'none'},
        ),
        css('.btn-ghost:hover').styles(
          border: Border.all(color: Colors.white, width: 1.px, style: BorderStyle.solid),
          backgroundColor: const Color('rgba(255,255,255,0.05)'),
        ),
        // CV Dropdown Container
        css('.cv-dropdown').styles(
          raw: {
            'position': 'relative',
            'display': 'inline-flex',
          },
        ),
        css('.cv-dropdown-trigger').styles(
          raw: {
            'gap': '10px',
          },
        ),
        css('.cv-chevron').styles(
          fontSize: 12.px,
          raw: {
            'transition': 'transform .3s ease',
            'color': 'rgba(255,255,255,0.6)',
            'display': 'inline-block',
          },
        ),
        css('.cv-dropdown:hover .cv-chevron, .cv-dropdown.open .cv-chevron').styles(
          raw: {'transform': 'rotate(180deg)'},
        ),
        // CV Dropdown Menu
        css('.cv-dropdown-menu').styles(
          raw: {
            'position': 'absolute',
            'top': 'calc(100% + 8px)',
            'left': '0',
            'min-width': '310px',
            'background': 'rgba(18, 18, 18, 0.96)',
            'backdrop-filter': 'blur(16px)',
            '-webkit-backdrop-filter': 'blur(16px)',
            'border': '1px solid rgba(255, 255, 255, 0.16)',
            'padding': '6px 0',
            'opacity': '0',
            'visibility': 'hidden',
            'pointer-events': 'none',
            'transform': 'translateY(8px)',
            'transition': 'all .25s cubic-bezier(0.16, 1, 0.3, 1)',
            'z-index': '100',
            'box-shadow': '0 20px 40px rgba(0, 0, 0, 0.8)',
          },
        ),
        css('.cv-dropdown:hover .cv-dropdown-menu, .cv-dropdown:focus-within .cv-dropdown-menu, .cv-dropdown.open .cv-dropdown-menu').styles(
          raw: {
            'opacity': '1',
            'visibility': 'visible',
            'pointer-events': 'auto',
            'transform': 'translateY(0)',
          },
        ),
        // CV Dropdown Items
        css('.cv-dropdown-item').styles(
          raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '4px',
            'padding': '14px 20px',
            'text-align': 'left',
            'text-decoration': 'none',
            'border-bottom': '1px solid rgba(255, 255, 255, 0.06)',
            'transition': 'background .2s ease, padding-left .2s ease',
            'cursor': 'pointer',
          },
        ),
        css('.cv-dropdown-item:last-child').styles(
          raw: {'border-bottom': 'none'},
        ),
        css('.cv-dropdown-item:hover').styles(
          backgroundColor: const Color('rgba(255, 255, 255, 0.08)'),
          raw: {
            'padding-left': '26px',
          },
        ),
        css('.cv-item-title').styles(
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontSize: 13.px,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 0.5.px,
        ),
        css('.cv-item-role').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 11.px,
          color: const Color('rgba(255, 255, 255, 0.6)'),
          letterSpacing: 1.px,
          textTransform: TextTransform.upperCase,
        ),
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.hero-title').styles(fontSize: 9.vw),
        ]),
      ];
}
