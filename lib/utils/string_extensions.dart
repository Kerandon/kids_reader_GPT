extension StringExtensions on String {
  List<String> splitByWords() {
    // This regex matches words with punctuation as one group
    final regex = RegExp(r"\b[\w']+[.,!?;]*");
    final matches = regex.allMatches(this);
    final words = matches.map((match) => match.group(0)!).toList();

    return words;
  }
  String toSentenceCase() {
    // Split the string by uppercase letters
    List<String> words = split(RegExp(r"(?=[A-Z])"));
    // Capitalize the first word and lowercase the rest
    words[0] = words[0][0].toUpperCase() + words[0].substring(1).toLowerCase();
    for (int i = 1; i < words.length; i++) {
      words[i] = words[i].toLowerCase();
    }
    // Join the words with spaces
    return words.join(" ");
  }
}
