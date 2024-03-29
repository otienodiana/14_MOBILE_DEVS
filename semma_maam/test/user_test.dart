    // Creating a new user with valid username, email, and password should successfully create a new user object with the given values.
import 'package:flutter_test/flutter_test.dart';
import 'package:semma_maam/user.dart';

void main() {
  test('Creating a new user with valid username, email, and password should successfully create a new user object with the given values', () {
    // Arrange
    String username = 'testuser';
    String email = 'testuser@example.com';
    String password = 'password123';

    // Act
    Users user = Users(username: username, email: email, password: password);

    // Assert
    expect(user.username, equals(username));
    expect(user.email, equals(email));
    expect(user.password, equals(password));
  });
}