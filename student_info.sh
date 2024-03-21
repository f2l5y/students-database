#!/bin/bash
  2 
  3 # Info about my computer science students from students database
  4 
  5 echo -e "\n~~ My Computer Science Students ~~\n"
  6 
  7 PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"
  8 
  9 echo -e "\nFirst name, last name, and GPA of students with a 4.0 GPA:"
 10 echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE gpa = 4.0")"
 11 
 12 echo -e "\nAll course names whose first letter is before 'D' in the alphabet:"
 13 echo "$($PSQL "SELECT course FROM courses WHERE course < 'D'")"
 14 
 15 echo -e "\nFirst name, last name, and GPA of students whose last name begins with an 'R' or after and have a GPA greater than 3.8     or less than 2.0:"
 16 echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE last_name >= 'R' AND (gpa > 3.8 OR gpa < 2.0)")"
 17 
 18 echo -e "\nLast name of students whose last name contains a case insensitive 'sa' or have an 'r' as the second to last letter:"
 19 echo "$($PSQL "SELECT last_name FROM students WHERE last_name ILIKE '%sa%' OR last_name ILIKE '%r_'")"
 20 
 21 echo -e "\nFirst name, last name, and GPA of students who have not selected a major and either their first name begins with 'D' o    r they have a GPA greater than 3.0:"
 22 echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE major_id IS NULL AND (first_name LIKE 'D%' OR gpa > 3.0)")"
 24 echo -e "\nCourse name of the first five courses, in reverse alphabetical order, that have an 'e' as the second letter or end wit    h an 's':"
 25 echo "$($PSQL "SELECT course FROM courses WHERE course LIKE '_e%' OR course LIKE '%s' ORDER BY course DESC LIMIT 5")"
 26 
 27 echo -e "\nAverage GPA of all students rounded to two decimal places:"
 28 echo "$($PSQL "SELECT ROUND(AVG(gpa), 2) FROM students")"
 29 
 30 echo -e "\nMajor ID, total number of students in a column named 'number_of_students', and average GPA rounded to two decimal plac    es in a column name 'average_gpa', for each major ID in the students table having a student count greater than 1:"
 31 echo "$($PSQL "SELECT major_id, COUNT(*) AS number_of_students, ROUND(AVG(gpa), 2) AS average_gpa FROM students GROUP BY major_id     HAVING COUNT(*) > 1")"
 32 
 33 echo -e "\nList of majors, in alphabetical order, that either no student is taking or has a student whose first name contains a c    ase insensitive 'ma':"
 34 echo "$($PSQL "SELECT major FROM students FULL JOIN majors ON students.major_id = majors.major_id WHERE major IS NOT NULL AND (st    udent_id IS NULL OR first_name ILIKE '%ma%') ORDER BY major")"
 35 
 36 echo -e "\nList of unique courses, in reverse alphabetical order, that no student or 'Obie Hilpert' is taking:"
 37 echo "$($PSQL "SELECT DISTINCT(course) FROM courses FULL JOIN majors_courses USING(course_id) FULL JOIN students USING(major_id)     WHERE student_id IS NULL OR first_name='Obie' ORDER BY course DESC;")"
 38 
 39 echo -e "\nList of courses, in alphabetical order, with only one student enrolled:"
 40 echo "$($PSQL "SELECT course  FROM courses FULL JOIN majors_courses USING(course_id) FULL JOIN students USING(major_id) GROUP BY     course HAVING count(student_id) = 1  ORDER BY course ASC")"
