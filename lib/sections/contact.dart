import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../constants/content.dart';

// "Let's Connect" — email + social links + footer.
class ContactSection extends StatelessComponent {
  const ContactSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(id: 'contact', classes: 'contact', [
      span(classes: 'section-label', [Component.text('Connection // 04')]),
      h2(classes: 'section-title', [
        strong([Component.text("LET'S")]),
        Component.text(' CONNECT'),
      ]),
      div(classes: 'contact-grid', [
        div(classes: 'contact-left', [
          p(classes: 'contact-blurb', [Component.text(Profile.availability)]),
          div([
            span(classes: 'contact-eyebrow', [Component.text('Email')]),
            a(href: 'mailto:${Profile.email}', classes: 'contact-email', [Component.text(Profile.email)]),
          ]),
        ]),
        div(classes: 'contact-right', [
          div(classes: 'contact-socials', [
            a(href: Profile.linkedin, target: Target.blank, [Component.text('LinkedIn')]),
            a(href: Profile.github, target: Target.blank, [Component.text('GitHub')]),
          ]),
          div(classes: 'availability', [
            span(classes: 'availability-dot', []),
            span(classes: 'availability-text', [Component.text('Available for remote work')]),
          ]),
          div(classes: 'contact-footer', [
            Component.text('© 2026 Firas Mostafa'),
            br(),
            Component.text('Full-Stack & AI Engineer · ${Profile.location}'),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
        css('.contact').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          justifyContent: JustifyContent.center,
        ),
        css('.contact-grid').styles(
          display: Display.grid,
          gap: Gap.all(64.px),
          raw: {'grid-template-columns': '1fr'},
        ),
        css('.contact-blurb').styles(
          fontSize: 24.px,
          fontWeight: FontWeight.w300,
          lineHeight: 1.5.em,
          color: const Color('rgba(255,255,255,0.6)'),
          margin: Margin.only(bottom: 48.px),
        ),
        css('.contact-eyebrow').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 11.px,
          letterSpacing: 3.px,
          textTransform: TextTransform.upperCase,
          color: const Color('rgba(255,255,255,0.6)'),
          display: Display.block,
          margin: Margin.only(bottom: 8.px),
        ),
        css('.contact-email').styles(
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontWeight: FontWeight.w700,
          fontSize: 28.px,
          color: Colors.white,
          border: Border.only(bottom: BorderSide(color: const Color('rgba(255,255,255,0.1)'), width: 1.px, style: BorderStyle.solid)),
          raw: {'padding-bottom': '8px', 'display': 'inline-block', 'transition': 'border-color .4s'},
        ),
        css('.contact-email:hover').styles(
          border: Border.only(bottom: BorderSide(color: Colors.white, width: 1.px, style: BorderStyle.solid)),
        ),
        css('.contact-socials').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(16.px),
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 12.px,
          textTransform: TextTransform.upperCase,
        ),
        css('.contact-socials a').styles(
          color: const Color('rgba(255,255,255,0.7)'),
          raw: {'letter-spacing': '2px', 'transition': 'color .3s'},
        ),
        css('.contact-socials a:hover').styles(color: Colors.white),
        css('.contact-footer').styles(
          margin: Margin.only(top: 24.px),
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 11.px,
          lineHeight: 1.8.em,
          color: const Color('rgba(255,255,255,0.5)'),
        ),
        // Availability indicator with a gentle pulsing dot.
        css('.availability').styles(
          display: Display.flex,
          alignItems: AlignItems.center,
          gap: Gap.all(10.px),
          margin: Margin.only(top: 48.px),
        ),
        css('.availability-dot').styles(
          width: 9.px,
          height: 9.px,
          backgroundColor: const Color('#2ecc71'),
          raw: {
            'border-radius': '50%',
            'flex-shrink': '0',
            'box-shadow': '0 0 0 0 rgba(46, 204, 113, 0.6)',
            'animation': 'availability-pulse 2.4s ease-out infinite',
          },
        ),
        css('.availability-text').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 12.px,
          letterSpacing: 1.px,
          textTransform: TextTransform.upperCase,
          color: const Color('rgba(255,255,255,0.7)'),
        ),
        css.keyframes('availability-pulse', {
          '0%': Styles(raw: {'box-shadow': '0 0 0 0 rgba(46, 204, 113, 0.55)'}),
          '70%': Styles(raw: {'box-shadow': '0 0 0 10px rgba(46, 204, 113, 0)'}),
          '100%': Styles(raw: {'box-shadow': '0 0 0 0 rgba(46, 204, 113, 0)'}),
        }),
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.contact-grid').styles(raw: {'grid-template-columns': '1fr 1fr'}),
          css('.contact-right').styles(
            display: Display.flex,
            flexDirection: FlexDirection.column,
            alignItems: AlignItems.end,
            justifyContent: JustifyContent.spaceBetween,
          ),
        ]),
      ];
}
