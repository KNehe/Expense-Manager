
enum FormShown{
  signInForm,
  signUpForm
}

class Validation{

    static String emailValidation(String email){

    bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

    if (email.trim().isEmpty)
    {
      return "Your email is required";
    }

    return emailValid ? null : "Invalid email";

  }


   static String passwordValidation(String password,bool shouldValidatePassword){


      if(password.trim().isEmpty){
        return 'Your password is required';
      }

      return password.trim().length < 6  && shouldValidatePassword ? '6 characters required': null;

  }

  static String incomeValidation(String income){

      if(income.trim().isEmpty){
        return 'Income required';
      }

      RegExp exp = RegExp(r'^[0-9]+$');
      return exp.hasMatch(income.trim()) ? null : 'Invalid';

  }

    static String itemNameValidation(String name){

      if(name.trim().isEmpty){
        return 'Item\'s name is required';
      }

      if(name.trim().length <= 2){
        return 'Too short for a name';
      }

      RegExp exp = RegExp(r'^[a-zA-Z ]+$', caseSensitive: false);
      return exp.hasMatch(name.trim()) ? null : 'Invalid';

    }

    static String itemPriceValidation(String price){

      if(price.trim().isEmpty){
        return 'Item\'s price is required';
      }

      RegExp exp = RegExp(r'^[0-9]+$');
      return exp.hasMatch(price.trim()) ? null : 'Invalid';

    }


}