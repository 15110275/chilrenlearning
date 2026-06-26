import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'l10n/app_localizations.dart';

class S6lessonScreen extends StatefulWidget {
  const S6lessonScreen({
    super.key,
    this.initialLessonIndex = 0,
    this.topic = 'alphabet',
  });

  final int initialLessonIndex;
  final String topic;

  @override
  State<S6lessonScreen> createState() => _S6lessonScreenState();
}

class _LessonItem {
  const _LessonItem({
    required this.letter,
    required this.lowercase,
    required this.word,
    required this.phonetic,
    required this.translation,
    required this.emoji,
    required this.color,
    required this.bg,
    required this.options,
  });

  final String letter;
  final String lowercase;
  final String word;
  final String phonetic;
  final String translation;
  final String emoji;
  final Color color;
  final Color bg;
  final List<_GameOption> options;
}

class _GameOption {
  const _GameOption({
    required this.emoji,
    required this.word,
    required this.isCorrect,
  });

  final String emoji;
  final String word;
  final bool isCorrect;
}

class _S6lessonScreenState extends State<S6lessonScreen>
    with TickerProviderStateMixin {
  static const List<_LessonItem> _alphabetLessons = [
    _LessonItem(
      letter: 'A',
      lowercase: 'a',
      word: 'Apple',
      phonetic: '/ae-pl/',
      translation: 'Quả táo',
      emoji: '🍎',
      color: Color(0xFFF43F5E),
      bg: Color(0xFFFFF1F2),
      options: [
        _GameOption(emoji: '🍎', word: 'Apple', isCorrect: true),
        _GameOption(emoji: '🍌', word: 'Banana', isCorrect: false),
        _GameOption(emoji: '⚽', word: 'Ball', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'B',
      lowercase: 'b',
      word: 'Banana',
      phonetic: '/bə-na-nə/',
      translation: 'Quả chuối',
      emoji: '🍌',
      color: Color(0xFF2563EB),
      bg: Color(0xFFEFF6FF),
      options: [
        _GameOption(emoji: '🍌', word: 'Banana', isCorrect: true),
        _GameOption(emoji: '⚽', word: 'Ball', isCorrect: false),
        _GameOption(emoji: '🐱', word: 'Cat', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'C',
      lowercase: 'c',
      word: 'Cat',
      phonetic: '/kæt/',
      translation: 'Con mèo',
      emoji: '🐱',
      color: Color(0xFFF97316),
      bg: Color(0xFFFFF7ED),
      options: [
        _GameOption(emoji: '🐱', word: 'Cat', isCorrect: true),
        _GameOption(emoji: '🐶', word: 'Dog', isCorrect: false),
        _GameOption(emoji: '🍎', word: 'Apple', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'D',
      lowercase: 'd',
      word: 'Dog',
      phonetic: '/dɒg/',
      translation: 'Con chó',
      emoji: '🐶',
      color: Color(0xFF10B981),
      bg: Color(0xFFECFDF5),
      options: [
        _GameOption(emoji: '🐘', word: 'Elephant', isCorrect: false),
        _GameOption(emoji: '🐶', word: 'Dog', isCorrect: true),
        _GameOption(emoji: '⚽', word: 'Ball', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'E',
      lowercase: 'e',
      word: 'Elephant',
      phonetic: '/el-i-fənt/',
      translation: 'Con voi',
      emoji: '🐘',
      color: Color(0xFF8B5CF6),
      bg: Color(0xFFF5F3FF),
      options: [
        _GameOption(emoji: '🐘', word: 'Elephant', isCorrect: true),
        _GameOption(emoji: '🐱', word: 'Cat', isCorrect: false),
        _GameOption(emoji: '🍌', word: 'Banana', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'F',
      lowercase: 'f',
      word: 'Fish',
      phonetic: '/fɪʃ/',
      translation: 'Con cá',
      emoji: '🐟',
      color: Color(0xFF06B6D4),
      bg: Color(0xFFECFEFF),
      options: [
        _GameOption(emoji: '🐟', word: 'Fish', isCorrect: true),
        _GameOption(emoji: '🐸', word: 'Frog', isCorrect: false),
        _GameOption(emoji: '🍇', word: 'Grape', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'G',
      lowercase: 'g',
      word: 'Grape',
      phonetic: '/greɪp/',
      translation: 'Quả nho',
      emoji: '🍇',
      color: Color(0xFF7C3AED),
      bg: Color(0xFFF5F3FF),
      options: [
        _GameOption(emoji: '🍇', word: 'Grape', isCorrect: true),
        _GameOption(emoji: '🐐', word: 'Goat', isCorrect: false),
        _GameOption(emoji: '🏠', word: 'House', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'H',
      lowercase: 'h',
      word: 'House',
      phonetic: '/haʊs/',
      translation: 'Ngôi nhà',
      emoji: '🏠',
      color: Color(0xFF0EA5E9),
      bg: Color(0xFFF0F9FF),
      options: [
        _GameOption(emoji: '🏠', word: 'House', isCorrect: true),
        _GameOption(emoji: '🎩', word: 'Hat', isCorrect: false),
        _GameOption(emoji: '🍦', word: 'Ice cream', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'I',
      lowercase: 'i',
      word: 'Ice cream',
      phonetic: '/aɪs kriːm/',
      translation: 'Kem',
      emoji: '🍦',
      color: Color(0xFFEC4899),
      bg: Color(0xFFFDF2F8),
      options: [
        _GameOption(emoji: '🍦', word: 'Ice cream', isCorrect: true),
        _GameOption(emoji: '🦎', word: 'Iguana', isCorrect: false),
        _GameOption(emoji: '🧃', word: 'Juice', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'J',
      lowercase: 'j',
      word: 'Juice',
      phonetic: '/dʒuːs/',
      translation: 'Nước ép',
      emoji: '🧃',
      color: Color(0xFFF59E0B),
      bg: Color(0xFFFFFBEB),
      options: [
        _GameOption(emoji: '🧃', word: 'Juice', isCorrect: true),
        _GameOption(emoji: '🫙', word: 'Jar', isCorrect: false),
        _GameOption(emoji: '🔑', word: 'Key', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'K',
      lowercase: 'k',
      word: 'Key',
      phonetic: '/kiː/',
      translation: 'Chìa khóa',
      emoji: '🔑',
      color: Color(0xFFEAB308),
      bg: Color(0xFFFEFCE8),
      options: [
        _GameOption(emoji: '🔑', word: 'Key', isCorrect: true),
        _GameOption(emoji: '🪁', word: 'Kite', isCorrect: false),
        _GameOption(emoji: '🦁', word: 'Lion', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'L',
      lowercase: 'l',
      word: 'Lion',
      phonetic: '/laɪ-ən/',
      translation: 'Sư tử',
      emoji: '🦁',
      color: Color(0xFFF97316),
      bg: Color(0xFFFFF7ED),
      options: [
        _GameOption(emoji: '🦁', word: 'Lion', isCorrect: true),
        _GameOption(emoji: '🍋', word: 'Lemon', isCorrect: false),
        _GameOption(emoji: '🌙', word: 'Moon', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'M',
      lowercase: 'm',
      word: 'Moon',
      phonetic: '/muːn/',
      translation: 'Mặt trăng',
      emoji: '🌙',
      color: Color(0xFF6366F1),
      bg: Color(0xFFEEF2FF),
      options: [
        _GameOption(emoji: '🌙', word: 'Moon', isCorrect: true),
        _GameOption(emoji: '🐒', word: 'Monkey', isCorrect: false),
        _GameOption(emoji: '👃', word: 'Nose', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'N',
      lowercase: 'n',
      word: 'Nose',
      phonetic: '/noʊz/',
      translation: 'Cái mũi',
      emoji: '👃',
      color: Color(0xFF14B8A6),
      bg: Color(0xFFF0FDFA),
      options: [
        _GameOption(emoji: '👃', word: 'Nose', isCorrect: true),
        _GameOption(emoji: '🥜', word: 'Nut', isCorrect: false),
        _GameOption(emoji: '🍊', word: 'Orange', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'O',
      lowercase: 'o',
      word: 'Orange',
      phonetic: '/ɔːr-ɪndʒ/',
      translation: 'Quả cam',
      emoji: '🍊',
      color: Color(0xFFF97316),
      bg: Color(0xFFFFF7ED),
      options: [
        _GameOption(emoji: '🍊', word: 'Orange', isCorrect: true),
        _GameOption(emoji: '🐙', word: 'Octopus', isCorrect: false),
        _GameOption(emoji: '✏️', word: 'Pencil', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'P',
      lowercase: 'p',
      word: 'Pencil',
      phonetic: '/pen-səl/',
      translation: 'Bút chì',
      emoji: '✏️',
      color: Color(0xFF64748B),
      bg: Color(0xFFF8FAFC),
      options: [
        _GameOption(emoji: '✏️', word: 'Pencil', isCorrect: true),
        _GameOption(emoji: '🐼', word: 'Panda', isCorrect: false),
        _GameOption(emoji: '👑', word: 'Queen', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'Q',
      lowercase: 'q',
      word: 'Queen',
      phonetic: '/kwiːn/',
      translation: 'Nữ hoàng',
      emoji: '👑',
      color: Color(0xFFA855F7),
      bg: Color(0xFFFAF5FF),
      options: [
        _GameOption(emoji: '👑', word: 'Queen', isCorrect: true),
        _GameOption(emoji: '❓', word: 'Question', isCorrect: false),
        _GameOption(emoji: '🌈', word: 'Rainbow', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'R',
      lowercase: 'r',
      word: 'Rainbow',
      phonetic: '/reɪn-boʊ/',
      translation: 'Cầu vồng',
      emoji: '🌈',
      color: Color(0xFF22C55E),
      bg: Color(0xFFF0FDF4),
      options: [
        _GameOption(emoji: '🌈', word: 'Rainbow', isCorrect: true),
        _GameOption(emoji: '🚗', word: 'Robot', isCorrect: false),
        _GameOption(emoji: '☀️', word: 'Sun', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'S',
      lowercase: 's',
      word: 'Sun',
      phonetic: '/sʌn/',
      translation: 'Mặt trời',
      emoji: '☀️',
      color: Color(0xFFEAB308),
      bg: Color(0xFFFEFCE8),
      options: [
        _GameOption(emoji: '☀️', word: 'Sun', isCorrect: true),
        _GameOption(emoji: '⭐', word: 'Star', isCorrect: false),
        _GameOption(emoji: '🚂', word: 'Train', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'T',
      lowercase: 't',
      word: 'Train',
      phonetic: '/treɪn/',
      translation: 'Tàu hỏa',
      emoji: '🚂',
      color: Color(0xFFEF4444),
      bg: Color(0xFFFEF2F2),
      options: [
        _GameOption(emoji: '🚂', word: 'Train', isCorrect: true),
        _GameOption(emoji: '🐯', word: 'Tiger', isCorrect: false),
        _GameOption(emoji: '☂️', word: 'Umbrella', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'U',
      lowercase: 'u',
      word: 'Umbrella',
      phonetic: '/ʌm-brel-ə/',
      translation: 'Cái ô',
      emoji: '☂️',
      color: Color(0xFF0EA5E9),
      bg: Color(0xFFF0F9FF),
      options: [
        _GameOption(emoji: '☂️', word: 'Umbrella', isCorrect: true),
        _GameOption(emoji: '🦄', word: 'Unicorn', isCorrect: false),
        _GameOption(emoji: '🎻', word: 'Violin', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'V',
      lowercase: 'v',
      word: 'Violin',
      phonetic: '/vaɪ-ə-lɪn/',
      translation: 'Đàn vĩ cầm',
      emoji: '🎻',
      color: Color(0xFF9333EA),
      bg: Color(0xFFFAF5FF),
      options: [
        _GameOption(emoji: '🎻', word: 'Violin', isCorrect: true),
        _GameOption(emoji: '🚐', word: 'Van', isCorrect: false),
        _GameOption(emoji: '⌚', word: 'Watch', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'W',
      lowercase: 'w',
      word: 'Watch',
      phonetic: '/wɑːtʃ/',
      translation: 'Đồng hồ',
      emoji: '⌚',
      color: Color(0xFF0891B2),
      bg: Color(0xFFECFEFF),
      options: [
        _GameOption(emoji: '⌚', word: 'Watch', isCorrect: true),
        _GameOption(emoji: '🍉', word: 'Watermelon', isCorrect: false),
        _GameOption(emoji: '🎵', word: 'Xylophone', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'X',
      lowercase: 'x',
      word: 'Xylophone',
      phonetic: '/zaɪ-lə-foʊn/',
      translation: 'Đàn phiến gỗ',
      emoji: '🎵',
      color: Color(0xFFDB2777),
      bg: Color(0xFFFDF2F8),
      options: [
        _GameOption(emoji: '🎵', word: 'Xylophone', isCorrect: true),
        _GameOption(emoji: '❌', word: 'X mark', isCorrect: false),
        _GameOption(emoji: '🪀', word: 'Yo-yo', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'Y',
      lowercase: 'y',
      word: 'Yo-yo',
      phonetic: '/yoʊ-yoʊ/',
      translation: 'Đồ chơi yo-yo',
      emoji: '🪀',
      color: Color(0xFF65A30D),
      bg: Color(0xFFF7FEE7),
      options: [
        _GameOption(emoji: '🪀', word: 'Yo-yo', isCorrect: true),
        _GameOption(emoji: '🛥️', word: 'Yacht', isCorrect: false),
        _GameOption(emoji: '🦓', word: 'Zebra', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'Z',
      lowercase: 'z',
      word: 'Zebra',
      phonetic: '/ziː-brə/',
      translation: 'Ngựa vằn',
      emoji: '🦓',
      color: Color(0xFF475569),
      bg: Color(0xFFF8FAFC),
      options: [
        _GameOption(emoji: '🦓', word: 'Zebra', isCorrect: true),
        _GameOption(emoji: '🦁', word: 'Lion', isCorrect: false),
        _GameOption(emoji: '🍎', word: 'Apple', isCorrect: false),
      ],
    ),
  ];

  static final List<_LessonItem> _numberLessons = List.generate(20, (index) {
    final words = [
      'One',
      'Two',
      'Three',
      'Four',
      'Five',
      'Six',
      'Seven',
      'Eight',
      'Nine',
      'Ten',
      'Eleven',
      'Twelve',
      'Thirteen',
      'Fourteen',
      'Fifteen',
      'Sixteen',
      'Seventeen',
      'Eighteen',
      'Nineteen',
      'Twenty',
    ];
    final translations = [
      'Số một',
      'Số hai',
      'Số ba',
      'Số bốn',
      'Số năm',
      'Số sáu',
      'Số bảy',
      'Số tám',
      'Số chín',
      'Số mười',
      'Số mười một',
      'Số mười hai',
      'Số mười ba',
      'Số mười bốn',
      'Số mười lăm',
      'Số mười sáu',
      'Số mười bảy',
      'Số mười tám',
      'Số mười chín',
      'Số hai mươi',
    ];
    final colors = [
      const Color(0xFFD97706),
      const Color(0xFFEA580C),
      const Color(0xFFEAB308),
      const Color(0xFF16A34A),
      const Color(0xFF0284C7),
      const Color(0xFF7C3AED),
    ];
    final number = index + 1;
    final wrongOne = ((index + 1) % 20) + 1;
    final wrongTwo = ((index + 6) % 20) + 1;
    return _LessonItem(
      letter: '$number',
      lowercase: '',
      word: words[index],
      phonetic: '',
      translation: translations[index],
      emoji: '$number',
      color: colors[index % colors.length],
      bg: const Color(0xFFFFFBEB),
      options: [
        _GameOption(emoji: '$number', word: words[index], isCorrect: true),
        _GameOption(
          emoji: '$wrongOne',
          word: words[wrongOne - 1],
          isCorrect: false,
        ),
        _GameOption(
          emoji: '$wrongTwo',
          word: words[wrongTwo - 1],
          isCorrect: false,
        ),
      ],
    );
  });

  static const List<_LessonItem> _animalLessons = [
    _LessonItem(
      letter: '🐱',
      lowercase: '',
      word: 'Cat',
      phonetic: '/kæt/',
      translation: 'Con mèo',
      emoji: '🐱',
      color: Color(0xFFF97316),
      bg: Color(0xFFFFF7ED),
      options: [
        _GameOption(emoji: '🐱', word: 'Cat', isCorrect: true),
        _GameOption(emoji: '🐶', word: 'Dog', isCorrect: false),
        _GameOption(emoji: '🦁', word: 'Lion', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🐶',
      lowercase: '',
      word: 'Dog',
      phonetic: '/dɒg/',
      translation: 'Con chó',
      emoji: '🐶',
      color: Color(0xFF10B981),
      bg: Color(0xFFECFDF5),
      options: [
        _GameOption(emoji: '🐶', word: 'Dog', isCorrect: true),
        _GameOption(emoji: '🐱', word: 'Cat', isCorrect: false),
        _GameOption(emoji: '🐯', word: 'Tiger', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🦁',
      lowercase: '',
      word: 'Lion',
      phonetic: '/laɪ-ən/',
      translation: 'Sư tử',
      emoji: '🦁',
      color: Color(0xFFF97316),
      bg: Color(0xFFFFF7ED),
      options: [
        _GameOption(emoji: '🦁', word: 'Lion', isCorrect: true),
        _GameOption(emoji: '🐯', word: 'Tiger', isCorrect: false),
        _GameOption(emoji: '🐘', word: 'Elephant', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🐯',
      lowercase: '',
      word: 'Tiger',
      phonetic: '/taɪ-gər/',
      translation: 'Con hổ',
      emoji: '🐯',
      color: Color(0xFFEF4444),
      bg: Color(0xFFFEF2F2),
      options: [
        _GameOption(emoji: '🐯', word: 'Tiger', isCorrect: true),
        _GameOption(emoji: '🦁', word: 'Lion', isCorrect: false),
        _GameOption(emoji: '🐒', word: 'Monkey', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🐘',
      lowercase: '',
      word: 'Elephant',
      phonetic: '/el-i-fənt/',
      translation: 'Con voi',
      emoji: '🐘',
      color: Color(0xFF8B5CF6),
      bg: Color(0xFFF5F3FF),
      options: [
        _GameOption(emoji: '🐘', word: 'Elephant', isCorrect: true),
        _GameOption(emoji: '🐼', word: 'Panda', isCorrect: false),
        _GameOption(emoji: '🐰', word: 'Rabbit', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🐒',
      lowercase: '',
      word: 'Monkey',
      phonetic: '/mʌŋ-ki/',
      translation: 'Con khỉ',
      emoji: '🐒',
      color: Color(0xFFEAB308),
      bg: Color(0xFFFEFCE8),
      options: [
        _GameOption(emoji: '🐒', word: 'Monkey', isCorrect: true),
        _GameOption(emoji: '🐼', word: 'Panda', isCorrect: false),
        _GameOption(emoji: '🐸', word: 'Frog', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🐼',
      lowercase: '',
      word: 'Panda',
      phonetic: '/pan-də/',
      translation: 'Gấu trúc',
      emoji: '🐼',
      color: Color(0xFF475569),
      bg: Color(0xFFF8FAFC),
      options: [
        _GameOption(emoji: '🐼', word: 'Panda', isCorrect: true),
        _GameOption(emoji: '🐰', word: 'Rabbit', isCorrect: false),
        _GameOption(emoji: '🐦', word: 'Bird', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🐰',
      lowercase: '',
      word: 'Rabbit',
      phonetic: '/rab-it/',
      translation: 'Con thỏ',
      emoji: '🐰',
      color: Color(0xFFDB2777),
      bg: Color(0xFFFDF2F8),
      options: [
        _GameOption(emoji: '🐰', word: 'Rabbit', isCorrect: true),
        _GameOption(emoji: '🐟', word: 'Fish', isCorrect: false),
        _GameOption(emoji: '🦓', word: 'Zebra', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🐟',
      lowercase: '',
      word: 'Fish',
      phonetic: '/fɪʃ/',
      translation: 'Con cá',
      emoji: '🐟',
      color: Color(0xFF06B6D4),
      bg: Color(0xFFECFEFF),
      options: [
        _GameOption(emoji: '🐟', word: 'Fish', isCorrect: true),
        _GameOption(emoji: '🐦', word: 'Bird', isCorrect: false),
        _GameOption(emoji: '🐸', word: 'Frog', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🐦',
      lowercase: '',
      word: 'Bird',
      phonetic: '/bɜːrd/',
      translation: 'Con chim',
      emoji: '🐦',
      color: Color(0xFF0EA5E9),
      bg: Color(0xFFF0F9FF),
      options: [
        _GameOption(emoji: '🐦', word: 'Bird', isCorrect: true),
        _GameOption(emoji: '🐸', word: 'Frog', isCorrect: false),
        _GameOption(emoji: '🐱', word: 'Cat', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🐸',
      lowercase: '',
      word: 'Frog',
      phonetic: '/frɒg/',
      translation: 'Con ếch',
      emoji: '🐸',
      color: Color(0xFF16A34A),
      bg: Color(0xFFF0FDF4),
      options: [
        _GameOption(emoji: '🐸', word: 'Frog', isCorrect: true),
        _GameOption(emoji: '🐟', word: 'Fish', isCorrect: false),
        _GameOption(emoji: '🦓', word: 'Zebra', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🦓',
      lowercase: '',
      word: 'Zebra',
      phonetic: '/ziː-brə/',
      translation: 'Ngựa vằn',
      emoji: '🦓',
      color: Color(0xFF64748B),
      bg: Color(0xFFF8FAFC),
      options: [
        _GameOption(emoji: '🦓', word: 'Zebra', isCorrect: true),
        _GameOption(emoji: '🦁', word: 'Lion', isCorrect: false),
        _GameOption(emoji: '🐘', word: 'Elephant', isCorrect: false),
      ],
    ),
  ];

  static const List<_LessonItem> _colorLessons = [
    _LessonItem(
      letter: '🔴',
      lowercase: '',
      word: 'Red',
      phonetic: '/red/',
      translation: 'Màu đỏ',
      emoji: '🔴',
      color: Color(0xFFEF4444),
      bg: Color(0xFFFEF2F2),
      options: [
        _GameOption(emoji: '🔴', word: 'Red', isCorrect: true),
        _GameOption(emoji: '🔵', word: 'Blue', isCorrect: false),
        _GameOption(emoji: '🟡', word: 'Yellow', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🟠',
      lowercase: '',
      word: 'Orange',
      phonetic: '/ɔːr-ɪndʒ/',
      translation: 'Màu cam',
      emoji: '🟠',
      color: Color(0xFFF97316),
      bg: Color(0xFFFFF7ED),
      options: [
        _GameOption(emoji: '🟠', word: 'Orange', isCorrect: true),
        _GameOption(emoji: '🟢', word: 'Green', isCorrect: false),
        _GameOption(emoji: '🟣', word: 'Purple', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🟡',
      lowercase: '',
      word: 'Yellow',
      phonetic: '/yel-oʊ/',
      translation: 'Màu vàng',
      emoji: '🟡',
      color: Color(0xFFEAB308),
      bg: Color(0xFFFEFCE8),
      options: [
        _GameOption(emoji: '🟡', word: 'Yellow', isCorrect: true),
        _GameOption(emoji: '🔴', word: 'Red', isCorrect: false),
        _GameOption(emoji: '⚫', word: 'Black', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🟢',
      lowercase: '',
      word: 'Green',
      phonetic: '/griːn/',
      translation: 'Màu xanh lá',
      emoji: '🟢',
      color: Color(0xFF16A34A),
      bg: Color(0xFFF0FDF4),
      options: [
        _GameOption(emoji: '🟢', word: 'Green', isCorrect: true),
        _GameOption(emoji: '🔵', word: 'Blue', isCorrect: false),
        _GameOption(emoji: '🟤', word: 'Brown', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🔵',
      lowercase: '',
      word: 'Blue',
      phonetic: '/bluː/',
      translation: 'Màu xanh dương',
      emoji: '🔵',
      color: Color(0xFF2563EB),
      bg: Color(0xFFEFF6FF),
      options: [
        _GameOption(emoji: '🔵', word: 'Blue', isCorrect: true),
        _GameOption(emoji: '🟣', word: 'Purple', isCorrect: false),
        _GameOption(emoji: '⚪', word: 'White', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🟣',
      lowercase: '',
      word: 'Purple',
      phonetic: '/pɜːr-pəl/',
      translation: 'Màu tím',
      emoji: '🟣',
      color: Color(0xFF7C3AED),
      bg: Color(0xFFF5F3FF),
      options: [
        _GameOption(emoji: '🟣', word: 'Purple', isCorrect: true),
        _GameOption(emoji: '🩷', word: 'Pink', isCorrect: false),
        _GameOption(emoji: '🟠', word: 'Orange', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🩷',
      lowercase: '',
      word: 'Pink',
      phonetic: '/pɪŋk/',
      translation: 'Màu hồng',
      emoji: '🩷',
      color: Color(0xFFDB2777),
      bg: Color(0xFFFDF2F8),
      options: [
        _GameOption(emoji: '🩷', word: 'Pink', isCorrect: true),
        _GameOption(emoji: '🔴', word: 'Red', isCorrect: false),
        _GameOption(emoji: '🟤', word: 'Brown', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '⚫',
      lowercase: '',
      word: 'Black',
      phonetic: '/blæk/',
      translation: 'Màu đen',
      emoji: '⚫',
      color: Color(0xFF111827),
      bg: Color(0xFFF8FAFC),
      options: [
        _GameOption(emoji: '⚫', word: 'Black', isCorrect: true),
        _GameOption(emoji: '⚪', word: 'White', isCorrect: false),
        _GameOption(emoji: '🟡', word: 'Yellow', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '⚪',
      lowercase: '',
      word: 'White',
      phonetic: '/waɪt/',
      translation: 'Màu trắng',
      emoji: '⚪',
      color: Color(0xFF64748B),
      bg: Color(0xFFF8FAFC),
      options: [
        _GameOption(emoji: '⚪', word: 'White', isCorrect: true),
        _GameOption(emoji: '⚫', word: 'Black', isCorrect: false),
        _GameOption(emoji: '🔵', word: 'Blue', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: '🟤',
      lowercase: '',
      word: 'Brown',
      phonetic: '/braʊn/',
      translation: 'Màu nâu',
      emoji: '🟤',
      color: Color(0xFF92400E),
      bg: Color(0xFFFFFBEB),
      options: [
        _GameOption(emoji: '🟤', word: 'Brown', isCorrect: true),
        _GameOption(emoji: '🟢', word: 'Green', isCorrect: false),
        _GameOption(emoji: '🟣', word: 'Purple', isCorrect: false),
      ],
    ),
  ];

  late final AnimationController _floatCtrl;
  late final AnimationController _speakerCtrl;
  late final AnimationController _celebrateCtrl;
  late final AnimationController _hintCtrl;
  late final Animation<double> _floatAnim;
  late final Animation<double> _speakerAnim;
  late final Animation<double> _hintAnim;
  late final FlutterTts _flutterTts;

  late int _currentIndex;
  int _stars = 0;
  bool _playMode = false;
  bool _isSpeaking = false;
  String? _feedback;
  String? _selectedWord;
  String _ttsLocale = 'en-US';
  final Set<int> _completedLessons = {};

  List<_LessonItem> get _lessons {
    switch (widget.topic) {
      case 'numbers':
        return _numberLessons;
      case 'animals':
        return _animalLessons;
      case 'colors':
        return _colorLessons;
      default:
        return _alphabetLessons;
    }
  }

  String get _topicTitle {
    return AppLocalizations.of(context).text(widget.topic);
  }

  String get _learnTitle {
    final l10n = AppLocalizations.of(context);
    switch (widget.topic) {
      case 'numbers':
        return l10n.text('learnNumber', params: {'value': _lesson.letter});
      case 'animals':
        return l10n.text('learnAnimal');
      case 'colors':
        return l10n.text('learnColor');
      default:
        return l10n.text('learnLetter', params: {'value': _lesson.letter});
    }
  }

  String get _findPrompt {
    final l10n = AppLocalizations.of(context);
    switch (widget.topic) {
      case 'numbers':
        return l10n.text('findNumber', params: {'value': _lesson.letter});
      case 'animals':
        return l10n.text('findAnimal', params: {'value': _lesson.word});
      case 'colors':
        return l10n.text('findColor', params: {'value': _lesson.word});
      default:
        return l10n.text('findLetter', params: {'value': _lesson.letter});
    }
  }

  String get _lessonSentence {
    final l10n = AppLocalizations.of(context);
    final params = {'letter': _lesson.letter, 'word': _lesson.word};
    switch (widget.topic) {
      case 'numbers':
        return l10n.text('lessonSentenceNumber', params: params);
      case 'animals':
        return l10n.text('lessonSentenceAnimal', params: params);
      case 'colors':
        return l10n.text('lessonSentenceColor', params: params);
      default:
        return l10n.text('lessonSentenceLetter', params: params);
    }
  }

  String get _questionSentence {
    final l10n = AppLocalizations.of(context);
    switch (widget.topic) {
      case 'numbers':
        return l10n.text('questionNumber', params: {'letter': _lesson.letter});
      default:
        return l10n.text('questionGeneric', params: {'word': _lesson.word});
    }
  }

  _LessonItem get _lesson => _lessons[_currentIndex];

  bool get _lessonComplete => _completedLessons.contains(_currentIndex);

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialLessonIndex
        .clamp(0, _lessons.length - 1)
        .toInt();
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(
      begin: -8,
      end: 8,
    ).animate(CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));

    _speakerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _speakerAnim = Tween<double>(
      begin: 1,
      end: 1.22,
    ).animate(CurvedAnimation(parent: _speakerCtrl, curve: Curves.elasticOut));

    _celebrateCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _hintCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    )..repeat(reverse: true);
    _hintAnim = Tween<double>(
      begin: 0.96,
      end: 1.04,
    ).animate(CurvedAnimation(parent: _hintCtrl, curve: Curves.easeInOut));

    _flutterTts = FlutterTts();
    _setupTextToSpeech();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final nextLocale = AppLocalizations.of(context).ttsLocale;
    if (_ttsLocale != nextLocale) {
      _ttsLocale = nextLocale;
      _flutterTts.setLanguage(_ttsLocale);
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _floatCtrl.dispose();
    _speakerCtrl.dispose();
    _celebrateCtrl.dispose();
    _hintCtrl.dispose();
    super.dispose();
  }

  Future<void> _setupTextToSpeech() async {
    await _flutterTts.setLanguage(_ttsLocale);
    await _flutterTts.setSpeechRate(0.38);
    await _flutterTts.setPitch(1.05);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.awaitSpeakCompletion(true);
    _flutterTts.setCompletionHandler(() {
      if (mounted) setState(() => _isSpeaking = false);
    });
    _flutterTts.setCancelHandler(() {
      if (mounted) setState(() => _isSpeaking = false);
    });
    _flutterTts.setErrorHandler((_) {
      if (mounted) {
        setState(() {
          _isSpeaking = false;
          _feedback = AppLocalizations.of(context).text('ttsNoVoice');
        });
      }
    });
  }

  Future<void> _say(String text, {double speechRate = 0.38}) async {
    setState(() => _isSpeaking = true);
    try {
      await _speakerCtrl.forward(from: 0);
      await _speakerCtrl.reverse();
      await _flutterTts.stop();
      await _flutterTts.setSpeechRate(speechRate);
      await _flutterTts.speak(text);
    } catch (_) {
      if (mounted) {
        setState(() {
          _isSpeaking = false;
          _feedback = AppLocalizations.of(context).text('ttsNoSound');
        });
      }
    }
  }

  Future<void> _speak() => _say(_lessonSentence);

  Future<void> _speakQuestion() => _say(_questionSentence, speechRate: 0.34);

  void _chooseOption(_GameOption option) {
    setState(() {
      _selectedWord = option.word;
      if (option.isCorrect) {
        _feedback = AppLocalizations.of(
          context,
        ).text('greatJob', params: {'value': _lesson.word});
        if (_completedLessons.add(_currentIndex)) _stars += 3;
        _celebrateCtrl.forward(from: 0);
      } else {
        _feedback = AppLocalizations.of(context).text('tryAgain');
      }
    });
    if (option.isCorrect) {
      SystemSound.play(SystemSoundType.alert);
      _say(
        AppLocalizations.of(
          context,
        ).text('greatJob', params: {'value': _lesson.word}),
        speechRate: 0.36,
      );
    } else {
      SystemSound.play(SystemSoundType.click);
      _say(
        AppLocalizations.of(
          context,
        ).text('tryAgainVoice', params: {'question': _questionSentence}),
        speechRate: 0.34,
      );
    }
  }

  void _goToLesson(int index) {
    setState(() {
      _currentIndex = index;
      _playMode = false;
      _feedback = null;
      _selectedWord = null;
    });
  }

  void _nextAction() {
    if (!_playMode) {
      setState(() {
        _playMode = true;
        _feedback = _findPrompt;
      });
      SystemSound.play(SystemSoundType.click);
      _speakQuestion();
      return;
    }

    if (!_lessonComplete) {
      setState(
        () => _feedback = AppLocalizations.of(context).text('chooseToUnlock'),
      );
      _speakQuestion();
      return;
    }

    if (_currentIndex == _lessons.length - 1) {
      Navigator.pushNamed(context, '/s7_quiz');
    } else {
      _goToLesson(_currentIndex + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: _lesson.bg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          child: Column(
            children: [
              _TopBar(
                lessonNumber: _currentIndex + 1,
                totalLessons: _lessons.length,
                title: _topicTitle,
                stars: _stars,
                onBack: () => Navigator.pushNamed(
                  context,
                  '/s5_module',
                  arguments: widget.topic,
                ),
              ),
              const SizedBox(height: 12),
              _ProgressPills(
                total: _lessons.length,
                current: _currentIndex,
                completed: _completedLessons,
                color: _lesson.color,
              ),
              const SizedBox(height: 12),
              _ModeSwitch(
                playMode: _playMode,
                color: _lesson.color,
                onLearn: () => setState(() => _playMode = false),
                onPlay: () => setState(() => _playMode = true),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 320),
                  switchInCurve: Curves.easeOutBack,
                  child: _playMode
                      ? _buildGameCard(isTablet)
                      : _buildLearningCard(isTablet),
                ),
              ),
              const SizedBox(height: 12),
              _buildBottomControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLearningCard(bool isTablet) {
    return Container(
      key: ValueKey('learn-${widget.topic}-${_lesson.letter}'),
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 30 : 22),
      decoration: _cardDecoration(_lesson.color),
      child: Stack(
        children: [
          _FloatingBubble(
            alignment: Alignment.topLeft,
            icon: '✨',
            color: _lesson.color,
          ),
          _FloatingBubble(
            alignment: Alignment.topRight,
            icon: '⭐',
            color: Colors.amber,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                _learnTitle,
                style: TextStyle(
                  color: _lesson.color,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              AnimatedBuilder(
                animation: _floatAnim,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _floatAnim.value),
                    child: child,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      _lesson.letter,
                      style: TextStyle(
                        height: 0.95,
                        fontSize: isTablet ? 120 : 92,
                        fontWeight: FontWeight.w900,
                        color: _lesson.color,
                      ),
                    ),
                    if (_lesson.lowercase.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text(
                        _lesson.lowercase,
                        style: TextStyle(
                          fontSize: isTablet ? 72 : 56,
                          fontWeight: FontWeight.w800,
                          color: _lesson.color.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              _EmojiBadge(
                emoji: _lesson.emoji,
                color: _lesson.color,
                size: isTablet ? 160 : 132,
              ),
              Column(
                children: [
                  Text(
                    _lesson.word,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  if (_lesson.phonetic.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      _lesson.phonetic,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Text(
                    _lesson.translation,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: _lesson.color,
                    ),
                  ),
                ],
              ),
              _SpeakButton(
                color: _lesson.color,
                isSpeaking: _isSpeaking,
                speakerAnim: _speakerAnim,
                onTap: _speak,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(bool isTablet) {
    final l10n = AppLocalizations.of(context);
    return Container(
      key: ValueKey('game-${widget.topic}-${_lesson.letter}'),
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 28 : 18),
      decoration: _cardDecoration(_lesson.color),
      child: Stack(
        children: [
          Positioned.fill(child: _CelebrationStars(controller: _celebrateCtrl)),
          Column(
            children: [
              Text(
                l10n.text('touchOrDrag'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _lesson.color,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              _buildPlayMascot(isTablet),
              const SizedBox(height: 10),
              AnimatedBuilder(
                animation: _hintAnim,
                builder: (context, child) {
                  return Transform.scale(scale: _hintAnim.value, child: child);
                },
                child: DragTarget<_GameOption>(
                  onWillAcceptWithDetails: (_) => true,
                  onAcceptWithDetails: (details) => _chooseOption(details.data),
                  builder: (context, candidates, rejected) {
                    final isHovering = candidates.isNotEmpty;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: isTablet ? 20 : 16,
                      ),
                      decoration: BoxDecoration(
                        color: isHovering
                            ? _lesson.color.withValues(alpha: 0.16)
                            : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: _lesson.color.withValues(
                            alpha: isHovering ? 0.75 : 0.26,
                          ),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _lesson.color.withValues(alpha: 0.18),
                            blurRadius: isHovering ? 22 : 14,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            _lesson.letter,
                            style: TextStyle(
                              fontSize: isTablet ? 64 : 48,
                              height: 1,
                              fontWeight: FontWeight.w900,
                              color: _lesson.color,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.text(
                              'whichIs',
                              params: {'value': _lesson.word},
                            ),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _QuestionSoundButton(
                            color: _lesson.color,
                            isSpeaking: _isSpeaking,
                            onTap: _speakQuestion,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              _buildEnergyDots(),
              const SizedBox(height: 12),
              Expanded(
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: isTablet ? 1.05 : 0.84,
                  children: _lesson.options.map(_buildGameOption).toList(),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: _feedback == null
                    ? const SizedBox(height: 42)
                    : Container(
                        key: ValueKey(_feedback),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: _lessonComplete
                              ? const Color(0xFFECFDF5)
                              : const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: _lessonComplete
                                ? const Color(0xFF86EFAC)
                                : const Color(0xFFFED7AA),
                          ),
                        ),
                        child: Text(
                          _feedback!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            color: _lessonComplete
                                ? const Color(0xFF059669)
                                : const Color(0xFFEA580C),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayMascot(bool isTablet) {
    final l10n = AppLocalizations.of(context);
    return AnimatedBuilder(
      animation: Listenable.merge([_floatAnim, _hintAnim]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnim.value * 0.5),
          child: Transform.scale(scale: _hintAnim.value, child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _lesson.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: _lesson.color.withValues(alpha: 0.22)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_lesson.emoji, style: TextStyle(fontSize: isTablet ? 26 : 22)),
            const SizedBox(width: 8),
            Text(
              _lessonComplete
                  ? l10n.text('greatStars')
                  : l10n.text('listenThenChoose'),
              style: TextStyle(
                color: _lesson.color,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 6),
            const Text('✨', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildEnergyDots() {
    return AnimatedBuilder(
      animation: _hintCtrl,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final wave = math.sin((_hintCtrl.value + index * 0.14) * math.pi);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: 8 + wave.abs() * 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: index.isEven
                    ? _lesson.color.withValues(alpha: 0.72)
                    : Colors.amber.withValues(alpha: 0.78),
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildGameOption(_GameOption option) {
    final isSelected = _selectedWord == option.word;
    final selectedColor = option.isCorrect
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);

    final card = GestureDetector(
      onTap: () => _chooseOption(option),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? selectedColor : const Color(0xFFE2E8F0),
            width: isSelected ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (isSelected ? selectedColor : _lesson.color).withValues(
                alpha: isSelected ? 0.22 : 0.08,
              ),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(fit: BoxFit.contain, child: Text(option.emoji)),
            ),
            const SizedBox(height: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                option.word,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF334155),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return LongPressDraggable<_GameOption>(
      data: option,
      feedback: Material(
        color: Colors.transparent,
        child: Transform.scale(
          scale: 0.86,
          child: SizedBox(width: 120, height: 120, child: card),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.4, child: card),
      child: card,
    );
  }

  Widget _buildBottomControls() {
    final l10n = AppLocalizations.of(context);
    final isLast = _currentIndex == _lessons.length - 1;
    final mainLabel = !_playMode
        ? l10n.text('tryGame')
        : !_lessonComplete
        ? l10n.text('findCorrect')
        : isLast
        ? l10n.text('quiz')
        : l10n.text('nextLesson');

    return Row(
      children: [
        Expanded(
          child: _RoundActionButton(
            label: l10n.text('previous'),
            icon: Icons.chevron_left_rounded,
            enabled: _currentIndex > 0,
            color: const Color(0xFF64748B),
            onTap: () => _goToLesson(_currentIndex - 1),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: _RoundActionButton(
            label: mainLabel,
            icon: !_playMode
                ? Icons.extension_rounded
                : _lessonComplete
                ? Icons.chevron_right_rounded
                : Icons.touch_app_rounded,
            enabled: true,
            color: _lessonComplete || !_playMode
                ? _lesson.color
                : const Color(0xFFF59E0B),
            onTap: _nextAction,
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration(Color color) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(32),
      border: Border.all(color: color.withValues(alpha: 0.18), width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.16),
          blurRadius: 26,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.lessonNumber,
    required this.totalLessons,
    required this.title,
    required this.stars,
    required this.onBack,
  });

  final int lessonNumber;
  final int totalLessons;
  final String title;
  final int stars;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton.filledTonal(
          onPressed: onBack,
          icon: const Icon(Icons.chevron_left_rounded),
          color: const Color(0xFF475569),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$title $lessonNumber/$totalLessons',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Text(
            '⭐ $stars',
            style: const TextStyle(
              color: Color(0xFFD97706),
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressPills extends StatelessWidget {
  const _ProgressPills({
    required this.total,
    required this.current,
    required this.completed,
    required this.color,
  });

  final int total;
  final int current;
  final Set<int> completed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        final active = index == current;
        final done = completed.contains(index);
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: done || active ? color : const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(999),
              boxShadow: active
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.35),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }
}

class _ModeSwitch extends StatelessWidget {
  const _ModeSwitch({
    required this.playMode,
    required this.color,
    required this.onLearn,
    required this.onPlay,
  });

  final bool playMode;
  final Color color;
  final VoidCallback onLearn;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          _ModeChip(
            label: l10n.text('learn'),
            icon: Icons.school_rounded,
            active: !playMode,
            color: color,
            onTap: onLearn,
          ),
          _ModeChip(
            label: l10n.text('play'),
            icon: Icons.extension_rounded,
            active: playMode,
            color: color,
            onTap: onPlay,
          ),
        ],
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.icon,
    required this.active,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: active ? Colors.white : const Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: active ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmojiBadge extends StatelessWidget {
  const _EmojiBadge({
    required this.emoji,
    required this.color,
    required this.size,
  });

  final String emoji;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [Colors.white, color.withValues(alpha: 0.2)],
        ),
        border: Border.all(color: Colors.white, width: 6),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.24),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(child: Text(emoji, style: const TextStyle(fontSize: 68))),
    );
  }
}

class _SpeakButton extends StatelessWidget {
  const _SpeakButton({
    required this.color,
    required this.isSpeaking,
    required this.speakerAnim,
    required this.onTap,
  });

  final Color color;
  final bool isSpeaking;
  final Animation<double> speakerAnim;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: speakerAnim,
      builder: (context, child) {
        return Transform.scale(
          scale: isSpeaking ? speakerAnim.value : 1,
          child: child,
        );
      },
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        icon: Icon(
          isSpeaking ? Icons.graphic_eq_rounded : Icons.volume_up_rounded,
        ),
        label: Text(
          AppLocalizations.of(context).text('listen'),
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
      ),
    );
  }
}

class _QuestionSoundButton extends StatelessWidget {
  const _QuestionSoundButton({
    required this.color,
    required this.isSpeaking,
    required this.onTap,
  });

  final Color color;
  final bool isSpeaking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.24),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSpeaking ? Icons.graphic_eq_rounded : Icons.volume_up_rounded,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              AppLocalizations.of(context).text('listenQuestion'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundActionButton extends StatelessWidget {
  const _RoundActionButton({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool enabled;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        opacity: enabled ? 1 : 0.4,
        duration: const Duration(milliseconds: 180),
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.28),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingBubble extends StatelessWidget {
  const _FloatingBubble({
    required this.alignment,
    required this.icon,
    required this.color,
  });

  final Alignment alignment;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Center(child: Text(icon, style: const TextStyle(fontSize: 18))),
      ),
    );
  }
}

class _CelebrationStars extends StatelessWidget {
  const _CelebrationStars({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: List.generate(10, (index) {
              final progress = Curves.easeOut.transform(controller.value);
              final angle = index * math.pi * 2 / 10;
              final radius = progress * 120;
              return Positioned(
                left:
                    MediaQuery.of(context).size.width / 2.7 +
                    math.cos(angle) * radius,
                top: 180 + math.sin(angle) * radius,
                child: Opacity(
                  opacity: (1 - progress).clamp(0, 1),
                  child: Transform.rotate(
                    angle: angle + progress,
                    child: const Text('⭐', style: TextStyle(fontSize: 18)),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
