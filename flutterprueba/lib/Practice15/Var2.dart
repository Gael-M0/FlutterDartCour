class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void displayInfo() {
    print('Name: $name, Age: $age');
  }
}

void main() {
  Person person = Person('Bob', 30);
  person.displayInfo();
}