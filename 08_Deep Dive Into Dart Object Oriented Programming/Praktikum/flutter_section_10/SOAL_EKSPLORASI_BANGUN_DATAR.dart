// Interface untuk bangun datar
abstract class Shape {
  double getArea();
  double getPerimeter();
}

// Subkelas Circle
class Circle implements Shape {
  double radius;

  Circle(this.radius);

  @override
  double getArea() {
    return 3.14 * radius * radius;
  }

  @override
  double getPerimeter() {
    return 2 * 3.14 * radius;
  }
}

// Subkelas Square
class Square implements Shape {
  double side;

  Square(this.side);

  @override
  double getArea() {
    return side * side;
  }

  @override
  double getPerimeter() {
    return 4 * side;
  }
}

// Subkelas Rectangle
class Rectangle implements Shape {
  double width;
  double height;

  Rectangle(this.width, this.height);

  @override
  double getArea() {
    return width * height;
  }

  @override
  double getPerimeter() {
    return 2 * (width + height);
  }
}

void main() {
  // Membuat objek Circle dengan radius 7
  Circle circle = Circle(7);
  double circleArea = circle.getArea();
  double circlePerimeter = circle.getPerimeter();
  print("Luas lingkaran dengan radius 7: $circleArea");
  print("Keliling lingkaran dengan radius 7: $circlePerimeter");

  // Membuat objek Square dengan sisi 10
  Square square = Square(10);
  double squareArea = square.getArea();
  double squarePerimeter = square.getPerimeter();
  print("Luas persegi dengan sisi 10: $squareArea");
  print("Keliling persegi dengan sisi 10: $squarePerimeter");

  // Membuat objek Rectangle dengan lebar 6 dan tinggi 8
  Rectangle rectangle = Rectangle(7, 8);
  double rectangleArea = rectangle.getArea();
  double rectanglePerimeter = rectangle.getPerimeter();
  print("Luas persegi panjang dengan lebar 7 dan tinggi 8: $rectangleArea");
  print("Keliling persegi panjang dengan lebar 7 dan tinggi 8: $rectanglePerimeter");
}
