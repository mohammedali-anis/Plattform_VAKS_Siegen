package VAKS.run.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import VAKS.run.GoogleCalendar.GoogleKalendar;
import VAKS.run.Model.AppWithDB;

/**
 * Manager Controller
 * 
 * @author Mohammed Ali Anis
 * @version 1.0
 * @since 1.0
 *
 */
@Controller
public class ManagerController {

	public static String find = "basic";
	public static String searchBy;
	public static String defaultDate;
	public static String documentSearch = "empty";

	/**
	 * For Mapping
	 * 
	 * @return the the Manager view
	 */
	@GetMapping("/Manager")
	public String map() {

		return "Manager";
	}

	/**
	 * To Delete the User
	 * 
	 * @param user_id_hidden get the user_id which must be deleted
	 * @param actionBtnValue Check if the OK button clicked by the alert dialog
	 * @return to Manager Page - Manage User Section
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "deleteUser")
	public String showTable(@RequestParam(required = false) String user_id_hidden, String actionBtnValue)
			throws SQLException, IOException {

		System.out.println(user_id_hidden + " " + actionBtnValue);

		if (actionBtnValue.equals("Delete") && !user_id_hidden.equals("cancel")) {

			AppWithDB.sqlDeleteUserByManager(user_id_hidden);
			return "redirect:/Manager#User";

		} else if (actionBtnValue.equals("Edit") && !user_id_hidden.equals("cancel")) {

			// TODO here Editing
		}

		return "redirect:/Manager#User";

	}

	/**
	 * Respone about adding new User with all roles
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
	 * @return Manager Page, Manage User Section
	 * @throws SQLException
	 */
	@RequestMapping(value = "AddUser")
	public String addUser(@RequestParam(required = true) String firstName, String lastName, String birthday,
			String gender, String email, String userName, String password, String country, String motherLanguage,
			String residencePermit, String street, String number, String city, String post_code, String high_school,
			String university, String integration_course, String dsh_course, String german_level, String roleType)
			throws SQLException {

		AppWithDB.sqlAddUserByManager(firstName, lastName, birthday, gender, email, userName, password, country,
				motherLanguage, residencePermit, street, number, city, post_code, high_school, university,
				integration_course, dsh_course, german_level, roleType);

		VAKS.run.GoogleMail.Email.giveSupervisorInfoEmail(userName, email);

		return "redirect:/Manager#User";

	}

	/**
	 * response to upload the file onto server side
	 * 
	 * @param name              the name of the uploaded file
	 * @param language          language the name of the uploaded file
	 * @param Type              Type of the Document (Public OR Private)
	 * @param document_for_user the id of the user which the document belongs to
	 * @param browse            the uploaded file object
	 * @return to Manager page, Manage Document section
	 * @throws SQLException
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(value = "uploadDocument", method = RequestMethod.POST)
	public String uploadFile(@RequestParam(required = false) String name, String language, String Type,
			String document_for_user, MultipartFile browse) throws SQLException, IllegalStateException, IOException {

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		Date date = new Date();
		String now = dateFormat.format(date);
		String prefix = browse.getContentType().split("/")[1];

		if (Type.equals("Public")) {

			String baseDir = "src/main/resources/static/uploads/Public/";
			File file = new File(baseDir);
			String absolutePath = file.getAbsolutePath() + "/";

			String uploadedFile = absolutePath + name + " <> " + now + "." + prefix;
			String finalPath = uploadedFile;
			AppWithDB.sqlUploadDocumentByManager(name + " <> " + now, now, language, Type, uploadedFile,
					document_for_user, prefix, finalPath);
			browse.transferTo(new File(uploadedFile));
		} else if (Type.equals("For User")) {

			String baseDir = "src/main/resources/static/uploads/For User/" + document_for_user + "/";

			File file = new File(baseDir);
			String absolutePath = file.getAbsolutePath() + "/";

			File pathAsFile = new File(absolutePath);

			if (!Files.exists(Paths.get(absolutePath))) {
				pathAsFile.mkdir();
			}
			String uploadedFile = absolutePath + name + " <> " + now + "." + prefix;
			String finalPath = uploadedFile;
			AppWithDB.sqlUploadDocumentByManager(name + " <> " + now, now, language, Type, uploadedFile,
					document_for_user, prefix, finalPath);
			browse.transferTo(new File(uploadedFile));

		} else if (Type.equals("Private")) {

			String baseDir = "src/main/resources/static/uploads/Private/" + LoginController.getLoggedInUserId() + "/";

			File file = new File(baseDir);
			String absolutePath = file.getAbsolutePath() + "/";

			File pathAsFile = new File(absolutePath);

			if (!Files.exists(Paths.get(absolutePath))) {
				pathAsFile.mkdir();
			}
			String uploadedFile = absolutePath + name + " <> " + now + "." + prefix;
			String finalPath = uploadedFile;
			AppWithDB.sqlUploadDocumentByManager(name + " <> " + now, now, language, Type, uploadedFile,
					document_for_user, prefix, finalPath);
			browse.transferTo(new File(uploadedFile));
		}

		return "redirect:/Manager#Documents";

	}

	/**
	 * Response to download the already uploaded document
	 * 
	 * @param document_id the if of the document which must be downloaded
	 * @return ResponseEntity
	 * @throws IOException
	 * @throws SQLException
	 */
	@RequestMapping(path = "/downloadDocument/{document_id}", method = RequestMethod.GET)
	public ResponseEntity<Object> downloadFile2(@PathVariable("document_id") String document_id)
			throws IOException, SQLException {

		ResultSet r = null;

		String query = "Select path from Document where document_id='" + document_id + "';";
		String path = null;
		Statement s = AppWithDB.connect().createStatement();
		r = s.executeQuery(query);

		while (r.next()) {

			path = r.getString("path");
		}
		r.close();
		s.close();

		File file = new File(path);
		InputStreamResource resource = new InputStreamResource(new FileInputStream(file));

		org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();

		headers.add("Content-Disposition", String.format("attachemt; filename=\"%s\"", file.getName()));
		headers.add("Cach-Control", "no-cache, no-store, must-revalidate");
		headers.add("Pragma", "no-cache");
		headers.add("Expires", "0");

		ResponseEntity<Object> responseEntity = ResponseEntity.ok().headers(headers).contentLength(file.length())
				.contentType(MediaType.parseMediaType("application/txt")).body(resource);

		return responseEntity;

	}

	/**
	 * Response about deleting the already downloaded document
	 * 
	 * @param document_id_hidden get the document_id which must be deleted
	 * @param actionBtnValue     Check if the OK button clicked by the alert dialog
	 * @return to Manager Page, Manage Document Section
	 * @throws SQLException
	 */
	@RequestMapping(value = "deleteDocument")
	public String deleteDocument(@RequestParam(required = true) String document_id_hidden, String actionBtnValue)
			throws SQLException {

		ResultSet r = null;

		String query = " Select path from Document where document_id = '" + document_id_hidden + "';";

		String path = null;

		Statement s = AppWithDB.connect().createStatement();
		r = s.executeQuery(query);

		while (r.next()) {

			path = r.getString("path");

		}
		r.close();
		s.close();

		if (actionBtnValue.equals("Delete") && !document_id_hidden.equals("cancel")) {
			AppWithDB.sqlDeleteDocumentByManager(document_id_hidden);
			File file = new File(path);
			file.delete();
			return "redirect:/Manager#Documents";
		} else {
			return "redirect:/Manager#Documents";
		}

	}

	/**
	 * Response about filter the Event according to Date or to User
	 * 
	 * @param search check if the filter working by Date or by User
	 * @return to Manager Page, Manage Event Section
	 * @throws SQLException
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	@RequestMapping(value = "showEvents")
	public String showEvents(@RequestParam(required = true) String search)
			throws SQLException, IOException, GeneralSecurityException {

		if (search.contains("-")) {
			find = "byDate";

			// In a way ID come from the server side like date = 2021-06-26, ( IDK from
			// where coming the , ) so by StringBuilder I remove the (,)
			StringBuilder sb = new StringBuilder(search);
			String result = sb.deleteCharAt(search.length() - 1).toString();
			searchBy = result;
			defaultDate = result;

		} else {
			find = "byUser";

			// In a way ID come from the server side like id = ,15 ( IDK from where coming
			// the , ) so by StringBuilder I remove the (,)
			StringBuilder sb = new StringBuilder(search);
			String result = sb.deleteCharAt(0).toString();
			searchBy = result;

		}

		return "redirect:/Manager#ManageEvents";

	}

	/**
	 * Response about creating Event
	 * 
	 * @param privacy   The Privacy of the event (Public or for special User)
	 * @param forUser   the ID of the User if the event was Privacy
	 * @param title     the name of the event
	 * @param date      the date of the event
	 * @param startTime the start time of the event
	 * @param endTime   the end time of the event
	 * @param location  the location of the vent
	 * @return to Manager Page, Calendar Section
	 * @throws SQLException
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	@RequestMapping(value = "createEvent")
	public String createEvent(@RequestParam(required = true) String privacy, String forUser, String title, String date,
			String startTime, String endTime, String location)
			throws SQLException, IOException, GeneralSecurityException {

		if (privacy.equals("All")) {

			// Add the event in DB and return the calendarID which the event most be added
			// on
			String calendarID = AppWithDB.sqlCreateEventByManager(LoginController.getLoggedInUserId(), forUser, privacy,
					title, date, startTime, endTime, location);

			String string_event_id = GoogleKalendar.creatEvent(calendarID, title, location, date, date, startTime,
					endTime);

			// Getting the EventID from Google API and add it to string_event_id in the DB
			Connection con1 = AppWithDB.connect();
			String query1 = "UPDATE Event SET string_event_id = '" + string_event_id
					+ "' Where event_id = (Select MAX(event_id) From Event);";
			PreparedStatement posted1 = con1.prepareStatement(query1);
			posted1.execute();
			con1.close();
			posted1.close();

		} else if (privacy.equals("Special")) {

			ResultSet r = null;
			String role_type = null;

			String query = "Select role_type from User Natural Join Role Natural Join User_Role where user_id='"
					+ forUser + "';";

			Statement s = AppWithDB.connect().createStatement();
			r = s.executeQuery(query);

			while (r.next()) {
				role_type = r.getString("role_type");
			}
			r.close();
			s.close();

			if (!forUser.equals(LoginController.getLoggedInUserId()) && !role_type.equals("Customer")) {

				// Add the event in DB and return the calendarID which the event most be added
				// on
				String calendarID = AppWithDB.sqlCreateEventByManager(LoginController.getLoggedInUserId(), forUser,
						privacy, title, date, startTime, endTime, location);

				String string_event_id = GoogleKalendar.creatEvent(calendarID, title, location, date, date, startTime,
						endTime);

				// Getting the EventID from Google API and add it to string_event_id in the DB
				Connection con1 = AppWithDB.connect();
				String query1 = "UPDATE Event SET string_event_id = '" + string_event_id
						+ "' Where event_id = (Select MAX(event_id) From Event);";
				PreparedStatement posted1 = con1.prepareStatement(query1);
				posted1.execute();
				con1.close();
				posted1.close();

				ResultSet r2 = null;

				String partner_string_calendar_id = null;

				String query2 = "Select DISTINCT string_calendar_id from User Natural Join Calendar Natural Join User_Calendar Natural Join User_Event where User_Calendar.user_id = '"
						+ forUser + "' AND User_Event.for_user_id = '" + forUser + "';";

				Statement s2 = AppWithDB.connect().createStatement();
				r2 = s2.executeQuery(query2);

				while (r2.next()) {

					partner_string_calendar_id = r2.getString("string_calendar_id");
				}
				r2.close();
				s2.close();

				GoogleKalendar.creatEvent(partner_string_calendar_id + "@group.calendar.google.com", title, location,
						date, date, startTime, endTime);

			} else if (!forUser.equals(LoginController.getLoggedInUserId()) && role_type.equals("Customer")) {

				// Add the event in DB and return the calendarID which the event most be added
				// on
				String calendarID = AppWithDB.sqlCreateEventByManager(LoginController.getLoggedInUserId(), forUser,
						privacy, title, date, startTime, endTime, location);

				String string_event_id = GoogleKalendar.creatEvent(calendarID, title, location, date, date, startTime,
						endTime);

				// Getting the EventID from Google API and add it to string_event_id in the DB
				Connection con1 = AppWithDB.connect();
				String query1 = "UPDATE Event SET string_event_id = '" + string_event_id
						+ "' Where event_id = (Select MAX(event_id) From Event);";
				PreparedStatement posted1 = con1.prepareStatement(query1);
				posted1.execute();
				con1.close();
				posted1.close();

			}

		}

		return "redirect:/Manager#Calendar";

	}

	/**
	 * Response about deleting the event
	 * 
	 * @param event_id_hidden the event which must be deleted
	 * @return Manager Page, Manage Events Section
	 * @throws SQLException
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	@RequestMapping(value = "deleteEvent")
	public String deleteEvent(@RequestParam(required = true) String event_id_hidden)
			throws SQLException, IOException, GeneralSecurityException {

		if (!event_id_hidden.equals("cancel")) {

			AppWithDB.sqlDeleteEventByManager(event_id_hidden);
			System.out.println(event_id_hidden);

		}

		return "redirect:/Manager#ManageEvents";

	}

	/**
	 * Response about edit the already created event
	 * 
	 * @param event_id  the event_id which must be edited
	 * @param privacy   if the event has to be Public or private
	 * @param for_user  if private for which user
	 * @param title     the name of the new event
	 * @param date      the date of the new Event
	 * @param startTime the start Time of the new Event
	 * @param endTime   The end tome of the new Event
	 * @param location  The location of the new Event
	 * @return to Manager Page, Manage Event Section
	 * @throws SQLException
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	@RequestMapping(value = "editEvent")
	public String editEvent(@RequestParam(required = true) String event_id, String privacy, String for_user,
			String title, String date, String startTime, String endTime, String location)
			throws SQLException, IOException, GeneralSecurityException {

		System.out.println("For User Edit" + for_user);

		if (privacy.equals("All")) {

			String string_event_id = null;
			ResultSet r1 = null;
			String query1 = "Select string_event_id From Event where event_id='" + event_id + "';";
			Statement s1 = AppWithDB.connect().createStatement();
			r1 = s1.executeQuery(query1);
			while (r1.next()) {
				string_event_id = r1.getString("string_event_id");

			}
			r1.close();
			s1.close();

			// Add the event in DB and return the calendarID which the event most be added
			// on
			String calendarID = AppWithDB.sqlEditEventByManager(event_id, LoginController.getLoggedInUserId(), privacy,
					title, date, startTime, endTime, location);

			GoogleKalendar.editEvent(string_event_id, calendarID, title, location, date, date, startTime, endTime);

		} else if (privacy.equals("Special")) {

			ResultSet r = null;
			String role_type = null;

			String query = "Select role_type from User Natural Join Role Natural Join User_Role where user_id='"
					+ for_user + "';";

			Statement s = AppWithDB.connect().createStatement();
			r = s.executeQuery(query);

			while (r.next()) {
				role_type = r.getString("role_type");
				System.out.println("Edit role_type = " + role_type);
			}
			r.close();
			s.close();

//			System.err.println("For User : " + for_user);
//			System.err.println("Role_Type : " + role_type);

			if (!for_user.equals(LoginController.getLoggedInUserId()) && !role_type.equals("Customer")) {

				// Edit the Event from the 2nd Person's calendar
				ResultSet r4 = null;
				String query4 = "Select DISTINCT string_calendar_id FROM User Natural Join Calendar Natural Join User_Calendar Natural Join User_Event where user_id = ( Select for_user_id from User_Event where event_id = '"
						+ event_id + "' );";
				Statement s4 = AppWithDB.connect().createStatement();
				r4 = s4.executeQuery(query4);
				String partnet_string_calendar_id = null;
				while (r4.next()) {
					partnet_string_calendar_id = r4.getString("string_calendar_id");
				}
				r4.close();
				s4.close();

				ResultSet r5 = null;
				String query5 = "Select event_name, location, from_date, to_date, from_time, to_time from Event where event_id='"
						+ event_id + "';";
				Statement s5 = AppWithDB.connect().createStatement();
				r5 = s5.executeQuery(query5);
				String event_name = null;
				String from_date = null;
				String loocation = null;
				String to_date = null;
				String from_Time = null;
				String to_time = null;
				while (r5.next()) {
					event_name = r5.getString("event_name");
					from_date = r5.getString("from_date");
					loocation = r5.getString("location");
					to_date = r5.getString("to_date");
					from_Time = r5.getString("from_Time");
					to_time = r5.getString("to_time");
				}
				r5.close();
				s5.close();

				GoogleKalendar.editEvent(
						GoogleKalendar.getEventID(partnet_string_calendar_id + "@group.calendar.google.com", event_name,
								loocation, from_Time, to_time, from_date, to_date),
						partnet_string_calendar_id + "@group.calendar.google.com", title, location, date, date,
						startTime, endTime);

				String string_event_id = null;
				ResultSet r1 = null;
				String query1 = "Select string_event_id From Event where event_id='" + event_id + "';";
				Statement s1 = AppWithDB.connect().createStatement();
				r1 = s1.executeQuery(query1);
				while (r1.next()) {
					string_event_id = r1.getString("string_event_id");

				}
				r1.close();
				s1.close();

				// Add the event in DB and return the calendarID which the event most be added
				// on
				String calendarID = AppWithDB.sqlEditEventByManager(event_id, LoginController.getLoggedInUserId(),
						privacy, title, date, startTime, endTime, location);

				GoogleKalendar.editEvent(string_event_id, calendarID, title, location, date, date, startTime, endTime);

			} else if (!for_user.equals(LoginController.getLoggedInUserId()) && role_type.equals("Customer")) {

				String string_event_id = null;
				ResultSet r1 = null;
				String query1 = "Select string_event_id From Event where event_id='" + event_id + "';";
				Statement s1 = AppWithDB.connect().createStatement();
				r1 = s1.executeQuery(query1);
				while (r1.next()) {
					string_event_id = r1.getString("string_event_id");

				}
				r1.close();
				s1.close();

				// Add the event in DB and return the calendarID which the event most be added
				// on
				String calendarID = AppWithDB.sqlEditEventByManager(event_id, LoginController.getLoggedInUserId(),
						privacy, title, date, startTime, endTime, location);

				GoogleKalendar.editEvent(string_event_id, calendarID, title, location, date, date, startTime, endTime);

			}

		}

		return "redirect:/Manager#ManageEvents";

	}

	/**
	 * Response about filter the document
	 * 
	 * @param searchDocumentUser
	 * @return Manager Page, Document Section
	 * @throws SQLException
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	@RequestMapping(value = "searchByUser_Document")
	public String searchByUser_Document(@RequestParam(required = true) String searchDocumentUser)
			throws SQLException, IOException, GeneralSecurityException {

		documentSearch = searchDocumentUser;
		System.out.println(documentSearch);

		return "redirect:/Manager#Documents";

	}

}