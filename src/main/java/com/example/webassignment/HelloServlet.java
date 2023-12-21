
package com.example.webassignment;
//import libraries
import java.io.*;
import java.time.LocalDateTime;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
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

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {






    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        Integer id = (Integer)getServletContext().getAttribute("ID");
        if(id==null){
            id=0;
        }
        String fname = request.getParameter("fname");
        String lname = (String) request.getParameter("lname");
        String NIC = request.getParameter("NIC");
        String phone = request.getParameter("phone");












        id++;
        File xmlFile = new File(getServletContext().getRealPath("/") + "patient_details.xml");

        //To obtain DocumentBuilder instances
        DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();

        try {
            //DocumentBuilder instance
            DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
            Document document;
            //Check for XML file
            if(xmlFile.exists()){
                document = documentBuilder.parse(xmlFile);
            }else{
                document = documentBuilder.newDocument();
                Element root = document.createElement("users");
                document.appendChild(root);
            }

            //add new person element
            Element personElement = document.createElement("patient");
            document.getDocumentElement().appendChild(personElement);

            //add child element data

            //unique id for each person
            Element idElement = document.createElement("id");
            idElement.appendChild(document.createTextNode((String)getTime()));
            personElement.appendChild(idElement);

            //assign name
            Element nameElement = document.createElement("fname");
            nameElement.appendChild(document.createTextNode(fname));
            personElement.appendChild(nameElement);

            //assign age
            Element ageElement = document.createElement("lname");
            ageElement.appendChild(document.createTextNode(lname));
            personElement.appendChild(ageElement);

            //assign email
            Element emailElement = document.createElement("NIC");
            emailElement.appendChild(document.createTextNode(NIC));
            personElement.appendChild(emailElement);




            Element phoneElement = document.createElement("phone");
            phoneElement.appendChild(document.createTextNode(phone));
            personElement.appendChild(phoneElement);

            TransformerFactory transformerFactory = TransformerFactory.newInstance();

            Transformer transformer = transformerFactory.newTransformer();
            DOMSource domSource = new DOMSource(document);
            StreamResult streamResult = new StreamResult(xmlFile);
            transformer.transform(domSource, streamResult);

            //store current id in servletcontext
            getServletContext().setAttribute("ID", id);

            // Send a response
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<script type=\"text/javascript\">");
            out.println("window.location.href = 'index.jsp';");
            out.println("alert('Data saved successfully!!');");
            out.println("document.getElementById(\"myForm\").reset();");
            out.println("</script>");
            out.println("</body></html>");

        } catch (ParserConfigurationException | SAXException | TransformerConfigurationException e) {
            // Send a response
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Error occurred!!');");
            out.println("</script>");
            out.println("</body></html>");

            throw new RuntimeException(e);
        } catch (TransformerException e) {
            // Send a response
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Error occurred!!!!');");
            out.println("</script>");
            out.println("</body></html>");

            throw new RuntimeException(e);
        }
    }

    public void destroy() {
    }

    public String getTime(){
        LocalDateTime obj = LocalDateTime.now();
        return obj.toString();
    }
}
