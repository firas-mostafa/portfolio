import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../constants/content.dart';

// "Technical Stack" — 3-column capability grid.
class StackSection extends StatelessComponent {
  const StackSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(id: 'stack', classes: 'stack-section', [
      div(classes: 'stack-header', [
        span(classes: 'section-label', [Component.text('Capabilities // 02')]),
        h2(classes: 'section-title stack-title', [
          strong([Component.text('TECHNICAL')]),
          Component.text(' STACK'),
        ]),
      ]),
      div(classes: 'stack-grid', [
        for (final item in technicalStack)
          div(classes: 'stack-card', [
            span(classes: 'stack-index', [Component.text(item.index)]),
            h3(classes: 'stack-card-title', [Component.text(item.title)]),
            p(classes: 'stack-card-desc', [Component.text(item.desc)]),
          ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
        css('.stack-section').styles(
          minHeight: 100.vh,
          display: Display.flex,
          flexDirection: FlexDirection.column,
          justifyContent: JustifyContent.center,
          width: 100.percent,
          maxWidth: 1200.px,
          padding: Padding.symmetric(horizontal: 24.px, vertical: 80.px),
          raw: {
            'margin-left': 'auto',
            'margin-right': 'auto',
            'scroll-snap-align': 'start',
            'scroll-snap-stop': 'always',
            'box-sizing': 'border-box',
          },
        ),
        css('.stack-header').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(12.px),
          margin: Margin.only(bottom: 28.px),
        ),
        css('.section-label').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 10.px,
          letterSpacing: 5.px,
          textTransform: TextTransform.upperCase,
          color: const Color('rgba(255,255,255,0.4)'),
          display: Display.block,
        ),
        css('.section-title').styles(
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontWeight: FontWeight.w700,
          fontSize: 8.vw,
          letterSpacing: (-2).px,
          textTransform: TextTransform.upperCase,
          margin: Margin.zero,
          color: const Color('rgba(255,255,255,0.3)'),
        ),
        css('.section-title strong').styles(color: Colors.white, fontWeight: FontWeight.w900),
        css('.stack-grid').styles(
          display: Display.grid,
          gap: Gap.all(1.px),
          width: 100.percent,
          backgroundColor: const Color('rgba(255,255,255,0.08)'),
          border: Border.all(color: const Color('rgba(255,255,255,0.08)'), width: 1.px, style: BorderStyle.solid),
          raw: {'grid-template-columns': '1fr'},
        ),
        css('.stack-card').styles(
          padding: Padding.all(32.px),
          minHeight: 240.px,
          backgroundColor: const Color('#121212'),
          raw: {
            'transition': 'all .35s ease',
            'position': 'relative',
            'overflow': 'hidden',
          },
        ),
        css('.stack-card:hover').styles(
          backgroundColor: const Color('#1a1a1a'),
          raw: {'transform': 'translateY(-2px)'},
        ),
        css('.stack-card::before').styles(
          content: '""',
          position: Position.absolute(top: Unit.zero, left: Unit.zero, right: Unit.zero),
          height: 1.px,
          backgroundColor: const Color('rgba(255,255,255,0.1)'),
        ),
        css('.stack-index').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 12.px,
          color: const Color('rgba(255,255,255,0.35)'),
          display: Display.block,
          margin: Margin.only(bottom: 18.px),
        ),
        css('.stack-card-title').styles(
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontWeight: FontWeight.w700,
          fontSize: 24.px,
          lineHeight: 1.2.em,
          margin: Margin.only(bottom: 14.px),
          color: Colors.white,
        ),
        css('.stack-card-desc').styles(
          fontSize: 15.px,
          fontWeight: FontWeight.w300,
          lineHeight: 1.6.em,
          color: const Color('rgba(255,255,255,0.58)'),
          margin: Margin.zero,
        ),
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.section-title').styles(fontSize: 42.px),
          css('.stack-grid').styles(raw: {'grid-template-columns': '1fr 1fr 1fr'}),
          css('.stack-card').styles(padding: Padding.all(40.px)),
        ]),
      ];
}
