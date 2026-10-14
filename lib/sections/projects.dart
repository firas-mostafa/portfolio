import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../constants/content.dart';

// Each project becomes its own full-screen section for proper scroll-snap.
class ProjectSection extends StatelessComponent {
  final Project project;
  const ProjectSection({required this.project, super.key});

  @override
  Component build(BuildContext context) {
    final hasGallery = project.gallery.isNotEmpty;
    // Match the ambient glow to each project's existing accent color.
    final glow = project.index == '01'
        ? 'rgba(0,210,255,0.06)'
        : project.index == '02'
            ? 'rgba(0,200,180,0.06)'
            : 'rgba(0,230,118,0.06)';

    return section(
        id: 'project-${project.index}',
        classes: 'project-section',
        attributes: {'data-glow': glow}, [
      div(classes: 'project-card', [
        div(classes: 'project-row', [
          // Text column
          div(classes: 'project-info', [
            span(classes: 'project-index', [Component.text(project.index)]),
            h3(classes: 'project-name', [Component.text(project.name)]),
            p(classes: 'project-desc', [Component.text(project.desc)]),
            if (project.stats.isNotEmpty)
              div(classes: 'project-stats', [
                for (final s in project.stats)
                  div(classes: 'stat', [
                    div(classes: 'stat-num', [
                      span(
                        classes: 'stat-value',
                        attributes: {'data-target': '${s.value}'},
                        [Component.text('${s.value}')],
                      ),
                      if (s.suffix.isNotEmpty)
                        span(classes: 'stat-suffix', [Component.text(s.suffix)]),
                    ]),
                    span(classes: 'stat-label', [Component.text(s.label)]),
                  ]),
              ]),
            div(classes: 'project-tech', [
              for (final t in project.tech) span(classes: 'tech-chip', [Component.text(t)]),
            ]),
            if (project.link != null)
              a(href: project.link!, target: Target.blank, classes: 'project-link', [
                Component.text(project.buttonText ?? 'View on GitHub →'),
              ]),
          ]),
          
          // Media column (phone frame with Carousel or Video)
          div(classes: 'project-media', [
            div(classes: 'phone-float', [
            div(classes: 'phone-frame', [
              if (project.isVideo)
                video(
                  classes: 'phone-media video-fit',
                  poster: project.media.replaceAll('.mp4', '-poster.jpg'),
                  preload: Preload.metadata,
                  autoplay: true,
                  loop: true,
                  muted: true,
                  attributes: {'playsinline': ''},
                  [
                    source(src: project.media.replaceAll('.mp4', '.webm'), type: 'video/webm'),
                    source(src: project.media, type: 'video/mp4'),
                  ],
                )
              else if (hasGallery)
                _buildGalleryCarousel(project)
              else if (project.media.isNotEmpty)
                img(classes: 'phone-media image-fit', src: project.media, alt: '${project.name} preview')
              else
                div(classes: 'phone-placeholder', [Component.text(project.name)])
            ]),
              // Soft ground shadow that shrinks as the phone floats up.
              div(classes: 'phone-shadow', []),
            ]),
          ]),
        ]),
      ]),
    ]);
  }

  Component _buildGalleryCarousel(Project proj) {
    final carouselId = 'carousel-${proj.index}';
    return div(
      id: carouselId,
      classes: 'carousel-container',
      attributes: {'data-count': '${proj.gallery.length}', 'data-index': '0'},
      [
        // Slides
        div(classes: 'carousel-slides', [
          for (var i = 0; i < proj.gallery.length; i++)
            img(
              classes: 'carousel-slide ${i == 0 ? 'active' : ''}',
              src: proj.gallery[i],
              alt: '${proj.name} slide ${i + 1}',
            )
        ]),
        
        // Navigation arrows
        if (proj.gallery.length > 1) ...[
          button(
            classes: 'carousel-btn carousel-prev',
            attributes: {'aria-label': 'Previous slide'},
            [Component.text('‹')],
          ),
          button(
            classes: 'carousel-btn carousel-next',
            attributes: {'aria-label': 'Next slide'},
            [Component.text('›')],
          ),
        ],
        
        // Indicators (dots)
        div(classes: 'carousel-indicators', [
          for (var i = 0; i < proj.gallery.length; i++)
            span(
              classes: 'dot ${i == 0 ? 'active' : ''}',
              attributes: {'data-index': '$i'},
              [],
            ),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
        // Section container - full screen
        css('.project-section').styles(
          minHeight: 100.vh,
          display: Display.flex,
          flexDirection: FlexDirection.column,
          justifyContent: JustifyContent.center,
          padding: Padding.symmetric(horizontal: 24.px, vertical: 60.px),
          raw: {
            'box-sizing': 'border-box',
          },
        ),
        
        css('.project-card').styles(
          width: 100.percent,
          maxWidth: 1100.px,
          raw: {'margin-left': 'auto', 'margin-right': 'auto'},
        ),
        
        css('.project-row').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(40.px),
          alignItems: AlignItems.center,
          width: 100.percent,
        ),
        
        css('.project-index').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 14.px,
          color: const Color('rgba(255,255,255,0.6)'),
          display: Display.block,
          margin: Margin.only(bottom: 12.px),
        ),
        
        css('.project-name').styles(
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontWeight: FontWeight.w800,
          fontSize: 36.px,
          letterSpacing: (-1).px,
          margin: Margin.zero,
          color: Colors.white,
        ),
        
        css('.project-desc').styles(
          fontSize: 15.px,
          fontWeight: FontWeight.w300,
          lineHeight: 1.6.em,
          color: const Color('rgba(255,255,255,0.65)'),
          margin: Margin.only(top: 16.px, bottom: 20.px),
          maxWidth: 520.px,
        ),

        // Stat counters — big accent numbers that count up when scrolled into view.
        // 2×2 on mobile, a row of four on desktop (see media query below).
        css('.project-stats').styles(
          display: Display.grid,
          gap: Gap.all(20.px),
          maxWidth: 520.px,
          margin: Margin.only(bottom: 28.px),
          raw: {'grid-template-columns': 'repeat(2, 1fr)'},
        ),
        css('.stat').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(6.px),
        ),
        css('.stat-num').styles(
          display: Display.flex,
          alignItems: AlignItems.baseline,
          raw: {
            'font-family': "'Montserrat', sans-serif",
            'font-weight': '900',
            'line-height': '1',
            'font-variant-numeric': 'tabular-nums',
          },
        ),
        css('.stat-value, .stat-suffix').styles(
          color: Colors.white,
          raw: {
            'font-size': 'clamp(2rem, 5vw, 2.75rem)',
            'font-variant-numeric': 'tabular-nums',
          },
        ),
        css('.stat-suffix').styles(
          margin: Margin.only(left: 2.px),
        ),
        css('.stat-label').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 11.px,
          letterSpacing: 1.px,
          textTransform: TextTransform.upperCase,
          color: const Color('rgba(255,255,255,0.6)'),
        ),
        // Tint the numbers with the project's accent color (Ursa = cyan).
        css('#project-01 .stat-value, #project-01 .stat-suffix').styles(
          raw: {'color': 'rgba(0, 210, 255, 0.92)'},
        ),
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.project-stats').styles(
            maxWidth: 560.px,
            raw: {'grid-template-columns': 'repeat(4, 1fr)'},
          ),
        ]),

        css('.project-tech').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(8.px),
        ),
        
        css('.tech-chip').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 11.px,
          padding: Padding.symmetric(horizontal: 12.px, vertical: 6.px),
          border: Border.all(color: const Color('rgba(255,255,255,0.2)'), width: 1.px, style: BorderStyle.solid),
          color: const Color('rgba(255,255,255,0.85)'),
          raw: {'border-radius': '999px', 'background': 'rgba(255,255,255,0.03)'},
        ),
        
        css('.project-link').styles(
          display: Display.inlineBlock,
          margin: Margin.only(top: 24.px),
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 13.px,
          color: Colors.white,
          textDecoration: const TextDecoration(line: TextDecorationLine.underline),
          raw: {'transition': 'opacity 0.3s'},
        ),
        
        css('.project-link:hover').styles(
          raw: {'opacity': '0.7'},
        ),
        
        // Phone frame - responsive mobile default.
        // The frame takes the media's aspect ratio (--media-ratio) so the
        // content fills it edge-to-edge with no black letterboxing.
        css('.phone-frame').styles(
          width: 295.px,
          padding: Padding.all(10.px),
          border: Border.all(color: const Color('rgba(255,255,255,0.25)'), width: 2.px, style: BorderStyle.solid),
          backgroundColor: const Color('#080808'),
          raw: {
            'max-width': '100%',
            'aspect-ratio': 'var(--media-ratio, 9 / 20)',
            'border-radius': '38px',
            // Transform is driven by the JS tilt (rAF + lerp); only animate
            // the hover glow here so the two don't fight.
            'transition': 'border-color .4s ease, box-shadow .4s ease',
            'box-shadow': '0 20px 50px rgba(0,0,0,0.6)',
            'position': 'relative',
            'overflow': 'hidden',
            'transform-style': 'preserve-3d',
          },
        ),

        css('.phone-frame:hover').styles(
          border: Border.all(color: Colors.white, width: 2.px, style: BorderStyle.solid),
        ),

        // Floating wrapper carries the idle float; perspective enables the
        // child frame's 3D tilt. Shadow counter-animates to stay grounded.
        css('.project-media').styles(
          raw: {
            'position': 'relative',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
          },
        ),
        css('.phone-float').styles(
          raw: {
            'position': 'relative',
            'display': 'inline-block',
            'z-index': '1',
            'perspective': '1200px',
            'will-change': 'transform',
            'animation': 'phone-float 6s ease-in-out infinite',
          },
        ),
        css('.phone-shadow').styles(
          raw: {
            'position': 'absolute',
            'bottom': '-30px',
            'left': '50%',
            'width': '62%',
            'height': '28px',
            'background': 'radial-gradient(ellipse at center, rgba(0,0,0,0.6) 0%, transparent 72%)',
            'filter': 'blur(7px)',
            'opacity': '0.5',
            'pointer-events': 'none',
            'z-index': '-1',
            'transform': 'translateX(-50%) scale(1)',
            'animation': 'phone-shadow 6s ease-in-out infinite',
          },
        ),
        css.keyframes('phone-float', {
          '0%': const Styles(raw: {'transform': 'translateY(0)'}),
          '50%': const Styles(raw: {'transform': 'translateY(-12px)'}),
          '100%': const Styles(raw: {'transform': 'translateY(0)'}),
        }),
        css.keyframes('phone-shadow', {
          '0%': const Styles(raw: {'transform': 'translateX(-50%) translateY(0) scale(1)', 'opacity': '0.5'}),
          '50%': const Styles(raw: {'transform': 'translateX(-50%) translateY(12px) scale(0.88)', 'opacity': '0.32'}),
          '100%': const Styles(raw: {'transform': 'translateX(-50%) translateY(0) scale(1)', 'opacity': '0.5'}),
        }),
        
        css('.phone-media').styles(
          width: 100.percent,
          height: 100.percent,
          raw: {'border-radius': '28px', 'background': '#000'},
        ),
        
        css('.video-fit').styles(
          raw: {'object-fit': 'cover'},
        ),

        css('.image-fit').styles(
          raw: {'object-fit': 'cover'},
        ),
        
        // Carousel styling
        css('.carousel-container').styles(
          width: 100.percent,
          height: 100.percent,
          position: Position.relative(),
          raw: {'border-radius': '28px', 'overflow': 'hidden', 'background': '#000'},
        ),
        
        css('.carousel-slides').styles(
          width: 100.percent,
          height: 100.percent,
          position: Position.relative(),
        ),
        
        css('.carousel-slide').styles(
          width: 100.percent,
          height: 100.percent,
          position: Position.absolute(top: Unit.zero, left: Unit.zero),
          opacity: 0,
          raw: {
            'object-fit': 'cover',
            'transition': 'opacity 0.8s ease-in-out',
            'pointer-events': 'none',
          },
        ),
        
        css('.carousel-slide.active').styles(
          opacity: 1,
          raw: {'pointer-events': 'auto'},
        ),
        
        // Navigation arrows
        css('.carousel-btn').styles(
          width: 40.px,
          height: 40.px,
          backgroundColor: const Color('rgba(0,0,0,0.5)'),
          color: Colors.white,
          fontSize: 24.px,
          cursor: Cursor.pointer,
          raw: {
            'position': 'absolute',
            'top': '50%',
            'z-index': '10',
            'border': 'none',
            'transform': 'translateY(-50%)',
            'border-radius': '50%',
            'transition': 'all 0.3s ease',
            'backdrop-filter': 'blur(4px)',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
          },
        ),
        
        css('.carousel-prev').styles(
          raw: {'left': '8px'},
        ),
        
        css('.carousel-next').styles(
          raw: {'right': '8px'},
        ),
        
        css('.carousel-btn:hover').styles(
          backgroundColor: const Color('rgba(255,255,255,0.9)'),
          color: const Color('#000'),
        ),
        
        // Indicators (dots) - default inside frame
        css('.carousel-indicators').styles(
          position: Position.absolute(bottom: 12.px, left: Unit.zero, right: Unit.zero),
          display: Display.flex,
          justifyContent: JustifyContent.center,
          gap: Gap.all(6.px),
          zIndex: ZIndex(5),
        ),
        
        // Move indicators outside frame for projects 02 & 03
        css('.project-section:nth-child(5) .carousel-indicators, .project-section:nth-child(6) .carousel-indicators').styles(
          raw: {
            'position': 'static',
            'margin-top': '16px',
          },
        ),
        
        css('.carousel-indicators .dot').styles(
          width: 6.px,
          height: 6.px,
          backgroundColor: const Color('rgba(255,255,255,0.3)'),
          cursor: Cursor.pointer,
          raw: {'border-radius': '50%', 'transition': 'all 0.3s ease'},
        ),
        
        css('.carousel-indicators .dot:hover').styles(
          backgroundColor: const Color('rgba(255,255,255,0.6)'),
        ),
        
        css('.carousel-indicators .dot.active').styles(
          width: 18.px,
          backgroundColor: Colors.white,
          raw: {'border-radius': '10px'},
        ),
        
        // Phone Placeholder
        css('.phone-placeholder').styles(
          width: 100.percent,
          height: 100.percent,
          display: Display.flex,
          alignItems: AlignItems.center,
          justifyContent: JustifyContent.center,
          backgroundColor: const Color('#1a1a1a'),
          color: const Color('rgba(255,255,255,0.4)'),
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontWeight: FontWeight.w700,
          raw: {'border-radius': '28px'},
        ),
        
        // Responsive Desktop layout
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.project-section').styles(
            padding: Padding.only(left: 240.px, right: 120.px, top: 80.px, bottom: 80.px),
            raw: {
              'scroll-snap-align': 'start',
              'scroll-snap-stop': 'always',
            },
          ),
          
          css('.project-row').styles(
            flexDirection: FlexDirection.row,
            gap: Gap.all(80.px),
            justifyContent: JustifyContent.spaceBetween,
          ),
          
          css('.project-info').styles(
            flex: Flex(grow: 1),
          ),
          
          css('.project-name').styles(
            fontSize: 48.px,
          ),
          
          css('.phone-frame').styles(
            padding: Padding.all(12.px),
            // Constrain by height so the phone fits short laptops; width is
            // derived from the media aspect ratio (set on base rule).
            raw: {'border-radius': '44px', 'width': 'auto', 'height': 'min(760px, 78vh)', 'max-width': '100%'},
          ),
          
          css('.phone-media').styles(
            raw: {'border-radius': '32px'},
          ),
          
          css('.carousel-container').styles(
            raw: {'border-radius': '32px'},
          ),

          css('.phone-placeholder').styles(
            raw: {'border-radius': '32px'},
          ),
          
          // Make project 02 (TasteCraft) reverse layout
          css('.project-section:nth-child(5) .project-row').styles(
            raw: {'flex-direction': 'row-reverse'},
          ),
        ]),

        // ── Brand ambient glow per project page ──────────────────────────
        // Project 01 – Ursa (Cyan)
        css('#project-01').styles(
          raw: {
            '--media-ratio': '720 / 1600',
            'background': 'radial-gradient(ellipse 80% 60% at 15% 0%, rgba(0, 210, 255, 0.07) 0%, transparent 65%)',
          },
        ),
        css('#project-01 .project-index').styles(
          color: const Color('rgba(0, 210, 255, 0.7)'),
        ),
        css('#project-01 .project-name').styles(
          raw: {
            'background': 'linear-gradient(135deg, #ffffff 60%, rgba(0, 210, 255, 0.7) 100%)',
            '-webkit-background-clip': 'text',
            '-webkit-text-fill-color': 'transparent',
            'background-clip': 'text',
          },
        ),
        css('#project-01 .phone-frame').styles(
          raw: {
            'border-color': 'rgba(0, 210, 255, 0.3)',
            'box-shadow': '0 20px 60px rgba(0, 0, 0, 0.6), 0 0 60px rgba(0, 210, 255, 0.1)',
          },
        ),
        css('#project-01 .phone-frame:hover').styles(
          raw: {
            'border-color': 'rgba(0, 210, 255, 0.6)',
            'box-shadow': '0 25px 80px rgba(0, 0, 0, 0.7), 0 0 80px rgba(0, 210, 255, 0.18)',
          },
        ),

        // Project 02 – TasteCraft AI (Teal)
        css('#project-02').styles(
          raw: {
            '--media-ratio': '373 / 786',
            'background': 'radial-gradient(ellipse 80% 60% at 85% 0%, rgba(0, 200, 180, 0.07) 0%, transparent 65%)',
          },
        ),
        css('#project-02 .project-index').styles(
          color: const Color('rgba(0, 200, 180, 0.7)'),
        ),
        css('#project-02 .project-name').styles(
          raw: {
            'background': 'linear-gradient(135deg, #ffffff 60%, rgba(0, 200, 180, 0.7) 100%)',
            '-webkit-background-clip': 'text',
            '-webkit-text-fill-color': 'transparent',
            'background-clip': 'text',
          },
        ),
        css('#project-02 .phone-frame').styles(
          raw: {
            'border-color': 'rgba(0, 200, 180, 0.3)',
            'box-shadow': '0 20px 60px rgba(0, 0, 0, 0.6), 0 0 60px rgba(0, 200, 180, 0.1)',
          },
        ),
        css('#project-02 .phone-frame:hover').styles(
          raw: {
            'border-color': 'rgba(0, 200, 180, 0.6)',
            'box-shadow': '0 25px 80px rgba(0, 0, 0, 0.7), 0 0 80px rgba(0, 200, 180, 0.18)',
          },
        ),

        // Project 03 – AgriSphere (Emerald)
        css('#project-03').styles(
          raw: {
            '--media-ratio': '720 / 1600',
            'background': 'radial-gradient(ellipse 80% 60% at 15% 0%, rgba(0, 230, 118, 0.07) 0%, transparent 65%)',
          },
        ),
        css('#project-03 .project-index').styles(
          color: const Color('rgba(0, 230, 118, 0.7)'),
        ),
        css('#project-03 .project-name').styles(
          raw: {
            'background': 'linear-gradient(135deg, #ffffff 60%, rgba(0, 230, 118, 0.7) 100%)',
            '-webkit-background-clip': 'text',
            '-webkit-text-fill-color': 'transparent',
            'background-clip': 'text',
          },
        ),
        css('#project-03 .phone-frame').styles(
          raw: {
            'border-color': 'rgba(0, 230, 118, 0.3)',
            'box-shadow': '0 20px 60px rgba(0, 0, 0, 0.6), 0 0 60px rgba(0, 230, 118, 0.1)',
          },
        ),
        css('#project-03 .phone-frame:hover').styles(
          raw: {
            'border-color': 'rgba(0, 230, 118, 0.6)',
            'box-shadow': '0 25px 80px rgba(0, 0, 0, 0.7), 0 0 80px rgba(0, 230, 118, 0.18)',
          },
        ),
      ];
}
