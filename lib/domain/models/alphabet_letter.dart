class AlphabetLetter {
  final String char;
  final String audioPath;
  final bool isUppercase;

  AlphabetLetter({
    required this.char,
    required this.audioPath,
    this.isUppercase = true,
  });

  String get id => '${char}_${isUppercase ? 'upper' : 'lower'}';
}

final List<String> latinAlphabet = List.generate(26, (index) => String.fromCharCode(65 + index));
