package VAKS.run.Model;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import VAKS.run.Controller.LoginController;
import VAKS.run.GoogleCalendar.GoogleKalendar;

/**
 * The Model Class
 * 
 * @author Mohammed Ali Anis
 * @version 1.0
 * @since 1.0
 *
 */
public class AppWithDB {

	/**
	 * To Connect to the DB
	 * 
	 * @return Connection
	 */
	public static Connection connect() {
		String url = "jdbc:sqlite:/app/Database/VAKS.db";
		try {
			return DriverManager.getConnection(url);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

//	public static Connection connect() {
//
//		Connection connect = null;
//		// Path of the DB
//		String path = "/Users/mohammedalianis/Desktop/Bachelorarbeit/SQL/VAKS.db";
//
//		try {
//
//			connect = DriverManager.getConnection("jdbc:sqlite:" + path);
//
//		} catch (SQLException e) {
//
//			e.printStackTrace();
//		}
//
//		return connect;
//	}

	/**
	 * Rsponse about the get the role or the loggedin user
	 * 
	 * @param username the username from the login page
	 * @param password the password from the login page
	 * @return the role_id ( 1 Manager, 2 Worker, 3 Volunteer, 4 Customer)
	 * @throws SQLException
	 */
	public static int sqlLogin(String username, String password) throws SQLException {

		ResultSet r = null;
		int role_id = -1;

		String Query = "Select role_id from User NATURAL JOIN User_Role NATURAL Join Role where username='" + username
				+ "' AND password='" + password + "';";
		Statement s = null;
		s = AppWithDB.connect().createStatement();
		r = s.executeQuery(Query);
		while (r.next()) {
			role_id = r.getInt("role_id");
		}
		r.close();
		s.close();
		return role_id;
	}

	/**
	 * Response about list the mother languages
	 * 
	 * @return ArrayList with the mother languages
	 * @throws SQLException
	 */
	public static ArrayList<String> sqlSelectMotherLanguage() throws SQLException {

		ResultSet r = null;
		ArrayList<String> languageList = new ArrayList<String>();
		String Query = "Select language from Mother_Language";
		Statement s = null;
		s = AppWithDB.connect().createStatement();
		r = s.executeQuery(Query);
		while (r.next()) {
			languageList.add(r.getString("language"));
		}
		r.close();
		s.close();

		return languageList;
	}

	/**
	 * Response about list all the role
	 * 
	 * @return ArrayList with the role
	 * @throws SQLException
	 */
	public static ArrayList<String> sqlSelectRoleType() throws SQLException {

		ResultSet r = null;
		ArrayList<String> roleType = new ArrayList<String>();
		String Query = "Select role_type from Role;";
		Statement s = null;
		s = AppWithDB.connect().createStatement();
		r = s.executeQuery(Query);
		while (r.next()) {
			roleType.add(r.getString("role_type"));
		}
		r.close();
		s.close();

		return roleType;
	}

	/**
	 * Resonse about list all type of the residence permit
	 * 
	 * @return ArrayList with all types
	 * @throws SQLException
	 */
	public static ArrayList<String> sqlSelectResidencePermit() throws SQLException {

		ResultSet r = null;
		ArrayList<String> residencePermit = new ArrayList<String>();
		String Query = "Select residence_permit_type from Residence_Permit";
		Statement s = null;
		s = AppWithDB.connect().createStatement();
		r = s.executeQuery(Query);
		while (r.next()) {
			residencePermit.add(r.getString("residence_permit_type"));
		}
		r.close();
		s.close();

		return residencePermit;
	}

	/**
	 * Respone about add new User to the DB when he register by him Self
	 * 
	 * @param firstName          the firstname of the new user
	 * @param lastName           the lastname of the new user
	 * @param birthday           the birthday of the new uuser
	 * @param gender             the gender of the new user
	 * @param email              the email of the new user
	 * @param userName           the username of the new user
	 * @param password           the password of the new user
	 * @param country            the country of the new user
	 * @param motherLanguage     the mother language of the new user
	 * @param residencePermit    the residence permit type of the new user
	 * @param street             the home_street of the new user
	 * @param number             the house number of the new user
	 * @param city               the cuty of the new user
	 * @param post_code          the post code of the new user
	 * @param high_school        if the new user has high school
	 * @param university         if he study in the university
	 * @param integration_course if he has integration course certificate
	 * @param dsh_course         if he has DSH certificate
	 * @param german_level       what is his German level
	 */
	public static void sqlAddCustomerByHimSelf(String firstName, String lastName, String birthday, String gender,
			String email, String userName, String password, String country, String motherLanguage,
			String residencePermit, String street, String number, String city, String post_code, String high_school,
			String university, String integration_course, String dsh_course, String german_level) {

		try {

			Connection con1 = connect();

			String query1 = "insert into User (first_name, last_name, birthday, gender, country, email, username, password )  values ( '"
					+ firstName + "', '" + lastName + "', '" + birthday + "', '" + gender + "', '" + country + "', '"
					+ email + "', '" + userName + "', '" + password + "');";
			PreparedStatement posted1 = con1.prepareStatement(query1);
			posted1.execute();
			con1.close();
			posted1.close();

			Connection con2 = connect();
			String query2 = "Insert Into Address(street, number, city, post_code) values ('" + street + "', '" + number
					+ "', '" + city + "', '" + post_code + "');";
			PreparedStatement posted2 = con2.prepareStatement(query2);
			posted2.execute();
			con2.close();
			posted2.close();

			Connection con3 = connect();
			String query3 = "Insert Into User_Address values ( (Select user_id From User Where username='" + userName
					+ "' AND password='" + password + "') , (Select address_id from Address Where street='" + street
					+ "' AND number='" + number + "' AND city='" + city + "' AND post_code='" + post_code + "' ));";
			PreparedStatement posted3 = con3.prepareStatement(query3);
			posted3.execute();
			con3.close();
			posted3.close();

			Connection con4 = connect();
			String query4 = "INSERT into User_Residence_Permit values ( (Select user_id From User Where username='"
					+ userName + "' AND password='" + password
					+ "'), (Select residence_permit_id From Residence_Permit where residence_permit_type='"
					+ residencePermit + "'));";
			PreparedStatement posted4 = con4.prepareStatement(query4);
			posted4.execute();
			con4.close();
			posted4.close();

			Connection con5 = connect();
			String query5 = "Insert Into User_Role values ( (Select user_id From User Where username='" + userName
					+ "' AND password='" + password + "') , 4 );"; // Always 3 because Customer_Role_ID is 3
			PreparedStatement posted5 = con5.prepareStatement(query5);
			posted5.execute();
			con5.close();
			posted5.close();

			Connection con6 = connect();
			String query6 = "Insert Into Education (high_school, university, integration_course, dsh_course, german_level) values ('"
					+ high_school + "','" + university + "','" + integration_course + "','" + dsh_course + "','"
					+ german_level + "');";
			PreparedStatement posted6 = con6.prepareStatement(query6);
			posted6.execute();
			con6.close();
			posted6.close();

			Connection con7 = connect();
			String query7 = "Insert into User_Education values ((Select user_id From User Where username='" + userName
					+ "' AND password='" + password + "') , (SELECT MAX(education_id) FROM Education));";
			PreparedStatement posted7 = con7.prepareStatement(query7);
			posted7.execute();
			con7.close();
			posted7.close();

			Connection con8 = connect();
			String query8 = "Insert Into User_Mother_Language values ((Select user_id From User where username='"
					+ userName + "' AND password='" + password
					+ "'),(Select language_id from Mother_Language where language='" + motherLanguage + "'));";
			PreparedStatement posted8 = con8.prepareStatement(query8);
			posted8.execute();
			con8.close();
			posted8.close();

			Connection con = connect();
			String query = "Insert into Kunde_Supervised_By_Worker ( kunde_id, worker_id ) values ( (Select user_id from User where username='"
					+ userName + "' AND email='" + email
					+ "'), (Select user_id from User Natural Join User_Role Natural Join Role where role_type='Worker' ORDER BY random() LIMIT 1) );";
			PreparedStatement posted = con.prepareStatement(query);
			posted.execute();
			con.close();
			posted.close();

//			System.out.println("User has been added");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * 
	 * Response about add user to DB when someone add him
	 * 
	 * @param firstName          the firstname of the new user
	 * @param lastName           the lastname of the new user
	 * @param birthday           the birthday of the new uuser
	 * @param gender             the gender of the new user
	 * @param email              the email of the new user
	 * @param userName           the username of the new user
	 * @param password           the password of the new user
	 * @param country            the country of the new user
	 * @param motherLanguage     the mother language of the new user
	 * @param residencePermit    the residence permit type of the new user
	 * @param street             the home_street of the new user
	 * @param number             the house number of the new user
	 * @param city               the cuty of the new user
	 * @param post_code          the post code of the new user
	 * @param high_school        if the new user has high school
	 * @param university         if he study in the university
	 * @param integration_course if he has integration course certificate
	 * @param dsh_course         if he has DSH certificate
	 * @param german_level       what is his German level
	 * @param roleType           if the new user Manager, Worker, Customer or
	 *                           volunteer
	 */
	public static void sqlAddUserByManager(String firstName, String lastName, String birthday, String gender,
			String email, String userName, String password, String country, String motherLanguage,
			String residencePermit, String street, String number, String city, String post_code, String high_school,
			String university, String integration_course, String dsh_course, String german_level, String roleType) {

		try {

			Connection con1 = connect();

			String query1 = "insert into User (first_name, last_name, birthday, gender, country, email, username, password )  values ( '"
					+ firstName + "', '" + lastName + "', '" + birthday + "', '" + gender + "', '" + country + "', '"
					+ email + "', '" + userName + "', '" + password + "');";
			PreparedStatement posted1 = con1.prepareStatement(query1);
			posted1.execute();
			con1.close();
			posted1.close();

			Connection con2 = connect();
			String query2 = "Insert Into Address(street, number, city, post_code) values ('" + street + "', '" + number
					+ "', '" + city + "', '" + post_code + "');";
			PreparedStatement posted2 = con2.prepareStatement(query2);
			posted2.execute();
			con2.close();
			posted2.close();

			Connection con3 = connect();
			String query3 = "Insert Into User_Address values ( (Select user_id From User Where username='" + userName
					+ "' AND password='" + password + "') , (Select address_id from Address Where street='" + street
					+ "' AND number='" + number + "' AND city='" + city + "' AND post_code='" + post_code + "' ));";
			PreparedStatement posted3 = con3.prepareStatement(query3);
			posted3.execute();
			con3.close();
			posted3.close();

			Connection con4 = connect();
			String query4 = "INSERT into User_Residence_Permit values ( (Select user_id From User Where username='"
					+ userName + "' AND password='" + password
					+ "'), (Select residence_permit_id From Residence_Permit where residence_permit_type='"
					+ residencePermit + "'));";
			PreparedStatement posted4 = con4.prepareStatement(query4);
			posted4.execute();
			con4.close();
			posted4.close();

			Connection con5 = connect();
			String query5 = "Insert Into User_Role values ( (Select user_id From User Where username='" + userName
					+ "' AND password='" + password + "') , (Select role_id from Role where role_type='" + roleType
					+ "' ) );";
			PreparedStatement posted5 = con5.prepareStatement(query5);
			posted5.execute();
			con5.close();
			posted5.close();

			if (!high_school.equals("Nicht Interessiert") || !university.equals("Nicht Interessiert")
					|| !integration_course.equals("Nicht Interessiert") || !dsh_course.equals("Nicht Interessiert")
					|| !german_level.equals("Nicht Interessiert")) {
				Connection con6 = connect();
				String query6 = "Insert Into Education (high_school, university, integration_course, dsh_course, german_level) values ('"
						+ high_school + "','" + university + "','" + integration_course + "','" + dsh_course + "','"
						+ german_level + "');";
				PreparedStatement posted6 = con6.prepareStatement(query6);
				posted6.execute();
				con6.close();
				posted6.close();

				Connection con7 = connect();
				String query7 = "Insert into User_Education values ((Select user_id From User Where username='"
						+ userName + "' AND password='" + password + "') , (SELECT MAX(education_id) FROM Education));";
				PreparedStatement posted7 = con7.prepareStatement(query7);
				posted7.execute();
				con7.close();
				posted7.close();
			}
			Connection con8 = connect();
			String query8 = "Insert Into User_Mother_Language values ((Select user_id From User where username='"
					+ userName + "' AND password='" + password
					+ "'),(Select language_id from Mother_Language where language='" + motherLanguage + "'));";
			PreparedStatement posted8 = con8.prepareStatement(query8);
			posted8.execute();
			con8.close();
			posted8.close();

			if (!roleType.equals("Customer")) {

				// Create Calendar
				String string_calendar_id = GoogleKalendar
						.creatCalender(firstName + ", " + lastName + " ( " + roleType + " )");

				String calendar_name = firstName + ", " + lastName + " ( " + roleType + " )";

				// Add string_calendar_id to DB and assign it into User_Calender
				Connection con9 = connect();
				String query9 = "Insert Into Calendar (string_calendar_id, calendar_name) values ( '"
						+ string_calendar_id + "', '" + calendar_name + "' );";
				PreparedStatement posted9 = con9.prepareStatement(query9);
				posted9.execute();
				con9.close();
				posted9.close();

				Connection con10 = connect();
				String query10 = "Insert into User_Calendar VALUES ( (Select user_id from User where username='"
						+ userName + "'), (SELECT calendar_id from Calendar where string_calendar_id='"
						+ string_calendar_id + "') );";
				PreparedStatement posted10 = con10.prepareStatement(query10);
				posted10.execute();
				con10.close();
				posted10.close();

				// Make Calender Public
				GoogleKalendar.makeCalendarPublic(string_calendar_id);

			} else if (roleType.equals("Customer")) {

				if (!high_school.equals("Nicht Interessiert") || !university.equals("Nicht Interessiert")
						|| !integration_course.equals("Nicht Interessiert") || !dsh_course.equals("Nicht Interessiert")
						|| !german_level.equals("Nicht Interessiert")) {
					Connection con6 = connect();
					String query6 = "Insert Into Education (high_school, university, integration_course, dsh_course, german_level) values ('"
							+ high_school + "','" + university + "','" + integration_course + "','" + dsh_course + "','"
							+ german_level + "');";
					PreparedStatement posted6 = con6.prepareStatement(query6);
					posted6.execute();
					con6.close();
					posted6.close();

					Connection con7 = connect();
					String query7 = "Insert into User_Education values ((Select user_id From User Where username='"
							+ userName + "' AND password='" + password
							+ "') , (SELECT MAX(education_id) FROM Education));";
					PreparedStatement posted7 = con7.prepareStatement(query7);
					posted7.execute();
					con7.close();
					posted7.close();
				}

				Connection con = connect();
				String query = "Insert into Kunde_Supervised_By_Worker ( kunde_id, worker_id ) values ( (Select user_id from User where username='"
						+ userName + "' AND email='" + email
						+ "'), (Select user_id from User Natural Join User_Role Natural Join Role where role_type='Worker' ORDER BY random() LIMIT 1) );";
				PreparedStatement posted = con.prepareStatement(query);
				posted.execute();
				con.close();
				posted.close();

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * Response about deleting user from the DB
	 * 
	 * @param user_id The ID of the Deleted User
	 * @throws SQLException
	 * @throws IOException
	 */
	public static void sqlDeleteUserByManager(String user_id) throws SQLException, IOException {

		String education_id = null;
		String address_id = null;
		String string_calendar_id = null;
		String role_type = null;

		// Get the address_id
		ResultSet r1_1 = null;

		String query1_1 = "Select address_id, role_type from User NATURAL JOIN Address NATURAL JOIN User_Address Natural Join Role Natural Join User_Role  where user_id='"
				+ user_id + "';";

		Statement s1_1 = AppWithDB.connect().createStatement();
		r1_1 = s1_1.executeQuery(query1_1);

		while (r1_1.next()) {

			address_id = r1_1.getString("address_id");
			role_type = r1_1.getString("role_type");
		}
		r1_1.close();
		s1_1.close();

		// Get the education_id
		ResultSet r1_2 = null;

		String query1_2 = "Select education_id  from User NATURAL JOIN Education NATURAL JOIN User_Education  where user_id='"
				+ user_id + "';";

		Statement s1_2 = AppWithDB.connect().createStatement();
		r1_2 = s1_2.executeQuery(query1_2);

		while (r1_2.next()) {

			education_id = r1_2.getString("education_id");
		}
		r1_2.close();
		s1_2.close();

		// Delete User From User_Mother_Language Table
		Connection c2 = connect();
		String query2 = "Delete from User_Mother_Language where user_id = '" + user_id + "';";
		PreparedStatement posted2 = c2.prepareStatement(query2);
		posted2.execute();
		posted2.close();

		// Delete User From User_Address Table
		Connection c3 = connect();
		String query3 = "Delete from User_Address where user_id='" + user_id + "';";
		PreparedStatement posted3 = c3.prepareStatement(query3);
		posted3.execute();
		posted3.close();

		// Delete User From Address Table
		Connection c5 = connect();
		String query5 = "Delete from Address where address_id='" + address_id + "';";
		PreparedStatement posted5 = c5.prepareStatement(query5);
		posted5.execute();
		posted5.close();

		// Delete User From User_Residence_Permit Table
		Connection c6 = connect();
		String query6 = "Delete from User_Residence_Permit where user_id = '" + user_id + "';";
		PreparedStatement posted6 = c6.prepareStatement(query6);
		posted6.execute();
		posted6.close();

		// Delete User From User_Role Table
		Connection c7 = connect();
		String query7 = "Delete from User_Role where user_id = '" + user_id + "';";
		PreparedStatement posted7 = c7.prepareStatement(query7);
		posted7.execute();
		posted7.close();

		// Delete User From User_Education Table
		Connection c8 = connect();
		String query8 = "Delete from User_Education where user_id='" + user_id + "';";
		PreparedStatement posted8 = c8.prepareStatement(query8);
		posted8.execute();
		posted8.close();

		// Delete User From Education Table
		Connection c9 = connect();
		String query9 = "Delete from Education where education_id='" + education_id + "';";
		PreparedStatement posted9 = c9.prepareStatement(query9);
		posted9.execute();
		posted9.close();

		if (!role_type.equals("Customer")) { // has Calendar

			// Get the string_calendar_id
			ResultSet r1_3 = null;

			String query1_3 = "Select string_calendar_id from User NATURAL JOIN Calendar  NATURAL JOIN User_Calendar  where user_id= '"
					+ user_id + "';";

			Statement s1_3 = AppWithDB.connect().createStatement();
			r1_3 = s1_3.executeQuery(query1_3);

			while (r1_3.next()) {

				string_calendar_id = r1_3.getString("string_calendar_id");
			}
			r1_3.close();
			s1_3.close();

			// Delete User From User_Calendar Table
			Connection c11 = connect();
			String query11 = "Delete from User_Calendar where user_id='" + user_id + "';";
			PreparedStatement posted11 = c11.prepareStatement(query11);
			posted11.execute();
			posted11.close();

			// Delete User From Calendar Table
			Connection c12 = connect();
			String query12 = "Delete from Calendar where string_calendar_id='" + string_calendar_id + "';";
			PreparedStatement posted12 = c12.prepareStatement(query12);
			posted12.execute();
			posted12.close();

			// Delete the Calendar
			GoogleKalendar.deleteCalender(string_calendar_id + "@group.calendar.google.com");

		} else if (role_type.equals("Customer")) {

			// Delete User From Kunde_Supervised_By_Worker Table
			Connection c13 = connect();
			String query13 = "Delete from Kunde_Supervised_By_Worker where kunde_id = '" + user_id + "';";
			PreparedStatement posted13 = c13.prepareStatement(query13);
			posted13.execute();
			posted13.close();

		}

		// Delete User From User Table
		Connection c10 = connect();
		String query10 = "Delete from User where user_id='" + user_id + "';";
		PreparedStatement posted10 = c10.prepareStatement(query10);
		posted10.execute();
		posted10.close();

//		System.err.println("User has been deleted");
	}

	public static byte[] readFile(String file) {
		ByteArrayOutputStream bos = null;
		try {
			File f = new File(file);
			FileInputStream fis = new FileInputStream(f);
			byte[] buffer = new byte[1024];
			bos = new ByteArrayOutputStream();
			for (int len; (len = fis.read(buffer)) != -1;) {
				bos.write(buffer, 0, len);
			}
		} catch (FileNotFoundException e) {
//			System.err.println(e.getMessage());
		} catch (IOException e2) {
//			System.err.println(e2.getMessage());
		}
		return bos != null ? bos.toByteArray() : null;
	}

	/**
	 * Resposne about save the uploaded File to the DB
	 * 
	 * @param document_name        the name od the document
	 * @param document_upload_date the uploaded date
	 * @param document_language    the language of the document
	 * @param type                 the type of the document (Public, Private, For
	 *                             User)
	 * @param data                 Blob of the Document
	 * @param document_for_user    the id of the user if the document was belong to
	 *                             him
	 * @param prefix               the prefix of the uploaded document
	 * @param path                 the path where the document has been saved
	 * @throws SQLException
	 */
	public static void sqlUploadDocumentByManager(String document_name, String document_upload_date,
			String document_language, String type, String data, String document_for_user, String prefix, String path)
			throws SQLException {

		if (type.equals("Public")) {

			String updateSQL = "Insert into Document ( document_name, document_upload_date, document_language, document_data, prefix, path ) values ( ?,?,?,?,?,?)";

			try (Connection conn = connect(); PreparedStatement pstmt = conn.prepareStatement(updateSQL)) {

				// set parameters
				pstmt.setString(1, document_name);
				pstmt.setString(2, document_upload_date);
				pstmt.setString(3, document_language);
				pstmt.setBytes(4, readFile(data));
				pstmt.setString(5, prefix);
				pstmt.setString(6, path);

				pstmt.executeUpdate();
//				System.out.println("Stored the file in the BLOB column.");
				pstmt.close();
				conn.close();

			} catch (SQLException e) {
//				System.out.println(e.getMessage());
			}

			Connection con2 = connect();
			String query2 = "Insert Into Document_Type values ( (Select document_id from Document where document_name = '"
					+ document_name + "' AND document_language = '" + document_language
					+ "' ), ( Select type_id From Type where document_type = '" + type + "') );";
			PreparedStatement posted2 = con2.prepareStatement(query2);
			posted2.execute();
			con2.close();
			posted2.close();

			Connection con3 = connect();
			String query3 = "Insert Into User_Document (document_id, user_id, document_for_user) values ( (Select MAX(document_id) From Document ), '"
					+ LoginController.getLoggedInUserId() + "', '');";

//			String query3 = "Insert Into Document_Type values ( (Select document_id from Document where document_name = '"
//					+ document_name + "' AND document_language = '" + document_language
//					+ "' ), ( Select type_id From Type where document_type = '" + type + "') );";
			PreparedStatement posted3 = con3.prepareStatement(query3);
			posted3.execute();
			con3.close();
			posted3.close();

		} else if (type.equals("For User")) {

			String updateSQL = "Insert into Document ( document_name, document_upload_date, document_language, document_data, prefix, path ) values ( ?,?,?,?,?,?)";

			try (Connection conn = connect(); PreparedStatement pstmt = conn.prepareStatement(updateSQL)) {

				// set parameters
				pstmt.setString(1, document_name);
				pstmt.setString(2, document_upload_date);
				pstmt.setString(3, document_language);
				pstmt.setBytes(4, readFile(data));
				pstmt.setString(5, prefix);
				pstmt.setString(6, path);

				pstmt.executeUpdate();
//				System.out.println("Stored the file in the BLOB column.");
				pstmt.close();
				conn.close();

			} catch (SQLException e) {
//				System.out.println(e.getMessage());
			}

			Connection con2 = connect();
			String query2 = "Insert Into Document_Type values ( (Select document_id from Document where document_name = '"
					+ document_name + "' AND document_language = '" + document_language
					+ "' ), ( Select type_id From Type where document_type = '" + type + "') );";
			PreparedStatement posted2 = con2.prepareStatement(query2);
			posted2.execute();
			con2.close();
			posted2.close();

			Connection con3 = connect();
			String query3 = "Insert Into User_Document (document_id, user_id, document_for_user) values ( (Select MAX(document_id) From Document ), '"
					+ LoginController.getLoggedInUserId() + "', '" + document_for_user + "' );";

//			String query3 = "Insert Into Document_Type values ( (Select document_id from Document where document_name = '"
//					+ document_name + "' AND document_language = '" + document_language
//					+ "' ), ( Select type_id From Type where document_type = '" + type + "') );";
			PreparedStatement posted3 = con3.prepareStatement(query3);
			posted3.execute();
			con3.close();
			posted3.close();

		} else if (type.equals("Private")) {

			String updateSQL = "Insert into Document ( document_name, document_upload_date, document_language, document_data, prefix, path ) values ( ?,?,?,?,?,?)";

			try (Connection conn = connect(); PreparedStatement pstmt = conn.prepareStatement(updateSQL)) {

				// set parameters
				pstmt.setString(1, document_name);
				pstmt.setString(2, document_upload_date);
				pstmt.setString(3, document_language);
				pstmt.setBytes(4, readFile(data));
				pstmt.setString(5, prefix);
				pstmt.setString(6, path);

				pstmt.executeUpdate();
//				System.out.println("Stored the file in the BLOB column.");
				pstmt.close();
				conn.close();

			} catch (SQLException e) {
//				System.out.println(e.getMessage());
			}

			Connection con2 = connect();
			String query2 = "Insert Into Document_Type values ( (Select document_id from Document where document_name = '"
					+ document_name + "' AND document_language = '" + document_language
					+ "' ), ( Select type_id From Type where document_type = '" + type + "') );";
			PreparedStatement posted2 = con2.prepareStatement(query2);
			posted2.execute();
			con2.close();
			posted2.close();

			Connection con3 = connect();
			String query3 = "Insert Into User_Document (document_id, user_id, document_for_user) values ( (Select MAX(document_id) From Document ), '"
					+ LoginController.getLoggedInUserId() + "', '" + LoginController.getLoggedInUserId() + "' );";

//			String query3 = "Insert Into Document_Type values ( (Select document_id from Document where document_name = '"
//					+ document_name + "' AND document_language = '" + document_language
//					+ "' ), ( Select type_id From Type where document_type = '" + type + "') );";
			PreparedStatement posted3 = con3.prepareStatement(query3);
			posted3.execute();
			con3.close();
			posted3.close();

		}

	}

	/**
	 * Response of delete the uploaded document from the DB
	 * 
	 * @param document_id the id of the deleted document
	 * @throws SQLException
	 */
	public static void sqlDeleteDocumentByManager(String document_id) throws SQLException {

		// Delete From Document_Type
		Connection c1 = connect();
		String query1 = "Delete from Document_Type where document_id = '" + document_id + "';";
		PreparedStatement posted1 = c1.prepareStatement(query1);
		posted1.execute();
		posted1.close();

		// Delete From User_Document
		Connection c2 = connect();
		String query2 = "Delete from User_Document where document_id = '" + document_id + "';";
		PreparedStatement posted2 = c2.prepareStatement(query2);
		posted2.execute();
		posted2.close();

		// Delete From Document Table
		Connection c3 = connect();
		String query3 = "Delete from Document where document_id = '" + document_id + "';";
		PreparedStatement posted3 = c3.prepareStatement(query3);
		posted3.execute();
		posted3.close();

//		System.out.println("Document has been deleted ");

	}

	public static String sqlCreateEventByManager(String created_by_user_id, String for_user_id, String event_type,
			String title, String date, String startTime, String endTime, String location) throws SQLException {

		String query1 = null;
		String query2 = null;

		String string_calendar_id = null;

//		System.err.println(event_type);

		if (event_type.equals("All")) {
			query1 = "Insert into Event (event_name, from_date, from_time, to_date, to_time, location, event_type, calendar_id )  values ( '"
					+ title + "', '" + date + "', '" + startTime + "', '" + date + "', '" + endTime + "', '" + location
					+ "', '" + event_type + "', '1');"; // 1 is the ID of the Public Calendar

			query2 = "Insert into User_Event (created_by_user_id, event_id) values ('" + created_by_user_id
					+ "', (Select MAX(event_id) From Event));";

			string_calendar_id = "primary";

		} else {
			query1 = "Insert into Event (event_name, from_date, from_time, to_date, to_time, location, event_type, calendar_id )  values ( '"
					+ title + "', '" + date + "', '" + startTime + "', '" + date + "', '" + endTime + "', '" + location
					+ "', '" + event_type
					+ "', (Select calendar_id from Calendar Natural Join User_Calendar Where user_id='"
					+ created_by_user_id + "'));";

			query2 = "Insert into User_Event ( created_by_user_id, event_id, for_user_id ) values ('"
					+ created_by_user_id + "', (Select MAX(event_id) From Event), '" + for_user_id + "');";

			ResultSet r = null;

			String query3 = "Select string_calendar_id From Calendar Natural Join User_Calendar Natural Join User where user_id = '"
					+ LoginController.getLoggedInUserId() + "';";

			Statement s = AppWithDB.connect().createStatement();
			r = s.executeQuery(query3);

			while (r.next()) {
				string_calendar_id = r.getString("string_calendar_id");
			}
			r.close();
			s.close();
			string_calendar_id = string_calendar_id + "@group.calendar.google.com";
		}
		Connection con1 = connect();
		PreparedStatement posted1 = con1.prepareStatement(query1);
		posted1.execute();
		con1.close();
		posted1.close();

		Connection con2 = connect();
		PreparedStatement posted2 = con2.prepareStatement(query2);
		posted2.execute();
		con2.close();
		posted2.close();

		return string_calendar_id;

	}

	/**
	 * Response of Delete Event
	 * 
	 * @param event_id the ID of the deleted Event
	 * @throws SQLException
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	public static void sqlDeleteEventByManager(String event_id)
			throws SQLException, IOException, GeneralSecurityException {
		boolean for_user_isNull = true;

		// Delete the Event from the 2nd Person's calendar
		ResultSet r = null;
		String query = "Select role_type from User NATURAL Join User_Role Natural Join Role where user_id= ( Select for_user_id from User_Event Where event_id='"
				+ event_id + "' );";
		Statement s = AppWithDB.connect().createStatement();
		r = s.executeQuery(query);
		String role_type = null;

		while (r.next()) {
			role_type = r.getString("role_type");
			for_user_isNull = r.wasNull();

		}
//		System.out.println("Role Type " + role_type + ", Is Null ? " + for_user_isNull);
		r.close();
		s.close();

		if (for_user_isNull == true) { // The Event here is public and for all ( Must be deleted just one time in the
										// main calendar )

			// Delete the event from the creator's calendar
			String string_event_id = null;
			String string_calendar_id = null;

			ResultSet r1 = null;
			String query1 = "Select string_event_id, string_calendar_id From Event Natural Join Calendar where event_id='"
					+ event_id + "';";
			Statement s1 = AppWithDB.connect().createStatement();
			r1 = s1.executeQuery(query1);
			while (r1.next()) {
				string_event_id = r1.getString("string_event_id");
				string_calendar_id = r1.getString("string_calendar_id");
			}
			r1.close();
			s1.close();

			// Delete Event From User_Event Table
			Connection c2 = connect();
			String query2 = "Delete from User_Event where event_id = '" + event_id + "';";
			PreparedStatement posted2 = c2.prepareStatement(query2);
			posted2.execute();
			posted2.close();

			// Delete Event From Event Table
			Connection c3 = connect();
			String query3 = "Delete from Event where event_id = '" + event_id + "';";
			PreparedStatement posted3 = c3.prepareStatement(query3);
			posted3.execute();
			posted3.close();

			GoogleKalendar.deleteEvent(string_event_id, string_calendar_id);

		} else if (for_user_isNull == false) { // The Event here is private ( Must be deleted 2 times )
			// Delete the event from the creator's calendar
			String string_event_id = null;
			String string_calendar_id = null;

			ResultSet r1 = null;
			String query1 = "Select string_event_id, string_calendar_id From Event Natural Join Calendar where event_id='"
					+ event_id + "';";
			Statement s1 = AppWithDB.connect().createStatement();
			r1 = s1.executeQuery(query1);
			while (r1.next()) {
				string_event_id = r1.getString("string_event_id");
				string_calendar_id = r1.getString("string_calendar_id");
			}
			r1.close();
			s1.close();

			if (!role_type.equals("Customer")) {

				ResultSet r5 = null;
				String query5 = "Select event_name, from_date, from_time, to_date, to_time, location from Event where event_id = '"
						+ event_id + "';";
				Statement s5 = AppWithDB.connect().createStatement();
				r5 = s5.executeQuery(query5);
				String event_name = null;
				String from_date = null;
				String to_date = null;
				String from_time = null;
				String to_time = null;
				String location = null;
				while (r5.next()) {
					event_name = r5.getString("event_name");
					from_date = r5.getString("from_date");
					to_date = r5.getString("to_date");
					from_time = r5.getString("from_time");
					to_time = r5.getString("to_time");
					location = r5.getString("location");
				}

				r5.close();
				s5.close();

				// Delete the Event from the 2nd Person's calendar
				ResultSet r4 = null;
				String query4 = "Select DISTINCT string_calendar_id FROM User  Natural Join Calendar Natural Join User_Calendar Natural Join User_Event where user_id = ( Select for_user_id from User_Event where event_id = '"
						+ event_id + "' );";
				Statement s4 = AppWithDB.connect().createStatement();
				r4 = s4.executeQuery(query4);
				String partnet_string_calendar_id = null;
				while (r4.next()) {
					partnet_string_calendar_id = r4.getString("string_calendar_id");
				}
				r4.close();
				s4.close();

				// Delete Event From User_Event Table
				Connection c2 = connect();
				String query2 = "Delete from User_Event where event_id = '" + event_id + "';";
				PreparedStatement posted2 = c2.prepareStatement(query2);
				posted2.execute();
				posted2.close();

				// Delete Event From Event Table
				Connection c3 = connect();
				String query3 = "Delete from Event where event_id = '" + event_id + "';";
				PreparedStatement posted3 = c3.prepareStatement(query3);
				posted3.execute();
				posted3.close();

				// Delete the Event from the creator's calendar
				GoogleKalendar.deleteEvent(string_event_id, string_calendar_id + "@group.calendar.google.com");

				GoogleKalendar.deleteEvent(
						GoogleKalendar.getEventID(partnet_string_calendar_id + "@group.calendar.google.com", event_name,
								location, from_time, to_time, from_date, to_date),
						partnet_string_calendar_id + "@group.calendar.google.com");
			} else if (role_type.equals("Customer")) {

				// Delete Event From User_Event Table
				Connection c2 = connect();
				String query2 = "Delete from User_Event where event_id = '" + event_id + "';";
				PreparedStatement posted2 = c2.prepareStatement(query2);
				posted2.execute();
				posted2.close();

				// Delete Event From Event Table
				Connection c3 = connect();
				String query3 = "Delete from Event where event_id = '" + event_id + "';";
				PreparedStatement posted3 = c3.prepareStatement(query3);
				posted3.execute();
				posted3.close();

				// Delete the Event from the creator's calendar
				GoogleKalendar.deleteEvent(string_event_id, string_calendar_id + "@group.calendar.google.com");

			}

		}

	}

	/**
	 * Response about edit created Event
	 * 
	 * @param event_id           te id of the event which is going to be edited
	 * @param created_by_user_id by who has the event been created
	 * @param event_type         the type of the event (Public, private, For User)
	 * @param title              the name of the new Event
	 * @param date               the new date of the event
	 * @param startTime          the start time of the event
	 * @param endTime            the end time of the event
	 * @param location           the location of the new event
	 * @return the calendarID which the vent belongs to
	 * @throws SQLException
	 */
	public static String sqlEditEventByManager(String event_id, String created_by_user_id, String event_type,
			String title, String date, String startTime, String endTime, String location) throws SQLException {

		String query1 = null;

		String string_calendar_id = null;

//		System.err.println(event_type);

		if (event_type.equals("All")) {
			query1 = "Update Event SET event_name ='" + title + "', from_date = '" + date + "', from_time = '"
					+ startTime + "', to_date = '" + date + "', to_time = '" + endTime + "', location = '" + location
					+ "', event_type = '" + event_type + "', calendar_id = '1' WHERE event_id = '" + event_id + "';";
			// 1 is the ID of the Public Calendar

			string_calendar_id = "primary";

		} else {
			query1 = "Update Event SET event_name ='" + title + "', from_date = '" + date + "', from_time = '"
					+ startTime + "', to_date = '" + date + "', to_time = '" + endTime + "', location = '" + location
					+ "', event_type = '" + event_type + "' WHERE event_id='" + event_id + "';";

			ResultSet r = null;

//			String query3 = "Select string_calendar_id From Calendar Natural Join User_Calendar Natural Join User where user_id = '"
//					+ LoginController.getLoggedInUserId() + "';";

			String query3 = "Select string_calendar_id From Calendar Natural Join User_Calendar Natural Join User Natural Join Event where event_id='"
					+ event_id + "';";

			Statement s = AppWithDB.connect().createStatement();
			r = s.executeQuery(query3);

			while (r.next()) {
				string_calendar_id = r.getString("string_calendar_id");
			}
			r.close();
			s.close();
			string_calendar_id = string_calendar_id + "@group.calendar.google.com";
		}
		Connection con1 = connect();
		PreparedStatement posted1 = con1.prepareStatement(query1);
		posted1.execute();
		con1.close();
		posted1.close();

		return string_calendar_id;

	}

	/**
	 * Response about Booking an appointment from the Customer
	 * 
	 * @param created_by_user_id The ID of the user who create the event
	 * @param for_user_id        the ID of the User
	 * @param event_type         Public, Private, For User
	 * @param title              The name of the new User
	 * @param date               the Date of the new Event
	 * @param startTime          The start time of the event
	 * @param endTime            the end time of the event
	 * @param location           the location of the vent
	 * @return the calendar_id which the event belongs to
	 * @throws SQLException
	 */
	public static String sqlUserAppointmentBooking(String created_by_user_id, String for_user_id, String event_type,
			String title, String date, String startTime, String endTime, String location) throws SQLException {

		String query1 = null;
		String query2 = null;

		String string_calendar_id = null;

//		System.err.println(event_type);

		query1 = "Insert into Event (event_name, from_date, from_time, to_date, to_time, location, event_type, calendar_id )  values ( '"
				+ title + "', '" + date + "', '" + startTime + "', '" + date + "', '" + endTime + "', '" + location
				+ "', '" + event_type
				+ "', (Select calendar_id from Calendar Natural Join User_Calendar Where user_id='" + created_by_user_id
				+ "'));";

		query2 = "Insert into User_Event ( created_by_user_id, event_id, for_user_id ) values ('" + created_by_user_id
				+ "', (Select MAX(event_id) From Event), '" + for_user_id + "');";

		ResultSet r = null;

		String query3 = "Select string_calendar_id From Calendar Natural Join User_Calendar Natural Join User where user_id = ( Select worker_id from Kunde_Supervised_By_Worker where kunde_id='"
				+ for_user_id + "' );";

		Statement s = AppWithDB.connect().createStatement();
		r = s.executeQuery(query3);

		while (r.next()) {
			string_calendar_id = r.getString("string_calendar_id");
		}
		r.close();
		s.close();
		string_calendar_id = string_calendar_id + "@group.calendar.google.com";

		Connection con1 = connect();
		PreparedStatement posted1 = con1.prepareStatement(query1);
		posted1.execute();
		con1.close();
		posted1.close();

		Connection con2 = connect();
		PreparedStatement posted2 = con2.prepareStatement(query2);
		posted2.execute();
		con2.close();
		posted2.close();

		return string_calendar_id;

	}

}
