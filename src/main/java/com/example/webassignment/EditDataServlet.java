
package com.example.webassignment;

import java.io.*;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

@WebServlet(name = "editDataServlet", value = "/editData-servlet")
public class EditDataServlet extends HttpServlet {



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String id = request.getParameter("id");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String StudentID = request.getParameter("StudentID");
        String phone = request.getParameter("phone");




        File xmlFile = new File(getServletContext().getRealPath("/") + "student_details.xml");

        //To obtain DocumentBuilder instances
        DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();

        try {
            // DocumentBuilder instance
            DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
            Document document;

            // Check for XML file
            if (xmlFile.exists()) {
                document = documentBuilder.parse(xmlFile);

                // Locate the person element based on id
                NodeList personList = document.getElementsByTagName("student");
                for (int i = 0; i < personList.getLength(); i++) {
                    Element personElement = (Element) personList.item(i);
                    String existingId = personElement.getElementsByTagName("id").item(0).getTextContent();

                    // Assuming you want to modify the person with a specific id
                    if (existingId.equals(id)) {
                        // Make the necessary changes
                        personElement.getElementsByTagName("fname").item(0).setTextContent(fname);
                        personElement.getElementsByTagName("lname").item(0).setTextContent(lname);
                        personElement.getElementsByTagName("StudentID").item(0).setTextContent(StudentID);
                        personElement.getElementsByTagName("phone").item(0).setTextContent(phone);

                        // Save the changes to the XML file
                        TransformerFactory transformerFactory = TransformerFactory.newInstance();
                        Transformer transformer = transformerFactory.newTransformer();
                        DOMSource domSource = new DOMSource(document);
                        StreamResult streamResult = new StreamResult(xmlFile);
                        transformer.transform(domSource, streamResult);

                        // Send a response
                        response.setContentType("text/html");
                        PrintWriter out = response.getWriter();
                        out.println("<html><body>");
                        out.println("<script type=\"text/javascript\">");
                        out.println("window.location.href = 'students.jsp';");  // Redirect to students.jsp
                        out.println("alert('Data saved successfully!!');");
                        out.println("document.getElementById(\"myForm\").reset();");
                        out.println("</script>");
                        out.println("</body></html>");

                        break;
                    }
                }
            }
        } catch (TransformerConfigurationException e) {
            throw new RuntimeException(e);
        } catch (ParserConfigurationException e) {
            throw new RuntimeException(e);
        } catch (TransformerException e) {
            throw new RuntimeException(e);
        } catch (SAXException e) {
            throw new RuntimeException(e);
        }
    }

        public void destroy() {
    }
}
