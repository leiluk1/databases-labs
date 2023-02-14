select name from University 
  where location = "Russia";

select location from Student
  join University on University.name = Student.university_name
  where Student.native_language = "Russian" and University.location != "Russia";
    
select id from Student
  join University on University.name = Student.university_name
  where University.name= "Innopolis University";

select name, university_name from Course
  where credits > 5;

select distinct university_name from Student
  join University on University.name = Student.university_name
  where Student.native_language = "English";
