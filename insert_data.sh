#!/bin/bash
  2 
  3 # Script to insert data from courses.csv and students.csv into students database
  4 
  5 PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"
  6 echo $($PSQL "TRUNCATE students, majors, courses, majors_courses")
  7 
  8 cat courses.csv | while IFS="," read MAJOR COURSE
  9 do
 10   if [[ $MAJOR != "major" ]]
 11   then
 12     # get major_id
 13     MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
 14 
 15     # if not found
 16     if [[ -z $MAJOR_ID ]]
 17     then
 18       # insert major
 19       INSERT_MAJOR_RESULT=$($PSQL "INSERT INTO majors(major) VALUES('$MAJOR')")
 20       if [[ $INSERT_MAJOR_RESULT == "INSERT 0 1" ]]
 21       then
 22         echo Inserted into majors, $MAJOR
 23       fi
 24 
 25       # get new major_id
 26       MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
 27     fi
 28 
 29     # get course_id
 30     COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")
 31 
 32     # if not found
 33     if [[ -z $COURSE_ID ]]
 34     then
 35       # insert course
 36       INSERT_COURSE_RESULT=$($PSQL "INSERT INTO courses(course) VALUES('$COURSE')")
 37       if [[ $INSERT_COURSE_RESULT == "INSERT 0 1" ]]
 then
 39         echo Inserted into courses, $COURSE
 40       fi
 41 
 42       # get new course_id
 43       COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")
 44     fi
 45 
 46     # insert into majors_courses
 47     INSERT_MAJORS_COURSES_RESULT=$($PSQL "INSERT INTO majors_courses(major_id, course_id) VALUES($MAJOR_ID, $COURSE_ID)")
 48 if [[ $INSERT_MAJORS_COURSES_RESULT == "INSERT 0 1" ]]
 49         then
 50         echo Inserted into majors_courses, $MAJOR : $COURSE
 51   fi
 52 fi
 53 done
 54 
 55 cat students.csv | while IFS="," read FIRST LAST MAJOR GPA
 56 do
 57 if [[ $FIRST != first_name ]]
 58 then
 59 #get major_id
 60 MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
 61 #if not found
 62 if [[ -z $MAJOR_ID ]]
 63  then
 64 #set to null
 65 MAJOR_ID=null
 66 
 67 fi
 #set to null
 69 #insert student
 70     INSERT_STUDENT_RESULT=$($PSQL "INSERT INTO students(first_name,last_name,major_id,gpa) VALUES('$FIRST','$LAST',$MAJOR_ID    , $GPA)")
 71 if [[ $INSERT_STUDENT_RESULT == "INSERT 0 1" ]]
 72         then
 73         echo Inserted into students, $FIRST $LAST
 74   fi
 75 fi
 76 done
