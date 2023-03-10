import 'dart:io';
void main() {
  var elements = ["js", "js", "js", "golang", "flutter", "js", "flutter", "golang", "rust", "golang", "flutter", "flutter"];
  var map = Map();

  elements.forEach((element) {
    if(!map.containsKey(element)) {
      map[element] = 1;
    } else {
      map[element] += 1;
    }
  });

  print(map);
}
