
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

}