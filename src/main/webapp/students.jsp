<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="org.w3c.dom.Element" %>

<%
    // Load the XML file
    String xmlFilePath = request.getServletContext().getRealPath("/") + "student_details.xml";
    File xmlFile = new File(xmlFilePath);
    DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
    DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
    Document doc = dBuilder.parse(xmlFile);

    // Normalize the document
    doc.getDocumentElement().normalize();

    // Get the list of person elements
    NodeList nodeList = doc.getElementsByTagName("student");
%>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>


</head>
<body>
<jsp:include page="header.jsp" />



<div class="container">
    <br>
    <h1>Student Records</h1>
    <br>
<table id="data-table" class="table table-striped table-hover">
    <thead class="table table-primary">
    <tr>
        <th style="display:none;">ID</th>
        <th>Student ID</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Phone</th>
        <th></th>
    </tr>
    </thead>

    <!-- Iterate over each person element and display details -->
    <% for (int i = 0; i < nodeList.getLength(); i++) {
        Node studentNode = nodeList.item(i);
        if (studentNode.getNodeType() == Node.ELEMENT_NODE) {
            Element studentElement = (Element) studentNode;
    %>

    <tr>
        <td style="display:none;"><%= studentElement.getElementsByTagName("id").item(0).getTextContent() %></td>
        <td><%= studentElement.getElementsByTagName("StudentID").item(0).getTextContent() %></td>
        <td><%= studentElement.getElementsByTagName("fname").item(0).getTextContent() %></td>
        <td><%= studentElement.getElementsByTagName("lname").item(0).getTextContent() %></td>
        <td><%= studentElement.getElementsByTagName("phone").item(0).getTextContent() %></td>
        <td><button class="btn btn-danger" onclick="deleteUser(event, '<%= studentElement.getElementsByTagName("id").item(0).getTextContent() %>', '<%= studentElement.getElementsByTagName("fname").item(0).getTextContent() %>', '<%= studentElement.getElementsByTagName("lname").item(0).getTextContent() %>', '<%= studentElement.getElementsByTagName("StudentID").item(0).getTextContent() %>', '<%= studentElement.getElementsByTagName("phone").item(0).getTextContent() %>')">DELETE</button></td>

    </tr>

    <% }
    } %>
</table>
</div>

<script>
    async function deleteUser(event, id, fname,lname,StudentID,phone) {
        event.stopPropagation();


           try {
               console.log("id: "+id)
               console.log("\nfname: "+fname)
               console.log("\nlname: "+lname)
               console.log("\nStudentID: "+StudentID)
               console.log("\nphone: "+phone)

               var url = "${pageContext.request.contextPath}/deleteUserData.jsp?id="+id+"&fname="+fname+"&lname="+lname+"&StudentID="+StudentID+"&phone="+phone;
               window.location.href=url;



            } catch (error) {
                console.error('Error during fetch:', error);
            }


    }

</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var table = document.getElementById('data-table');
        var rows = table.getElementsByTagName('tr');

        for (var i = 0; i < rows.length; i++) {
            rows[i].addEventListener('click', function () {
                // Get the data from the clicked row
                var cells = this.getElementsByTagName('td');
                var rowData = [];

                // Loop through each cell in the row
                for (var j = 0; j < cells.length; j++) {
                    // Store the value in the rowData array
                    rowData.push(cells[j].textContent);
                }

                // Do something with the rowData
                // access individual values like this:
                var id = rowData[0]
                var StudentID = rowData[1];
                var fname = rowData[2];
                var lname = rowData[3];
                var phone = rowData[4];

                var url = "${pageContext.request.contextPath}/editUserData.jsp?id="+id+"&fname="+fname+"&lname="+lname+"&StudentID="+StudentID+"&phone="+phone;
                window.location.href=url;
            });
        }
    });
</script>


</body>
</html>
