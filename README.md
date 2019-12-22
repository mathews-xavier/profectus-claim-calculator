# profectus-claim-calculator

How to run the applicaion?

1.Import the databse to MySql dB using the file(SQL file/ledger.sql).
2.Import the CalcApp1 application to eclipse or similar IDE (profectus-claim-calculator/CalcApp1/)
3.Update the project using Maven
4.Change the mysql connection parameters on application.properties (CalcApp1/src/main/resources/application.properties)
5.Run the file CalcApp1/src/main/java/com/calc/CalcApp1Application.java
6.Use the localhost url on your browser to operate the application (http://localhost:8080/)

IMPORTANT : Please connect to a internet connection before running the application because some of the frontend libraries are loading from CDN

Technologies Used

Frontend : HTML5,CSS,Bootrap 4,jQuery,Javascript
Backend : Java 8, SpringBoot 2 ,SpringJPA,Mockito,jUnit
Database : MySql
