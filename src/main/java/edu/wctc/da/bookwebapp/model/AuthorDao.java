/*
 * 
 */
package edu.wctc.da.bookwebapp.model;

import java.sql.SQLException;
import java.util.*;

/**
 *
 * @author David Arnell
 */
public class AuthorDao implements AuthorDaoStrategy {

    // DbStrategy, used in Constructor to ensure class has one
    private DbStrategy db;

    // openConnection info used in getAuthorList
    private String driverClass;
    private String url;
    private String userName;
    private String password;

    // cannot create an AuthorDao object without a DbStrategy
    public AuthorDao(DbStrategy db, String driverClass, String url, String userName, String password) {
        this.db = db;
        this.driverClass = driverClass;
        this.url = url;
        this.userName = userName;
        this.password = password;
    }

    @Override
    public List<Author> getAuthorList() throws ClassNotFoundException, SQLException {

        // the first part of finding the records is opening the connection
        db.openConnection(driverClass, url, userName, password);

        //List of Maps of all the records in the table
        List<Map<String, Object>> records = db.findAllRecords("author", 500);

        // List to store the Author Objects
        List<Author> authors = new ArrayList<>();

        // for each record in records
        for (Map<String, Object> rec : records) {
            Author author = new Author();

            // gets the author_id as an object, parses it to a String, and parses it to an integer
            int authorId = Integer.parseInt(rec.get("author_id").toString());

            //sets the authorId value for the Author object created in this for loop
            author.setAuthorId(authorId);

            // gets the author name and checks if it's null
            String authorName = rec.get("author_name").toString();
            author.setAuthorName(authorName != null ? authorName : "");

            //gets the date added Date Object, just casts it to a Date Object
            Date dateAdded = (Date) rec.get("date_added");
            author.setDateAdded(dateAdded);

            // adds the new Author to the List
            authors.add(author);
        }

        // the last thing is closing the connection
        db.closeConection();

        // returns the List of Author Objects after closing the connection
        return authors;
    }

    public DbStrategy getDb() {
        return db;
    }

    public void setDb(DbStrategy db) {
        this.db = db;
    }

    

    @Override
    public Author findAuthorByKey(int key)  throws ClassNotFoundException, SQLException {
        List<Author> authors = getAuthorList();
        Author author = authors.get(key);
        
        return author;
    }

    @Override
    public void updateAuthorByKey(Author author, int key) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void createNewAuthor(Author author)   throws ClassNotFoundException, SQLException{
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void deleteAuthorByPrimaryKey(int key)   throws ClassNotFoundException, SQLException{
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    // throws generic exception to handle everything for the dbstrategy
    public static void main(String[] args) throws Exception {
        AuthorDao dao = new AuthorDao(
                new MySqlDbStrategy(), // db strategy passed into the AuthorDao constructor
                "com.mysql.jdbc.Driver", //driver to use
                "jdbc:mysql://localhost:3306/book", // url of the database
                "root", "admin"); // username and password
        
        // creates the List of Author Objects from the dao method "getAuthorList"
        // this method will work with any DbStrategy
        List<Author> authors = dao.getAuthorList();
        
        // prints out a the authors unformatted
        System.out.println(authors);
        
    }

}