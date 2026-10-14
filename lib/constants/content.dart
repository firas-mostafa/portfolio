// ============================================================
// Portfolio content — edit everything from here.
// Firas Mostafa — Full-Stack & AI Engineer
// ============================================================

class CvOption {
  final String title;
  final String role;
  final String path;
  final String fileName;

  const CvOption({
    required this.title,
    required this.role,
    required this.path,
    required this.fileName,
  });
}

class Profile {
  static const name = 'FIRAS MOSTAFA';
  static const roleLine1 = 'FULL-STACK';
  static const roleLine2 = '& AI ENGINEER';
  static const tagline =
      'I build complete applications: Flutter apps on the front, Django APIs '
      'behind them, and the machine-learning and LLM systems that power them.';

  static const email = 'firassmostafa15@gmail.com';
  static const github = 'https://github.com/firas-mostafa';
  static const linkedin = 'https://linkedin.com/in/firasmostafa';
  static const location = 'Damascus, Syria';
  static const availability = 'Open to remote and on-site roles in AI, backend, and Flutter development.';

  static const cvOptions = <CvOption>[
    CvOption(
      title: 'Full-Stack & AI Engineer',
      role: 'Full-Stack & AI Engineering',
      path: 'Firas_Mostafa_Full_Stack_AI_Engineer.pdf',
      fileName: 'Firas_Mostafa_Full_Stack_AI_Engineer.pdf',
    ),
    CvOption(
      title: 'AI & Backend Developer',
      role: 'AI, Python & Backend Architecture',
      path: 'Firas_Mostafa_AI_Backend_Developer.pdf',
      fileName: 'Firas_Mostafa_AI_Backend_Developer.pdf',
    ),
    CvOption(
      title: 'Flutter Developer',
      role: 'Cross-Platform Mobile (Android & iOS)',
      path: 'Firas_Mostafa_Flutter_Developer.pdf',
      fileName: 'Firas_Mostafa_Flutter_Developer.pdf',
    ),
  ];
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
    'Training PyTorch and gradient-boosting models (XGBoost, LightGBM, CatBoost) '
        'and building RAG pipelines with LangChain, local LLMs and pgvector vector search.',
  ),
  StackItem(
    '02',
    'Backend Engineering',
    'Django and DRF with async ASGI architecture, WebSockets (Channels), Celery '
        'and Redis for background work, PostgreSQL, and Docker-based deployment.',
  ),
  StackItem(
    '03',
    'Cross-Platform Mobile',
    'Flutter apps with Clean Architecture and BLoC, integrated with REST APIs, '
        'WebSockets and Firebase — one codebase for Android and iOS.',
  ),
];

class Project {
  final String index;
  final String name;
  final String desc;
  final List<String> tech;
  final String? link;
  final String? buttonText;
  final String media; // video path or primary image
  final List<String> gallery; // list of image slides
  final bool isVideo;

  const Project({
    required this.index,
    required this.name,
    required this.desc,
    required this.tech,
    this.link,
    this.buttonText,
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
        'their symptoms in Arabic or English; the system analyzes them against '
        'their habits and wearable vitals, assesses urgency, and generates a '
        'documented medical report. Built two ML models — a diagnosis ensemble '
        '(246K records, 721 conditions, 86% Top-1 / 96% Top-3 accuracy) and a '
        'triage model (94% recall on critical cases) — plus a medical RAG pipeline '
        'with strict safety guardrails. Designed and built solo as my graduation thesis.',
    tech: ['Flutter', 'Django', 'PyTorch', 'LangChain', 'RAG', 'PostgreSQL', 'Docker'],
    link: 'https://youtu.be/WBz_ei6zKjU',
    buttonText: 'Watch on YouTube →',
    media: 'videos/ursa-demo.mp4',
    isVideo: true,
  ),
  Project(
    index: '02',
    name: 'TasteCraft AI',
    desc:
        'A full-stack AI cooking and nutrition platform: recipe discovery, calorie '
        'tracking, meal planning, and a voice-enabled chatbot, with full Arabic and '
        'English support (RTL/LTR). A Flutter app backed by a Django REST API with '
        'JWT authentication, built test-first and containerized with Docker.',
    tech: ['Flutter', 'Django REST', 'JWT', 'LangChain', 'Docker'],
    link: 'https://github.com/firas-mostafa/tastecraft-ai',
    buttonText: 'View on GitHub →',
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
        'A smart agriculture app that helps farmers decide when to plant and diagnose '
        'plant diseases in the field, using machine-learning models to improve yield '
        'and reduce crop loss. Built as a team project, where I developed the Flutter '
        'mobile app and its integration with the backend APIs.',
    tech: ['Flutter', 'Machine Learning', 'Laravel', 'MySQL', 'React'],
    link: 'https://github.com/firas-mostafa/agri_sphere',
    buttonText: 'View on GitHub →',
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
