<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>


</head>
<body>
<jsp:include page="header.jsp" />
<% int x = 25;%>
<% LocalDateTime now = LocalDateTime.now(); %>

<div class="container">




    <div class="row">

        <div class="col-6">

                <br>
                <img src="studentrec.jpg">

        </div>


    <div class="col-6">
        <center>
    <form action="${pageContext.request.contextPath}/hello-servlet" name="myForm" method="post">

        <br><br>
        <h2>Register New Student</h2>
        <br><br>



        <div class="col-12">
            <label for="StudentID">Student ID: </label><br>
            <input type="text" id="StudentID" class="formElement" name="StudentID" placeholder="Your Student ID" required><br>
        </div><br>


        <div class="col-12">
            <label for="fname">First name: </label><br>
            <input type="text" id="fname" class="formElement" name="fname" placeholder="Your First Name" required><br>
        </div><br>

        <div class="col-12">
            <label for="lname">Last name: </label><br>
            <input type="text" id="lname" class="formElement" name="lname" placeholder="Your Last Name" required><br>
        </div><br>





        <div class="col-12">
            <label for="phone">Phone Num: </label><br>
            <input type="text" id="phone" class="formElement" name="phone" placeholder="Your phone number" required><br><br>
        </div><br>

        <input type="submit" value="SUBMIT" class="btn btn-primary">

    </form>
        </center>
    </div>

    </div>


</div>
</body>
</html>
