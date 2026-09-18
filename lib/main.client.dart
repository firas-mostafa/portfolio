/// The entrypoint for the **client** environment.
library;

import 'dart:async';
import 'dart:js_interop';
import 'dart:math';

import 'package:jaspr/client.dart';
import 'package:web/web.dart' as web;

import 'main.client.options.dart';

void main() {
  Jaspr.initializeApp(
    options: defaultClientOptions,
  );

  runApp(const ClientApp());

  // Start the interactive particle background once the DOM is ready.
  _startParticles();

  // Start automatic image carousels for projects.
  _startCarousels();
}

void _startCarousels() {
  Timer.periodic(const Duration(seconds: 4), (timer) {
    final containers = web.document.querySelectorAll('.carousel-container');
    for (var i = 0; i < containers.length; i++) {
      final container = containers.item(i) as web.Element?;
      if (container == null) continue;
      _advanceCarousel(container, 1);
    }
  });

  void setupHandlers() {
    final prevBtns = web.document.querySelectorAll('.carousel-prev');
    for (var i = 0; i < prevBtns.length; i++) {
      final btn = prevBtns.item(i) as web.Element?;
      btn?.addEventListener('click', ((web.Event e) {
        e.preventDefault();
        final container = (e.currentTarget as web.Element?)?.closest('.carousel-container');
        if (container != null) _advanceCarousel(container, -1);
      }).toJS);
    }

    final nextBtns = web.document.querySelectorAll('.carousel-next');
    for (var i = 0; i < nextBtns.length; i++) {
      final btn = nextBtns.item(i) as web.Element?;
      btn?.addEventListener('click', ((web.Event e) {
        e.preventDefault();
        final container = (e.currentTarget as web.Element?)?.closest('.carousel-container');
        if (container != null) _advanceCarousel(container, 1);
      }).toJS);
    }

    final dots = web.document.querySelectorAll('.carousel-indicators .dot');
    for (var i = 0; i < dots.length; i++) {
      final dot = dots.item(i) as web.Element?;
      dot?.addEventListener('click', ((web.Event e) {
        final dotEl = e.currentTarget as web.Element?;
        if (dotEl == null) return;
        final indexStr = dotEl.getAttribute('data-index');
        if (indexStr == null) return;
        final targetIndex = int.tryParse(indexStr);
        if (targetIndex == null) return;
        final container = dotEl.closest('.carousel-container');
        if (container != null) _goToSlide(container, targetIndex);
      }).toJS);
    }
  }

  Timer(const Duration(milliseconds: 200), setupHandlers);
}

void _advanceCarousel(web.Element container, int direction) {
  final slides = container.querySelectorAll('.carousel-slide');
  if (slides.length <= 1) return;

  var activeIndex = 0;
  for (var j = 0; j < slides.length; j++) {
    final slide = slides.item(j) as web.Element?;
    if (slide != null && slide.classList.contains('active')) {
      activeIndex = j;
      break;
    }
  }

  final nextIndex = (activeIndex + direction) % slides.length;
  final finalIndex = nextIndex < 0 ? slides.length - 1 : nextIndex;

  _goToSlide(container, finalIndex);
}

void _goToSlide(web.Element container, int targetIndex) {
  final slides = container.querySelectorAll('.carousel-slide');
  final dots = container.querySelectorAll('.dot');

  for (var j = 0; j < slides.length; j++) {
    final slide = slides.item(j) as web.Element?;
    final dot = dots.item(j) as web.Element?;
    if (j == targetIndex) {
      slide?.classList.add('active');
      dot?.classList.add('active');
    } else {
      slide?.classList.remove('active');
      dot?.classList.remove('active');
    }
  }
}

class _Particle {
  double x, y, size, sx, sy, op;
  double? life;
  final double decay;
  _Particle(this.x, this.y, this.size, this.sx, this.sy, this.op, this.life, this.decay);
}

void _startParticles() {
  final rnd = Random();

  void run() {
    final canvas = web.document.getElementById('bg-canvas') as web.HTMLCanvasElement?;
    if (canvas == null) {
      Timer(const Duration(milliseconds: 100), run);
      return;
    }
    
    final ctx = canvas.getContext('2d') as web.CanvasRenderingContext2D;
    const count = 110;
    final particles = <_Particle>[];
    double? mouseX, mouseY;

    _Particle make({double? x, double? y, bool trail = false}) {
      return _Particle(
        x ?? rnd.nextDouble() * canvas.width,
        y ?? rnd.nextDouble() * canvas.height,
        trail ? rnd.nextDouble() * 1.5 + 0.5 : rnd.nextDouble() * 2 + 1,
        (rnd.nextDouble() - 0.5) * 0.7,
        (rnd.nextDouble() - 0.5) * 0.7,
        trail ? 1 : rnd.nextDouble() * 0.5 + 0.2,
        trail ? 1 : null,
        rnd.nextDouble() * 0.02 + 0.01,
      );
    }

    void init() {
      particles.clear();
      for (var i = 0; i < count; i++) {
        particles.add(make());
      }
    }

    void resize() {
      final rect = canvas.getBoundingClientRect();
      var w = rect.width.round();
      var h = rect.height.round();
      if (w <= 0) w = web.window.innerWidth;
      if (h <= 0) h = web.window.innerHeight;
      canvas.width = w;
      canvas.height = h;
      init();
    }

    web.window.addEventListener('resize', ((web.Event _) => resize()).toJS);
    web.window.addEventListener('mousemove', ((web.MouseEvent e) {
      mouseX = e.clientX.toDouble();
      mouseY = e.clientY.toDouble();
      for (var i = 0; i < 2; i++) {
        particles.add(make(x: mouseX, y: mouseY, trail: true));
      }
    }).toJS);

    late final web.FrameRequestCallback loopJS;
    void loop(double _) {
      final w = canvas.width, h = canvas.height;
      ctx.clearRect(0, 0, w, h);

      final cx = mouseX ?? w / 2, cy = mouseY ?? h / 2;
      final grad = ctx.createRadialGradient(cx, cy, 0, cx, cy, 600);
      grad.addColorStop(0, '#1a1a1a');
      grad.addColorStop(1, '#131313');
      ctx.fillStyle = grad as JSAny;
      ctx.fillRect(0, 0, w, h);

      for (var i = 0; i < particles.length; i++) {
        final p = particles[i];
        p.x += p.sx;
        p.y += p.sy;
        if (p.life != null) {
          p.life = p.life! - p.decay;
        } else {
          if (p.x > w || p.x < 0) p.sx *= -1;
          if (p.y > h || p.y < 0) p.sy *= -1;
        }

        final alpha = p.life != null ? p.life! * 0.8 : p.op;
        ctx.fillStyle = 'rgba(255,255,255,$alpha)'.toJS;
        ctx.beginPath();
        ctx.arc(p.x, p.y, p.size, 0, pi * 2);
        ctx.fill();

        for (var j = i + 1; j < particles.length; j++) {
          final q = particles[j];
          final dx = p.x - q.x, dy = p.y - q.y;
          final dist = sqrt(dx * dx + dy * dy);
          if (dist < 100) {
            ctx.strokeStyle = 'rgba(255,255,255,${0.1 * (1 - dist / 100)})'.toJS;
            ctx.lineWidth = 0.5;
            ctx.beginPath();
            ctx.moveTo(p.x, p.y);
            ctx.lineTo(q.x, q.y);
            ctx.stroke();
          }
        }

        if (p.life != null && p.life! <= 0) {
          particles.removeAt(i);
          i--;
        }
      }
      web.window.requestAnimationFrame(loopJS);
    }

    loopJS = loop.toJS;
    resize();
    web.window.requestAnimationFrame(loopJS);
  }

  run();
}
