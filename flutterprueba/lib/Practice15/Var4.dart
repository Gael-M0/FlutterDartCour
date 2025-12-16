void main() {
    List<String> fruits = ['Apple', 'Banana', 'Cherry'];
    Map<String, int> scores = {'Alice':90,'Bob':85,'Charlie':95};
    String? nullableString = null;
    var city = 'New York';
    String country = 'USA';

    print('City : $city');
    print('Country : $country');

    print('Fruits: $fruits');
    print('Score of Alice: ${scores['Alice']}');
    print('Nullable String: $nullableString');
}