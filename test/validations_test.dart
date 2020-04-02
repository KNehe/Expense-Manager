import 'package:expensetracker/Utilities/validations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('ItemPrice Validation tests', (){

    test('Should fail when item price is empty', (){

      String result = Validation.itemPriceValidation('');

      expect(result, 'Item\'s price is required');

    });

    test('Should fail if Item Price is not number', (){

      String result = Validation.itemPriceValidation('dsd333');

      expect(result, 'Invalid');

    });


    test('Should pass and return no message when Item Price is valid', (){

      String result = Validation.itemPriceValidation('500');

      expect(result, null);

    });

  });

  group("Email validation tests", (){


    test('Expect email to be valid', () {

      String result = Validation.emailValidation("k@gmail.com");

      expect(result, null);

    });

    test('Expect email to be invalid', () {
      String result = Validation.emailValidation("kgmail.com");

      expect(result, 'Invalid email');

    });


    test('Email should be required when empty', () {

      String result = Validation.emailValidation(" ");

      expect(result, 'Your email is required');

    });

  });

  group("Password validation", (){

    test("Password should be required when empty", (){

      String result = Validation.passwordValidation('', false);

      expect(result, 'Your password is required');

    });

    test('Should fail when password is less than 6 characters', (){

      String result = Validation.passwordValidation('ww', true);

      expect(result, '6 characters required');

    });

    test('Should return no message when password is valid', (){

      String result = Validation.passwordValidation('123342fdfs', true);

      expect(result, null);
    });

    test('Should not validate password when not empty', (){

      String result = Validation.passwordValidation('123342fdfs', false);

      expect(result, null);
    });

  });

  group('Income validation tests', (){

    test('Should require income when empty', (){

      String result = Validation.incomeValidation('');

      expect(result, 'Income required');
    });

    test('Should return no message when income is valid', (){

      String result = Validation.incomeValidation('500');

      expect(result, null);
    });

    test('Should return a message when income is invalid', (){

      String result = Validation.incomeValidation('500a');

      expect(result, 'Invalid');
    });


  });

  group('ItemName Validation tests', (){

    test('Should require item when empty', (){

      String result = Validation.itemNameValidation('');

      expect(result, 'Item\'s name is required');

    });

    test('Should fail if item length is than or equal to 2', (){

      String result = Validation.itemNameValidation('w');

      expect(result, 'Too short for a name');

    });

    test('Should fail if item is number', (){

      String result = Validation.itemNameValidation('222');

      expect(result, 'Invalid');

    });

    test('Should pass and return no message', (){

      String result = Validation.itemNameValidation('Calf');

      expect(result, null);

    });

  });


}