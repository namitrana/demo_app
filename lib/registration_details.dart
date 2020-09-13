
/// Used to store registration details(In-memory only) to be displayed on the last page
class RegistrationDetails{
  static String email = 'namit_232@yahoo.com';
  static String date = '2020-09-30';
  static String time = '14:00';

  static void setEmail(String email1){
    email =  email1;
  }

  static String getEmail(){
    return email;
  }

  static void setDate(String date1){
    date = date1;
  }

  static String getDate(){
    return date;
  }

  static void setTime(String time1){
    time = time1;
  }

  static String getTime(){
    return time;
  }


}