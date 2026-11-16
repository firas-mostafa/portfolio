import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../constants/content.dart';

// "What I Offer" — a tabbed explainer: pick a service on the left, its short
// video plays on the right. Only the active video is ever fetched (preload
// none + JS-driven play), so the section costs one clip, not five.
class ServicesSection extends StatelessComponent {
  const ServicesSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(
        id: 'services',
        classes: 'services',
        attributes: {'data-glow': 'rgba(59,130,246,0.05)'}, [
      div(classes: 'services-header', [
        span(classes: 'section-label', [Component.text('Services // 02')]),
        h2(classes: 'section-title', [
          strong([Component.text('WHAT I')]),
          Component.text(' OFFER'),
        ]),
      ]),
      div(classes: 'services-grid', [
        // Tab list
        div(classes: 'services-list', attributes: {'role': 'tablist'}, [
          for (var i = 0; i < services.length; i++)
            button(
              classes: 'service-item${i == 0 ? ' active' : ''}',
              attributes: {
                'type': 'button',
                'role': 'tab',
                'data-index': '$i',
                'aria-selected': i == 0 ? 'true' : 'false',
              },
              [
                div(classes: 'service-head', [
                  span(classes: 'service-num', [Component.text(services[i].index)]),
                  h3(classes: 'service-title', [Component.text(services[i].title)]),
                ]),
                div(classes: 'service-detail', [
                  div(classes: 'service-detail-inner', [
                    p(classes: 'service-tagline', [Component.text(services[i].tagline)]),
                    p(classes: 'service-desc', [Component.text(services[i].desc)]),
                  ]),
                ]),
                span(classes: 'service-progress', []),
              ],
            ),
        ]),

        // Player
        div(classes: 'services-player', [
          div(classes: 'player-frame', [
            for (var i = 0; i < services.length; i++)
              video(
                classes: 'service-video${i == 0 ? ' active' : ''}',
                poster: 'videos/services/${services[i].slug}-poster.jpg',
                // preload none keeps the other four clips off the wire until
                // JS calls play() on them.
                preload: Preload.none,
                muted: true,
                attributes: {'playsinline': '', 'data-index': '$i'},
                [
                  source(src: 'videos/services/${services[i].slug}.mp4', type: 'video/mp4'),
                ],
              ),
            button(
              classes: 'player-sound',
              attributes: {'type': 'button', 'aria-label': 'Unmute video'},
              [
                span(classes: 'sound-dot', []),
                span(classes: 'sound-text', [Component.text('Sound off')]),
              ],
            ),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
        css('.services').styles(
          minHeight: 100.vh,
          display: Display.flex,
          flexDirection: FlexDirection.column,
          justifyContent: JustifyContent.center,
          // Extra bottom padding clears the fixed mobile nav bar.
          padding: Padding.only(left: 24.px, right: 24.px, top: 64.px, bottom: 104.px),
          raw: {
            'box-sizing': 'border-box',
            'background':
                'radial-gradient(ellipse 80% 60% at 85% 0%, rgba(59, 130, 246, 0.06) 0%, transparent 65%)',
          },
        ),
        css('.services-header').styles(
          width: 100.percent,
          maxWidth: 1200.px,
          margin: Margin.only(bottom: 28.px),
          raw: {'margin-left': 'auto', 'margin-right': 'auto'},
        ),
        css('.services-grid').styles(
          display: Display.grid,
          gap: Gap.all(22.px),
          width: 100.percent,
          maxWidth: 1200.px,
          alignItems: AlignItems.center,
          raw: {
            'grid-template-columns': '1fr',
            'margin-left': 'auto',
            'margin-right': 'auto',
          },
        ),

        // ── Tab list ──────────────────────────────────────────────────────
        css('.services-list').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(4.px),
          raw: {'order': '2'},
        ),
        css('.service-item').styles(
          display: Display.block,
          width: 100.percent,
          padding: Padding.symmetric(horizontal: 16.px, vertical: 11.px),
          backgroundColor: Colors.transparent,
          color: Color.inherit,
          cursor: Cursor.pointer,
          raw: {
            'text-align': 'left',
            'position': 'relative',
            'border': '1px solid transparent',
            'border-radius': '12px',
            'transition': 'background .3s ease, border-color .3s ease',
            'font': 'inherit',
            '-webkit-tap-highlight-color': 'transparent',
          },
        ),
        css('.service-item:hover').styles(
          backgroundColor: const Color('rgba(255,255,255,0.03)'),
        ),
        css('.service-item.active').styles(
          backgroundColor: const Color('rgba(59,130,246,0.07)'),
          raw: {'border-color': 'rgba(59,130,246,0.25)'},
        ),
        css('.service-head').styles(
          display: Display.flex,
          alignItems: AlignItems.baseline,
          gap: Gap.all(14.px),
        ),
        css('.service-num').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 11.px,
          letterSpacing: 1.px,
          color: const Color('rgba(255,255,255,0.35)'),
          raw: {'flex-shrink': '0', 'transition': 'color .3s ease'},
        ),
        css('.service-item.active .service-num').styles(
          color: const Color('rgba(59,130,246,0.9)'),
        ),
        css('.service-title').styles(
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontWeight: FontWeight.w700,
          fontSize: 17.px,
          letterSpacing: (-0.3).px,
          margin: Margin.zero,
          color: const Color('rgba(255,255,255,0.65)'),
          raw: {'transition': 'color .3s ease'},
        ),
        css('.service-item:hover .service-title').styles(
          color: const Color('rgba(255,255,255,0.85)'),
        ),
        css('.service-item.active .service-title').styles(color: Colors.white),

        // Detail text collapses away on inactive tabs.
        css('.service-detail').styles(
          raw: {
            'display': 'grid',
            'grid-template-rows': '0fr',
            'opacity': '0',
            'transition': 'grid-template-rows .45s cubic-bezier(.16,1,.3,1), opacity .3s ease',
          },
        ),
        css('.service-item.active .service-detail').styles(
          raw: {'grid-template-rows': '1fr', 'opacity': '1'},
        ),
        css('.service-detail-inner').styles(raw: {'overflow': 'hidden'}),
        css('.service-tagline').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 12.px,
          lineHeight: 1.6.em,
          color: const Color('rgba(59,130,246,0.85)'),
          margin: Margin.only(top: 10.px, left: 25.px),
        ),
        // On phones the tagline alone carries the tab; the video says the rest.
        css('.service-desc').styles(
          display: Display.none,
          fontSize: 13.px,
          fontWeight: FontWeight.w300,
          lineHeight: 1.65.em,
          color: const Color('rgba(255,255,255,0.6)'),
          margin: Margin.only(top: 6.px, left: 25.px),
          maxWidth: 440.px,
        ),

        // Playback progress of the active clip, as a hairline under the tab.
        css('.service-progress').styles(
          position: Position.absolute(left: 16.px, right: 16.px, bottom: 8.px),
          height: 2.px,
          raw: {
            'border-radius': '2px',
            'background': 'rgba(255,255,255,0.07)',
            'opacity': '0',
            'transition': 'opacity .3s ease',
            'overflow': 'hidden',
          },
        ),
        css('.service-item.active .service-progress').styles(raw: {'opacity': '1'}),
        css('.service-progress::after').styles(
          content: '""',
          position: Position.absolute(top: Unit.zero, left: Unit.zero, bottom: Unit.zero),
          raw: {
            'width': 'calc(var(--progress, 0) * 100%)',
            'background': 'rgba(59,130,246,0.75)',
            'border-radius': '2px',
          },
        ),

        // ── Player ────────────────────────────────────────────────────────
        css('.services-player').styles(
          raw: {'order': '1', 'min-width': '0'},
        ),
        css('.player-frame').styles(
          width: 100.percent,
          backgroundColor: const Color('#000'),
          border: Border.all(color: const Color('rgba(255,255,255,0.1)'), width: 1.px, style: BorderStyle.solid),
          raw: {
            'position': 'relative',
            'aspect-ratio': '16 / 9',
            'border-radius': '14px',
            'overflow': 'hidden',
            'box-shadow': '0 24px 60px rgba(0,0,0,0.55), 0 0 50px rgba(59,130,246,0.07)',
          },
        ),
        css('.service-video').styles(
          position: Position.absolute(top: Unit.zero, left: Unit.zero),
          width: 100.percent,
          height: 100.percent,
          opacity: 0,
          raw: {
            'object-fit': 'cover',
            'transition': 'opacity .5s ease',
            'pointer-events': 'none',
          },
        ),
        css('.service-video.active').styles(opacity: 1),

        // Sound toggle
        css('.player-sound').styles(
          position: Position.absolute(right: 12.px, bottom: 12.px),
          display: Display.flex,
          alignItems: AlignItems.center,
          gap: Gap.all(8.px),
          padding: Padding.symmetric(horizontal: 14.px, vertical: 9.px),
          color: Colors.white,
          cursor: Cursor.pointer,
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 10.px,
          letterSpacing: 1.5.px,
          textTransform: TextTransform.upperCase,
          zIndex: ZIndex(3),
          raw: {
            'background': 'rgba(10,10,10,0.6)',
            'border': '1px solid rgba(255,255,255,0.18)',
            'border-radius': '999px',
            'backdrop-filter': 'blur(10px)',
            '-webkit-backdrop-filter': 'blur(10px)',
            'transition': 'background .3s ease, border-color .3s ease',
          },
        ),
        css('.player-sound:hover').styles(
          raw: {
            'background': 'rgba(59,130,246,0.25)',
            'border-color': 'rgba(59,130,246,0.6)',
          },
        ),
        css('.sound-dot').styles(
          width: 7.px,
          height: 7.px,
          backgroundColor: const Color('rgba(255,255,255,0.35)'),
          raw: {
            'flex-shrink': '0',
            'border-radius': '50%',
            'transition': 'background .3s ease, box-shadow .3s ease',
          },
        ),
        css('.player-sound.on .sound-dot').styles(
          backgroundColor: const Color('#3b82f6'),
          raw: {'box-shadow': '0 0 8px rgba(59,130,246,0.8)'},
        ),

        // ── Desktop ───────────────────────────────────────────────────────
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.services').styles(
            padding: Padding.only(left: 240.px, right: 120.px, top: 80.px, bottom: 80.px),
            raw: {'scroll-snap-align': 'start', 'scroll-snap-stop': 'always'},
          ),
          css('.services-header').styles(margin: Margin.only(bottom: 40.px)),
          css('.services-grid').styles(
            gap: Gap.all(56.px),
            raw: {'grid-template-columns': 'minmax(0, 0.9fr) minmax(0, 1.1fr)'},
          ),
          css('.service-item').styles(
            padding: Padding.symmetric(horizontal: 16.px, vertical: 14.px),
          ),
          css('.service-desc').styles(display: Display.block),
          css('.services-list').styles(raw: {'order': '1'}),
          css('.services-player').styles(raw: {'order': '2'}),
          // Cap by width (ratio drives height) so the frame never outgrows
          // the viewport on short laptop screens.
          css('.player-frame').styles(
            raw: {'max-width': 'calc(62vh * 16 / 9)', 'margin-left': 'auto'},
          ),
          css('.service-title').styles(fontSize: 19.px),
        ]),
      ];
}
