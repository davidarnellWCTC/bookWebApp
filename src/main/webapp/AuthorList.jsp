<%-- 
    Document   : AuthorList
    Author     : David Arnell
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

        <link href="BookWebAppCSS.css" rel="stylesheet" type="text/css"/>

        <title>Author List</title>
    </head>
    <body>


        <div id="content" class="container">
            <h1>Complete Author List</h1>

            <h3>Authors in the Author List</h3>

            <p><a href="${pageContext.request.contextPath}/AuthorController?action=homePage">Home Page</a></p>

            <div>
                <%@include file='AddAuthor.jsp'%>
            </div>

            </br>

            <%
                //checks to see if there is a valid author list and prints the list
                Object authorList = request.getAttribute("authorList");

                if (authorList == null) {
                    //out.println(request.getAttribute("errorMessage"));
                    out.println("Author List not found.");
                }
            %>

            <table style="width:50%" class="table table-striped table-bordered" >
                <tr>
                    <th class="text-center">Author Name</th>
                    <th class="text-center">Author ID</th>
                    <th class="text-center">Add Date</th>
                    <th class="text-center">Edit</th>
                    <th class="text-center">Delete</th>
                </tr>
                <!-- Getting error that there is no "author id" -->
                <!-- Fixed error, misspelled authorId -->
                <c:forEach var="author" items="${authorList}">
                    <tr>
                        <td class="text-center">${author.authorName}</td>
                        <td class="text-center">${author.authorId}</td>
                        <td class="text-center"><fmt:formatDate value="${author.dateAdded}" pattern="M/d/yyyy"/></td>
                        <td class="text-center">
                            <!--button>Edit?</button-->
                            <!--  -->
                            <input type="submit" name="submit" value="Edit" class="editButton" id="authorId${author.authorId}"/>

                        </td>
                        <td class="text-center">
                            <!--input value="Delete?"  name="deleteButton" id="deleteButton" action="AuthorController?action=deleteAuthorRecord" method="post" -->
                            <!--button>Delete?</button-->
                            <form method="POST" action="${pageContext.request.contextPath}/AuthorController?action=deleteAuthorRecord" 
                                  id="deleteButton" name="deleteButton">
                                <input hidden name="authorId" value="${author.authorId}"/>
                                <input type="submit" name="submit" value="Delete"/>
                            </form>
                        </td>
                    </tr>

                    <!-- The tr "table row" has an id of "authorId#" to make the id a String -->
                    <tr class="editAuthor" id="authorId${author.authorId}">
                        <%@include file='EditAuthor.jsp'%>                        
                    </tr>
                </c:forEach>            
            </table>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="BookWebAppJS.js" type="text/javascript"></script>
    </body>
</html>
