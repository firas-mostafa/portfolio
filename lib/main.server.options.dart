// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:portfolio/components/particles.dart' as _particles;
import 'package:portfolio/components/side_nav.dart' as _side_nav;
import 'package:portfolio/sections/contact.dart' as _contact;
import 'package:portfolio/sections/hero.dart' as _hero;
import 'package:portfolio/sections/projects.dart' as _projects;
import 'package:portfolio/sections/projects_overview.dart'
    as _projects_overview;
import 'package:portfolio/sections/stack.dart' as _stack;
import 'package:portfolio/app.dart' as _app;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  styles: () => [
    ..._app.App.styles,
    ..._particles.ParticleBackground.styles,
    ..._side_nav.SideNav.styles,
    ..._contact.ContactSection.styles,
    ..._hero.HeroSection.styles,
    ..._projects.ProjectSection.styles,
    ..._projects_overview.ProjectsOverviewSection.styles,
    ..._stack.StackSection.styles,
  ],
);
