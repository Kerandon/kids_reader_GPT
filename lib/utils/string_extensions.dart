extension StringExtensions on String {
  List<String> splitByWords() {
    // This regex matches words with punctuation as one group
    final regex = RegExp(r"\b[\w']+[.,!?;]*");
    final matches = regex.allMatches(this);
    final words = matches.map((match) => match.group(0)!).toList();

    return words;
  }
}