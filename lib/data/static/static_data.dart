import '../models/user_model.dart';
import '../models/category_model.dart';
import '../models/lesson_model.dart';
import '../models/section_model.dart';
import '../models/quiz_model.dart';
import '../models/assignment_model.dart';
import '../models/review_model.dart';
import '../models/course_model.dart';
import '../models/certificate_model.dart';
import '../models/notification_model.dart';
import '../models/earnings_model.dart';

class StaticData {
  StaticData._();

  // Demo Users
  static final UserModel adminUser = UserModel(
    id: 1,
    name: 'Super Administrator',
    email: 'admin@learnova.com',
    role: 'admin',
    headline: 'Chief Executive & System Architect',
    avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&auto=format&fit=crop&q=80',
  );

  static final UserModel instructorAlex = UserModel(
    id: 2,
    name: 'Alex Rivera',
    email: 'alex@learnova.com',
    role: 'instructor',
    headline: 'Senior Full-Stack Architect & Google Developer Expert',
    bio: '12+ years of engineering production web and mobile architectures for Fortune 500 companies.',
    avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&auto=format&fit=crop&q=80',
    totalEarnings: 14850.00,
    currentBalance: 3420.50,
  );

  static final UserModel instructorSarah = UserModel(
    id: 3,
    name: 'Sarah Jenkins',
    email: 'sarah@learnova.com',
    role: 'instructor',
    headline: 'Lead Mobile UI/UX & Flutter Platform Engineer',
    bio: 'Specialist in high-performance reactive Flutter systems, design systems, and animations.',
    avatarUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=300&auto=format&fit=crop&q=80',
    totalEarnings: 9600.00,
    currentBalance: 1840.00,
  );

  static final UserModel studentJohn = UserModel(
    id: 4,
    name: 'John Doe',
    email: 'john@learnova.com',
    role: 'student',
    headline: 'Aspiring Full-Stack Software Artisan',
    avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&auto=format&fit=crop&q=80',
  );

  // Categories
  static final List<CategoryModel> categories = [
    CategoryModel(id: 1, name: 'Web Development', slug: 'web-development', icon: 'code', description: 'Full-stack web engineering with modern tools', coursesCount: 5),
    CategoryModel(id: 2, name: 'Mobile App Development', slug: 'mobile-app-development', icon: 'smartphone', description: 'Cross-platform Flutter & iOS/Android development', coursesCount: 3),
    CategoryModel(id: 3, name: 'Laravel Framework', slug: 'laravel', icon: 'layers', description: 'Mastering Laravel 12 ecosystems & Eloquent', coursesCount: 3),
    CategoryModel(id: 4, name: 'UI/UX & Product Design', slug: 'ui-ux-design', icon: 'palette', description: 'Figma design systems and responsive UX', coursesCount: 2),
    CategoryModel(id: 5, name: 'DevOps & Cloud', slug: 'devops', icon: 'cloud', description: 'Docker, CI/CD, Kubernetes and AWS cloud', coursesCount: 2),
  ];

  // 15 Complete Masterclasses
  static final List<CourseModel> courses = [
    CourseModel(
      id: 1,
      title: 'Complete Flutter & Dart Masterclass: Zero to Hero',
      slug: 'complete-flutter-dart-masterclass',
      subtitle: 'Build production-ready cross-platform apps with GetX, Material 3, and Clean Architecture.',
      description: 'Master Flutter and Dart from absolute fundamentals to production deployment. Learn GetX state management, responsive UI design, local databases, custom animations, and automated testing.',
      categoryId: 2,
      category: categories[1],
      instructorId: 3,
      instructor: instructorSarah,
      price: 89.99,
      discountPrice: 49.99,
      level: 'all_levels',
      language: 'English',
      thumbnail: 'https://images.unsplash.com/photo-1551650975-87deedd944c3?w=800&auto=format&fit=crop&q=80',
      previewVideoUrl: 'https://www.youtube.com/watch?v=1gDhl4leEzA',
      status: 'published',
      isFeatured: true,
      isBestseller: true,
      averageRating: 4.9,
      reviewsCount: 342,
      studentsCount: 1420,
      totalDurationMinutes: 480,
      whatWillLearn: [
        'Build real-world cross-platform Flutter applications for iOS, Android, and Web.',
        'Master GetX state management, reactive streams, and dependency injection.',
        'Implement clean MVC and Feature-Based scalable architectures.',
        'Design adaptive, responsive UIs with Material 3 tokens.',
      ],
      requirements: ['Basic programming knowledge in any language', 'Computer with Windows, macOS, or Linux'],
      sections: [
        SectionModel(
          id: 1,
          courseId: 1,
          title: 'Module 1: Flutter & Dart Foundations',
          lessons: [
            LessonModel(id: 1, sectionId: 1, title: 'Welcome & Environment Setup', durationMinutes: 15, isPreview: true, isCompleted: true),
            LessonModel(id: 2, sectionId: 1, title: 'Dart 3 OOP & Null Safety Deep Dive', durationMinutes: 25, isCompleted: true),
            LessonModel(id: 3, sectionId: 1, title: 'Understanding the Widget Tree & BuildContext', durationMinutes: 20, isCompleted: true),
          ],
        ),
        SectionModel(
          id: 2,
          courseId: 1,
          title: 'Module 2: GetX Architecture & State Management',
          lessons: [
            LessonModel(id: 4, sectionId: 2, title: 'GetX Reactive Variables & Obx Widgets', durationMinutes: 30, isCompleted: true),
            LessonModel(id: 5, sectionId: 2, title: 'Dependency Injection with Bindings', durationMinutes: 25, isCompleted: false),
            LessonModel(id: 6, sectionId: 2, title: 'Named Routing & Middleware Transitions', durationMinutes: 20, isCompleted: false),
          ],
        ),
      ],
      quizzes: [
        QuizModel(
          id: 1,
          courseId: 1,
          title: 'Flutter & GetX Architecture Assessment',
          description: 'Test your understanding of Flutter widget lifecycle, GetX controllers, and state management.',
          durationMinutes: 10,
          passPercentage: 70,
          questions: [
            QuizQuestionModel(
              id: 1,
              questionText: 'Which GetX widget automatically rebuilds when its observed variable changes?',
              options: [
                QuizOptionModel(id: 1, optionText: 'Obx()', isCorrect: true),
                QuizOptionModel(id: 2, optionText: 'GetBuilder()', isCorrect: false),
                QuizOptionModel(id: 3, optionText: 'StatefulWidget', isCorrect: false),
                QuizOptionModel(id: 4, optionText: 'InheritedWidget', isCorrect: false),
              ],
            ),
            QuizQuestionModel(
              id: 2,
              questionText: 'What is the primary benefit of using GetX Bindings in Flutter?',
              options: [
                QuizOptionModel(id: 5, optionText: 'Decoupling dependency injection from the UI layer', isCorrect: true),
                QuizOptionModel(id: 6, optionText: 'Compressing app bundle size', isCorrect: false),
                QuizOptionModel(id: 7, optionText: 'Drawing vector graphics', isCorrect: false),
              ],
            ),
          ],
        ),
      ],
      assignments: [
        AssignmentModel(
          id: 1,
          courseId: 1,
          title: 'Capstone: Build an E-Learning Flutter App',
          description: 'Submit your GitHub repository link and architecture document for a responsive LMS app.',
          maxMarks: 100,
          submissionStatus: 'submitted',
          obtainedMarks: 95,
          feedback: 'Outstanding architecture and clean MVC separation!',
        ),
      ],
      reviews: [
        ReviewModel(id: 1, courseId: 1, userName: 'Michael Chen', rating: 5.0, comment: 'Hands down the best Flutter course available.', createdAt: DateTime.now().subtract(const Duration(days: 2))),
        ReviewModel(id: 2, courseId: 1, userName: 'Emily Watson', rating: 4.8, comment: 'The GetX and Clean Architecture modules are gold!', createdAt: DateTime.now().subtract(const Duration(days: 5))),
      ],
      isEnrolled: true,
      progressPercentage: 66.0,
    ),
    CourseModel(
      id: 2,
      title: 'Laravel 12 Pro: Monolithic & API Architectures',
      slug: 'laravel-12-pro-architectures',
      subtitle: 'Build robust enterprise web platforms with Laravel 12, Blade, Eloquent, and Stripe.',
      description: 'Comprehensive Laravel 12 masterclass covering advanced Eloquent relationships, service layers, queues, multi-gateway payments, and custom authentication.',
      categoryId: 3,
      category: categories[2],
      instructorId: 2,
      instructor: instructorAlex,
      price: 99.99,
      discountPrice: 69.99,
      level: 'intermediate',
      language: 'English',
      thumbnail: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&auto=format&fit=crop&q=80',
      status: 'published',
      isFeatured: true,
      isBestseller: true,
      averageRating: 4.95,
      reviewsCount: 280,
      studentsCount: 1100,
      totalDurationMinutes: 620,
      sections: [
        SectionModel(
          id: 3,
          courseId: 2,
          title: 'Module 1: Advanced Laravel 12 Structure',
          lessons: [
            LessonModel(id: 7, sectionId: 3, title: 'Laravel 12 Bootstrap & Directory Overview', durationMinutes: 20, isPreview: true),
            LessonModel(id: 8, sectionId: 3, title: 'Service Layer & Repository Design Pattern', durationMinutes: 35),
          ],
        ),
      ],
    ),
    CourseModel(
      id: 3,
      title: 'UI/UX Design Systems in Figma & Responsive Design',
      slug: 'ui-ux-design-systems-figma',
      subtitle: 'Create pixel-perfect UI kits, tokens, auto-layout, and interactive prototypes in Figma.',
      description: 'Learn modern UI/UX design from scratch. Master design tokens, accessibility, wireframing, micro-interactions, and design handoff.',
      categoryId: 4,
      category: categories[3],
      instructorId: 3,
      instructor: instructorSarah,
      price: 69.99,
      discountPrice: 39.99,
      level: 'beginner',
      language: 'English',
      thumbnail: 'https://images.unsplash.com/photo-1581291518857-4e27b48ff24e?w=800&auto=format&fit=crop&q=80',
      status: 'published',
      isFeatured: false,
      isBestseller: true,
      averageRating: 4.85,
      reviewsCount: 195,
      studentsCount: 890,
      totalDurationMinutes: 340,
    ),
    CourseModel(
      id: 4,
      title: 'Docker & Kubernetes for Cloud Deployments',
      slug: 'docker-kubernetes-cloud-deployments',
      subtitle: 'Containerize, orchestrate, and deploy production web applications seamlessly.',
      description: 'Master containerization with Docker and multi-node orchestration with Kubernetes. Configure CI/CD pipelines, SSL certificates, and zero-downtime deployments.',
      categoryId: 5,
      category: categories[4],
      instructorId: 2,
      instructor: instructorAlex,
      price: 84.99,
      discountPrice: 44.99,
      level: 'advanced',
      language: 'English',
      thumbnail: 'https://images.unsplash.com/photo-1607799279861-4dd421887fb3?w=800&auto=format&fit=crop&q=80',
      status: 'published',
      isFeatured: true,
      isBestseller: false,
      averageRating: 4.9,
      reviewsCount: 140,
      studentsCount: 620,
      totalDurationMinutes: 410,
    ),
    CourseModel(
      id: 5,
      title: 'Modern Full-Stack JavaScript & TypeScript Bootcamp',
      slug: 'modern-full-stack-javascript-typescript',
      subtitle: 'Build robust asynchronous web applications with Node.js, Express, and TypeScript.',
      description: 'Comprehensive guide to TypeScript and JavaScript runtime environments, event loops, REST APIs, and database migrations.',
      categoryId: 1,
      category: categories[0],
      instructorId: 2,
      instructor: instructorAlex,
      price: 79.99,
      discountPrice: 49.99,
      level: 'all_levels',
      language: 'English',
      thumbnail: 'https://images.unsplash.com/photo-1579468118864-1b9ea3c0db4a?w=800&auto=format&fit=crop&q=80',
      status: 'published',
      isFeatured: false,
      isBestseller: false,
      averageRating: 4.75,
      reviewsCount: 110,
      studentsCount: 540,
      totalDurationMinutes: 380,
    ),
  ];

  // Certificates
  static final List<CertificateModel> certificates = [
    CertificateModel(
      id: 1,
      certificateNumber: 'CERT-2026-FLUTTER9812',
      verificationCode: 'VERIFY-8874-9921',
      studentName: 'John Doe',
      courseTitle: 'Complete Flutter & Dart Masterclass: Zero to Hero',
      instructorName: 'Sarah Jenkins',
      issuedAt: DateTime.now().subtract(const Duration(days: 3)),
      qrCodeUrl: 'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=https://learnova.com/certificate/verify/VERIFY-8874-9921',
    ),
  ];

  // Notifications
  static final List<NotificationModel> notifications = [
    NotificationModel(
      id: 1,
      title: 'Course Enrolled Successfully! 🎉',
      message: 'You have enrolled in Complete Flutter & Dart Masterclass: Zero to Hero.',
      type: 'success',
      isRead: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationModel(
      id: 2,
      title: 'Assignment Graded! 📝',
      message: 'Instructor Sarah graded your Capstone project with 95/100 points.',
      type: 'info',
      isRead: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  // Earnings
  static final List<EarningsRecordModel> earnings = [
    EarningsRecordModel(
      id: 1,
      courseTitle: 'Complete Flutter & Dart Masterclass',
      orderAmount: 49.99,
      netAmount: 44.99,
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    EarningsRecordModel(
      id: 2,
      courseTitle: 'Complete Flutter & Dart Masterclass',
      orderAmount: 49.99,
      netAmount: 44.99,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];
}
