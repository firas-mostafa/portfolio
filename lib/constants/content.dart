// ============================================================
// Portfolio content — edit everything from here.
// Firas Mostafa — Full-Stack & AI Engineer
// ============================================================

class Profile {
  static const name = 'FIRAS MOSTAFA';
  static const roleLine1 = 'FULL-STACK';
  static const roleLine2 = '& AI ENGINEER';
  static const tagline =
      'I build intelligent applications end-to-end — from Flutter mobile clients '
      'to Django backends and production ML & LLM systems.';

  static const email = 'firassmostafa15@gmail.com';
  static const cvPath = 'cv.pdf';
  static const github = 'https://github.com/firas-mostafa';
  static const linkedin = 'https://linkedin.com/in/firasmostafa';
  static const location = 'Damascus, Syria';
  static const availability = 'Open to remote Full-Stack / Backend / AI roles.';
}

// Technical stack shown in the "Technical Stack" section.
class StackItem {
  final String index;
  final String title;
  final String desc;
  const StackItem(this.index, this.title, this.desc);
}

const technicalStack = <StackItem>[
  StackItem(
    '01',
    'AI & Machine Learning',
    'LangChain, RAG pipelines, PyTorch, and gradient-boosting ensembles '
        '(XGBoost / LightGBM / CatBoost) — trained and shipped in real products.',
  ),
  StackItem(
    '02',
    'Backend Engineering',
    'Django & DRF with async architecture: WebSockets (Channels), Celery, '
        'Redis, PostgreSQL, and Docker.',
  ),
  StackItem(
    '03',
    'Cross-Platform Mobile',
    'Flutter with BLoC and Clean Architecture — polished, production-grade '
        'apps from a single codebase.',
  ),
];

class Project {
  final String index;
  final String name;
  final String desc;
  final List<String> tech;
  final String? link;
  final String media;       // video path or primary image
  final List<String> gallery; // list of image slides
  final bool isVideo;

  const Project({
    required this.index,
    required this.name,
    required this.desc,
    required this.tech,
    this.link,
    this.media = '',
    this.gallery = const [],
    this.isVideo = false,
  });
}

const projects = <Project>[
  Project(
    index: '01',
    name: 'Ursa',
    desc:
        'An AI-driven health companion and smart triage platform. Users describe '
        'symptoms in natural language; the system analyzes them against habits and '
        'wearable vitals, then triages the case and generates a documented medical '
        'report. Built two ML models — a diagnosis ensemble (246K+ records, 721 '
        'conditions, 98% Top-5) and a triage model (94% critical-case recall) — '
        'plus a medical RAG pipeline with strict safety guardrails.',
    tech: ['Flutter', 'Django', 'PyTorch', 'LangChain', 'RAG', 'PostgreSQL', 'Docker'],
    link: null,
    media: 'videos/ursa-demo.mp4',
    isVideo: true,
  ),
  Project(
    index: '02',
    name: 'TasteCraft AI',
    desc:
        'A full-stack AI culinary and nutrition platform: smart recipe discovery, '
        'automated calorie tracking, personalized meal planning, and a voice-enabled '
        'AI chatbot — with full Arabic/English (RTL/LTR) support.',
    tech: ['Flutter', 'Django REST', 'JWT', 'LangChain', 'Docker'],
    link: 'https://github.com/firas-mostafa/tastecraft-ai',
    media: 'images/tastecraft/slide_1.png',
    gallery: [
      'images/tastecraft/slide_1.png',
      'images/tastecraft/slide_2.png',
      'images/tastecraft/slide_3.png',
      'images/tastecraft/slide_4.png',
      'images/tastecraft/slide_5.png',
      'images/tastecraft/slide_6.png',
      'images/tastecraft/slide_7.png',
      'images/tastecraft/slide_8.png',
      'images/tastecraft/slide_9.png',
      'images/tastecraft/slide_10.png',
    ],
    isVideo: false,
  ),
  Project(
    index: '03',
    name: 'AgriSphere',
    desc:
        'A machine-learning application that serves farmers: guidance on optimal '
        'planting times and diagnosis of plant diseases from data, helping improve '
        'yield and reduce crop loss.',
    tech: ['Flutter', 'Machine Learning', 'Laravel', 'MySQL', 'React'],
    link: 'https://github.com/firas-mostafa/agri_sphere',
    media: 'images/agrisphere/slide_1.png',
    gallery: [
      'images/agrisphere/slide_1.png',
      'images/agrisphere/slide_2.png',
      'images/agrisphere/slide_3.png',
      'images/agrisphere/slide_4.png',
      'images/agrisphere/slide_5.png',
      'images/agrisphere/slide_6.png',
    ],
    isVideo: false,
  ),
];
