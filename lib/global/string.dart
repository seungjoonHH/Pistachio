
bool hasBottomConsonant(String input) {
  return (input.runes.last - 0xAC00) % 28 != 0;
}

String eunNeun(String input) => hasBottomConsonant(input) ? '은' : '는';
String iGa(String input) => hasBottomConsonant(input) ? '이' : '가';
String eulReul(String input) => hasBottomConsonant(input) ? '을' : '를';