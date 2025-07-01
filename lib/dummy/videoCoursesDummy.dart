import 'package:career/dummy/teachersDummy.dart';
import 'package:career/dummy/usersDummy.dart';

import 'categoriesDummy.dart';

final videoCoursesJSON = [
  {
    "id": 1,
    "title": "Travel English",
    "description":
    "Couple having coffee in a campsite.\n\nA young couple drinks coffee during a cool morning in a camping area in the middle of a forest.",
    "imageUrl":
    "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
    "previewVideoUrl":
    "https://assets.mixkit.co/videos/preview/mixkit-couple-having-coffee-in-a-campsite-43165-large.mp4",
    "previewVideoDuration": "00:17",
    "level": "Beginner",
    "teacher": teachersJSON.firstWhere((element) => element["id"] == 1),
    "categories": [
      categoriesJSON.firstWhere((element) => element["id"] == 1),
      categoriesJSON.firstWhere((element) => element["id"] == 2),
      categoriesJSON.firstWhere((element) => element["id"] == 3),
      categoriesJSON.firstWhere((element) => element["id"] == 4),
    ],
    "lessons": [
      {
        "id": 1,
        "number": 1,
        "title": "Arriving At The Airport",
        "imageUrl":
        "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
        "videoUrl":
        "https://assets.mixkit.co/videos/preview/mixkit-woman-walking-slowly-towards-a-terminal-27760-large.mp4",
        "videoDuration": "01:24",
        "countVideoPlays": 10000,
        "progress": 0.3,
      },
      {
        "id": 2,
        "number": 2,
        "title": "Getting To Your Bed",
        "imageUrl":
        "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
        "videoUrl":
        "https://assets.mixkit.co/videos/preview/mixkit-a-mother-with-her-daughter-reading-a-book-together-4583-large.mp4",
        "videoDuration": "01:24",
        "countVideoPlays": 10000,
        "progress": 0.3,
      },
      {
        "id": 3,
        "number": 3,
        "title": "Checking In",
        "imageUrl":
        "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
        "videoUrl": "https://assets.mixkit.co/videos/preview/mixkit-checking-in-at-the-airport-counter-23976-large.mp4",
        "videoDuration": "01:24",
        "countVideoPlays": 10000,
        "progress": 0.3,
      },
      {
        "id": 4,
        "number": 4,
        "title": "Tours & Activities",
        "imageUrl":
        "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
        "videoUrl": "https://assets.mixkit.co/videos/preview/mixkit-tour-along-the-coast-4062-large.mp4",
        "videoDuration": "01:24",
        "countVideoPlays": 10000,
        "progress": 0.3,
      },
      {
        "id": 5,
        "number": 5,
        "title": "Ordering Food & Drinks",
        "imageUrl":
        "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
        "videoUrl":
        "https://assets.mixkit.co/videos/preview/mixkit-couple-having-breakfast-cereal-and-see-their-cell-phones-4857-large.mp4",
        "videoDuration": "01:24",
        "countVideoPlays": 10000,
        "progress": 0.3,
      },
    ],
    "comments": [
      {
        "id": 1,
        "text": "Contrary to popular belief, Lorem Ipsum is not simply random text.",
        "user": usersJSON.firstWhere((element) => element["uid"] == "qwerty123"),
        "createdAt": DateTime.now().subtract(const Duration(days: 40)).toIso8601String(),
      },
      {
        "id": 2,
        "text":
        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
        "user": usersJSON.firstWhere((element) => element["uid"] == "qwerty456"),
        "createdAt": DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      },
    ],
    "countStudents": 83227,
    "countPreviewVideoPlays": 357317,
    "createdAt": DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
  },
  {
    "id": 2,
    "title": "Building Your English Brain",
    "description":
    "Creative woman writing ideas on sticky notes for marketing project.\n\nA young couple drinks coffee during a cool morning in a camping area in the middle of a forest.",
    "imageUrl":
    "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
    "previewVideoUrl":
    "https://assets.mixkit.co/videos/preview/mixkit-creative-woman-writing-ideas-on-sticky-notes-for-marketing-project-9124-large.mp4",
    "previewVideoDuration": "00:15",
    "level": "Beginner",
    "teacher": teachersJSON.firstWhere((element) => element["id"] == 2),
    "categories": [
      categoriesJSON.firstWhere((element) => element["id"] == 1),
      categoriesJSON.firstWhere((element) => element["id"] == 2),
    ],
    "lessons": [
      {
        "id": 2,
        "number": 1,
        "title": "Building Your Mindset",
        "imageUrl":
        "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
        "videoUrl": "https://assets.mixkit.co/videos/preview/mixkit-mother-helps-her-daughter-study-4790-large.mp4",
        "videoDuration": "01:24",
        "countVideoPlays": 10000,
        "progress": 0.3,
      },
    ],
    "comments": [
      {
        "id": 1,
        "text": "Contrary to popular belief, Lorem Ipsum is not simply random text.",
        "user": usersJSON.firstWhere((element) => element["uid"] == "qwerty123"),
        "createdAt": DateTime.now().subtract(const Duration(days: 40)).toIso8601String(),
      },
      {
        "id": 2,
        "text":
        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
        "user": usersJSON.firstWhere((element) => element["uid"] == "qwerty456"),
        "createdAt": DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      },
    ],
    "countStudents": 53227,
    "countPreviewVideoPlays": 357317,
    "createdAt": DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
  },
  {
    "id": 3,
    "title": "Planning Startegy",
    "description":
    "Team of entrepreneurs at a planning meeting. Creative woman writing ideas on sticky notes for marketing project.\n\nA young couple drinks coffee during a cool morning in a camping area in the middle of a forest.",
    "imageUrl":
    "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
    "previewVideoUrl":
    "https://assets.mixkit.co/videos/preview/mixkit-team-of-entrepreneurs-at-a-planning-meeting-21225-large.mp4",
    "previewVideoDuration": "00:15",
    "level": "Beginner",
    "teacher": teachersJSON.firstWhere((element) => element["id"] == 1),
    "categories": [
      categoriesJSON.firstWhere((element) => element["id"] == 1),
      categoriesJSON.firstWhere((element) => element["id"] == 4),
    ],
    "lessons": [
      {
        "id": 2,
        "number": 1,
        "title": "Building Your Team",
        "imageUrl":
        "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
        "videoUrl":
        "https://assets.mixkit.co/videos/preview/mixkit-group-of-young-people-talking-about-their-presentation-4788-large.mp4",
        "videoDuration": "01:24",
        "countVideoPlays": 10000,
        "progress": 0.3,
      },
    ],
    "comments": [
      {
        "id": 1,
        "text": "Contrary to popular belief, Lorem Ipsum is not simply random text.",
        "user": usersJSON.firstWhere((element) => element["uid"] == "qwerty123"),
        "createdAt": DateTime.now().subtract(const Duration(days: 40)).toIso8601String(),
      },
      {
        "id": 2,
        "text":
        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
        "user": usersJSON.firstWhere((element) => element["uid"] == "qwerty456"),
        "createdAt": DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      },
    ],
    "countStudents": 33227,
    "countPreviewVideoPlays": 357317,
    "createdAt": DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
  },
  {
    "id": 3,
    "title": "Planning a Meeting",
    "description":
    "Students in a cafeteria discussing an assignment.\n\nYoung students sitting at a table, with cups of coffee, while discussing a task with sheets.",
    "imageUrl":
    "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
    "previewVideoUrl":
    "https://assets.mixkit.co/videos/preview/mixkit-students-in-a-cafeteria-discussing-an-assignment-4794-large.mp4",
    "previewVideoDuration": "00:15",
    "level": "Beginner",
    "teacher": teachersJSON.firstWhere((element) => element["id"] == 2),
    "categories": [
      categoriesJSON.firstWhere((element) => element["id"] == 1),
      categoriesJSON.firstWhere((element) => element["id"] == 4),
    ],
    "lessons": [
      {
        "id": 2,
        "number": 1,
        "title": "Building Your Team",
        "imageUrl":
        "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
        "videoUrl":
        "https://assets.mixkit.co/videos/preview/mixkit-group-of-young-people-talking-about-their-presentation-4788-large.mp4",
        "videoDuration": "01:24",
        "countVideoPlays": 10000,
        "progress": 0.3,
      },
    ],
    "comments": [
      {
        "id": 1,
        "text": "Contrary to popular belief, Lorem Ipsum is not simply random text.",
        "user": usersJSON.firstWhere((element) => element["uid"] == "qwerty123"),
        "createdAt": DateTime.now().subtract(const Duration(days: 40)).toIso8601String(),
      },
      {
        "id": 2,
        "text":
        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
        "user": usersJSON.firstWhere((element) => element["uid"] == "qwerty456"),
        "createdAt": DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      },
    ],
    "countStudents": 205,
    "countPreviewVideoPlays": 71317,
    "createdAt": DateTime.now().toIso8601String(),
  },
  {
    "id": 4,
    "title": "Kids Education",
    "description":
    "Little blond-haired girl studying on a computer, on a table with colors and leaves around it.\n\nA young couple drinks coffee during a cool morning in a camping area in the middle of a forest.",
    "imageUrl":
    "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
    "previewVideoUrl":
    "https://assets.mixkit.co/videos/preview/mixkit-little-girl-studying-on-a-computer-4724-large.mp4",
    "previewVideoDuration": "00:15",
    "level": "Beginner",
    "teacher": teachersJSON.firstWhere((element) => element["id"] == 1),
    "categories": [
      categoriesJSON.firstWhere((element) => element["id"] == 1),
      categoriesJSON.firstWhere((element) => element["id"] == 3),
    ],
    "lessons": [
      {
        "id": 2,
        "number": 1,
        "title": "Building Your Family",
        "imageUrl":
        "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
        "videoUrl": "https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-happy-daughters-4549-large.mp4",
        "videoDuration": "01:24",
        "countVideoPlays": 10000,
        "progress": 0.3,
      },
    ],
    "countStudents": 170,
    "countPreviewVideoPlays": 57317,
    "createdAt": DateTime.now().toIso8601String(),
  },
  {
    "id": 5,
    "title": "Learn Basic Grammar",
    "description":
    "Girl doing homework in a library.\n\nYoung woman with headphones, working in a library with a lap top, a notebook and a few books, with a large bookcase in the background.",
    "imageUrl":
    "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
    "previewVideoUrl": "https://assets.mixkit.co/videos/preview/mixkit-girl-doing-homework-in-a-library-4531-large.mp4",
    "previewVideoDuration": "00:15",
    "level": "Beginner",
    "teacher": teachersJSON.firstWhere((element) => element["id"] == 2),
    "categories": [
      categoriesJSON.firstWhere((element) => element["id"] == 1),
      categoriesJSON.firstWhere((element) => element["id"] == 2),
    ],
    "lessons": [
      {
        "id": 2,
        "number": 1,
        "title": "Building Your Family",
        "imageUrl":
        "https://courses.iid.org.in/public//uploads/media_manager/628.jpg",
        "videoUrl": "https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-happy-daughters-4549-large.mp4",
        "videoDuration": "01:24",
        "countVideoPlays": 10000,
        "progress": 0.3,
      },
    ],
    "comments": [
      {
        "id": 1,
        "text": "Contrary to popular belief, Lorem Ipsum is not simply random text.",
        "user": usersJSON.firstWhere((element) => element["uid"] == "qwerty123"),
        "createdAt": DateTime.now().subtract(const Duration(days: 40)).toIso8601String(),
      },
      {
        "id": 2,
        "text":
        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
        "user": usersJSON.firstWhere((element) => element["uid"] == "qwerty456"),
        "createdAt": DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      },
    ],
    "countStudents": 717,
    "countPreviewVideoPlays": 27317,
    "createdAt": DateTime.now().toIso8601String(),
  },
];
