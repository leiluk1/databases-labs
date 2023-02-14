create table University (
    name VARCHAR(30) primary key,
    location VARCHAR(30)
);

create table Student (
    id INTEGER primary key,
    name VARCHAR(30),
    native_language VARCHAR(30),
    university_name VARCHAR(30) references University(name)
);

create table Course (
    name VARCHAR(30) primary key,
    credits INTEGER,
    university_name VARCHAR(30) references University(name)
);

create table Enroll (
   student_id VARCHAR(30) references Student(id),
   course_name VARCHAR(30) references Course(name)
);

insert into Student (id, name, native_language, university_name) values
    (1, "Carry Brad", "English", "Northwestern University"),
    (2, "Anna Smith", "English", "University of California"),
    (3, "Bailey Kathy", "English", "Innopolis University"),
    (4, "Alisia Meagan", "English", "University of California"), 
    (5, "Hikari Yoshiro", "Japanese", "Innopolis University"), 
    (6, "Leila Khaertdinova", "Russian", "Innopolis University"),
    (7, "Ruslan Garaev", "Russian", "University of California"),
    (8, "Emily Garden", "English", "Northwestern University"),
    (9, "Akari Jurou", "Japanese", "Northwestern University"),
    (10, "Adam Megan", "English", "Innopolis University");

insert into University (name, location) values 
    ("Northwestern University", "USA"),
    ("University of California", "USA"),
    ("Innopolis University", "Russia");
    
insert into Course (name, credits, university_name) values 
    ("Networks in NU", 2, "Northwestern University"),
    ("Databases in NU", 6, "Northwestern University"),
    ("Machine Learning in NU", 3, "Northwestern University"),
    ("Statistical Techniques in NU", 7, "Northwestern University"),
    ("Networks in UC", 2, "University of California"),
    ("Databases in UC", 6, "University of California"),
    ("Machine Learning in UC", 8, "University of California"),
    ("Statistical Techniques in UC", 7, "University of California"),
    ("Networks in IU", 2, "Innopolis University"),
    ("Databases in IU", 1, "Innopolis University"),
    ("Machine Learning in IU", 8, "Innopolis University"),
    ("Statistical Techniques in IU", 8, "Innopolis University");
    
insert into Enroll (student_id, course_name) values
    (1, "Machine Learning in NU"),
    (1, "Statistical Techniques in NU"),
    (2, "Databases in UC"),
    (2, "Networks in UC"),
    (3, "Databases in IU"),
    (3, "Networks in IU"),
    (3, "Machine Learning in IU"),
    (4, "Databases in UC"),
    (4, "Statistical Techniques in UC"),
    (5, "Databases in IU"),
    (6, "Machine Learning in IU"),
    (7, "Databases in UC"),
    (8, "Databases in NU"),
    (9, "Machine Learning in NU"),
    (10, "Networks in IU"),
    (10, "Machine Learning in IU");
    
select name from University 
    where location = "Russia";

select location from Student
  join University on University.name = Student.university_name
  where Student.native_language = "Russian" and University.location != "Russia";
    
select id 
  from Student
  join University on University.name = Student.university_name
  where University.name= "Innopolis University";

select name, university_name
  from Course
  where credits > 5;

select distinct university_name
  from Student
  join University on University.name = Student.university_name
  where Student.native_language = "English";
