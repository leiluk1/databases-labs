select name 
	from University 
    where location = "Russia";

Select location
  from Student
  join University ON University.name = Student.university_name
  WHERE Student.native_language = "Russian" AND University.location != "Russia";
    
Select id 
  from Student
  join University ON University.name = Student.university_name
  WHERE University.name= "Innopolis University";

SELECT name, university_name
  FROM Course
  Where credits > 5;

Select DISTINCT university_name
  from Student
  join University ON University.name = Student.university_name
  WHERE Student.native_language = "English";