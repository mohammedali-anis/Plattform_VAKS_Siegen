package VAKS.run.GoogleMail;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import VAKS.run.Model.AppWithDB;

/**
 * Google Charts API
 * 
 * @author Mohammed Ali Anis
 * @version 1.0
 * @since 1.0
 *
 */
public class Email {
	static String from = "vaks.noreply@gmail.com"; // from address. As this is using Gmail SMTP your from address should
	static String password = "vaks.noreply21";											// by Gmail

	/**
	 * 
	 * @return session
	 */
	public static Session emailInit() {

		// This email Address has been created to send all Email from it (
		// noreply.elbis@gmail.com )

		

		Properties prop = new Properties();
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", "465");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.socketFactory.port", "465");
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(from, password);
			}
		});

		return session;
	}

	/**
	 * response about sending email by creating new event
	 * 
	 * @param string_event_id the eventID which has been created
	 * @throws SQLException
	 */
	public static void userCreateEventEmail(String string_event_id) throws SQLException {

		ResultSet r = null;
		String query = "Select event_name, from_date, from_time, to_time, event_id, (Select first_name from User where user_id=(select for_user_id from Event Natural Join User_Event where string_event_id='"
				+ string_event_id
				+ "')), (Select last_name from User where user_id=(select for_user_id from Event Natural Join User_Event where string_event_id='"
				+ string_event_id
				+ "')), (Select gender from User where user_id=(select for_user_id from Event Natural Join User_Event where string_event_id='"
				+ string_event_id
				+ "')), (Select email from User where user_id=(select for_user_id from Event Natural Join User_Event where string_event_id='"
				+ string_event_id + "')) from Event Natural Join User_Event where string_event_id='" + string_event_id
				+ "';";
		Statement s = AppWithDB.connect().createStatement();
		r = s.executeQuery(query);

		String event_name, from_date = null, from_time = null, to_time = null, event_id = null, first_name,
				last_name = null, gender = null, email = null;

		while (r.next()) {
			event_name = r.getString(1);
			from_date = r.getString(2);
			from_time = r.getString(3);
			to_time = r.getString(4);
			event_id = r.getString(5);
			first_name = r.getString(6);
			last_name = r.getString(7);
			gender = r.getString(8);
			email = r.getString(9);

		}
		r.close();
		s.close();

//		String to = an; // to address. It can be any like gmail, yahoo etc.

		Session session = emailInit();

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject("VAKS | New Appointemnt");
			String msg = null;

			if (gender.equals("male")) {
				msg = "Dear Mr. " + last_name + "," + System.lineSeparator() +

						"your Appointemnt (ID: " + event_id + " ) on: " + from_date + ", From : " + from_time
						+ " - to : " + to_time + ", has been booked successfully." + System.lineSeparator()
						+ System.lineSeparator() +

						"Your VAKS | Siegen" + System.lineSeparator() + "-----------------------" + "Hinterstraße 52"
						+ System.lineSeparator() + "57072, Siegen" + "Tel. 0271 21900";
			} else {
				msg = "Dear Mrs. " + last_name + "," + System.lineSeparator() +

						"your Appointemnt (ID: " + event_id + " ) on: " + from_date + ", From : " + from_time
						+ " - to : " + to_time + ", has been booked successfully." + System.lineSeparator()
						+ System.lineSeparator() +

						"Your VAKS | Siegen" + System.lineSeparator() + "-----------------------"
						+ System.lineSeparator() + "Hinterstraße 52" + System.lineSeparator() + "57072, Siegen"
						+ System.lineSeparator() + "Tel. 0271 21900";
			}

			message.setText(msg);

			Transport.send(message);

//			System.out.println("Mail Sent...");

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Response about sending Email by Delete an Event
	 * 
	 * @param event_name the name of the deleted Event
	 * @param from_date  the Start Date of Event
	 * @param from_time  the start time of the event
	 * @param to_time    the end time of the event
	 * @param event_id   the event id
	 * @param first_name the lastname of the event's owner
	 * @param last_name  the firstname of the event's owner
	 * @param gender     the gender of the event's owner
	 * @param email      the email of the event's owner
	 * @throws SQLException
	 */
	public static void userDeleteEventEmail(String event_name, String from_date, String from_time, String to_time,
			String event_id, String first_name, String last_name, String gender, String email) throws SQLException {

		Session session = emailInit();

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject("VAKS | Canceled Appointemnt");
			String msg = null;

			if (gender.equals("male")) {
				msg = "Dear Mr. " + last_name + "," + System.lineSeparator() +

						"your Appointemnt (ID: " + event_id + " ) on: " + from_date + ", From : " + from_time
						+ " - to : " + to_time + ", has been canceled successfully." + System.lineSeparator()
						+ System.lineSeparator() +

						"Your VAKS | Siegen" + System.lineSeparator() + "-----------------------" + "Hinterstraße 52"
						+ System.lineSeparator() + "57072, Siegen" + "Tel. 0271 21900";
			} else {
				msg = "Dear Mrs. " + last_name + "," + System.lineSeparator() +

						"your Appointemnt (ID: " + event_id + " ) on: " + from_date + ", From : " + from_time
						+ " - to : " + to_time + ", has been canceled successfully." + System.lineSeparator()
						+ System.lineSeparator() +

						"Your VAKS | Siegen" + System.lineSeparator() + "-----------------------"
						+ System.lineSeparator() + "Hinterstraße 52" + System.lineSeparator() + "57072, Siegen"
						+ System.lineSeparator() + "Tel. 0271 21900";
			}

			message.setText(msg);

			Transport.send(message);

//			System.out.println("Mail Sent...");

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * @param string_event_id event_id of the Edited Event
	 * @throws SQLException
	 */
	public static void userEditEventEmail(String string_event_id) throws SQLException {

		ResultSet r = null;
		String query = "Select event_name, from_date, from_time, to_time, event_id, (Select first_name from User where user_id=(select for_user_id from Event Natural Join User_Event where string_event_id='"
				+ string_event_id
				+ "')), (Select last_name from User where user_id=(select for_user_id from Event Natural Join User_Event where string_event_id='"
				+ string_event_id
				+ "')), (Select gender from User where user_id=(select for_user_id from Event Natural Join User_Event where string_event_id='"
				+ string_event_id
				+ "')), (Select email from User where user_id=(select for_user_id from Event Natural Join User_Event where string_event_id='"
				+ string_event_id + "')) from Event Natural Join User_Event where string_event_id='" + string_event_id
				+ "';";
		Statement s = AppWithDB.connect().createStatement();
		r = s.executeQuery(query);

		String event_name, from_date = null, from_time = null, to_time = null, event_id = null, first_name,
				last_name = null, gender = null, email = null;

		while (r.next()) {
			event_name = r.getString(1);
			from_date = r.getString(2);
			from_time = r.getString(3);
			to_time = r.getString(4);
			event_id = r.getString(5);
			first_name = r.getString(6);
			last_name = r.getString(7);
			gender = r.getString(8);
			email = r.getString(9);

		}
		r.close();
		s.close();

		Session session = emailInit();

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject("VAKS | Edit Appointemnt");
			String msg = null;

			if (gender.equals("male")) {
				msg = "Dear Mr. " + last_name + "," + System.lineSeparator() +

						"your Appointemnt (ID: " + event_id + " ) has been edited successfully."
						+ System.lineSeparator() + "Here is the new appointment informations : "
						+ System.lineSeparator() + "1. Appointment Date : " + from_date + System.lineSeparator()
						+ "2. Appointemnt Time : " + from_time + " - " + to_time + System.lineSeparator()
						+ System.lineSeparator() +

						"Your VAKS | Siegen" + System.lineSeparator() + "-----------------------" + "Hinterstraße 52"
						+ System.lineSeparator() + "57072, Siegen" + "Tel. 0271 21900";
			} else {
				msg = "Dear Mrs. " + last_name + "," + System.lineSeparator() +

						"your Appointemnt (ID: " + event_id + " ) has been edited successfully."
						+ System.lineSeparator() + "Here is the new appointment informations : "
						+ System.lineSeparator() + "1. Appointment Date : " + from_date + System.lineSeparator()
						+ "2. Appointemnt Time : " + from_time + " - " + to_time + System.lineSeparator()
						+ System.lineSeparator() +

						"Your VAKS | Siegen" + System.lineSeparator() + "-----------------------" + "Hinterstraße 52"
						+ System.lineSeparator() + "57072, Siegen" + "Tel. 0271 21900";
			}

			message.setText(msg);

			Transport.send(message);

//			System.out.println("Mail Sent...");

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Response about sending Email to The user who has registerd new to tell him
	 * who is his/her supervisor
	 * 
	 * @param username the username of the new user
	 * @param email    the email of the new user
	 * @throws SQLException
	 */
	public static void giveSupervisorInfoEmail(String username, String email) throws SQLException {

		ResultSet r = null;
		String query = "Select first_name, last_name, email, mobile, gender from User where user_id=(Select worker_id from User Natural Join Kunde_Supervised_By_Worker where email='"
				+ email + "' AND username='" + username + "' AND kunde_id=user_id);";
		Statement s = AppWithDB.connect().createStatement();
		r = s.executeQuery(query);

		HashMap<String, String> supervisorInfo = new HashMap<String, String>();

		while (r.next()) {
			supervisorInfo.put("first_name", r.getString("first_name"));
			supervisorInfo.put("last_name", r.getString("last_name"));
			supervisorInfo.put("email", r.getString("email"));
			supervisorInfo.put("gender", r.getString("gender"));
		}
		r.close();
		s.close();

		ResultSet r2 = null;
		String query2 = "Select user_id, first_name, last_name, gender, email From User where username='" + username
				+ "' AND email='" + email + "' ;";
		Statement s2 = AppWithDB.connect().createStatement();
		r2 = s2.executeQuery(query2);

		HashMap<String, String> userInfo = new HashMap<String, String>();

		while (r2.next()) {
			userInfo.put("user_id", r2.getString("user_id"));
			userInfo.put("first_name", r2.getString("first_name"));
			userInfo.put("last_name", r2.getString("last_name"));
			userInfo.put("email", r2.getString("email"));
			userInfo.put("gender", r2.getString("gender"));
		}
		r2.close();
		s2.close();

		Session session = emailInit();

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject("VAKS | User Registration");
			String msg = null;

			if (userInfo.get("gender").equals("male")) {
				msg = "Dear Mr. " + userInfo.get("last_name") + "," + System.lineSeparator() +

						"you have been registerd successfully, " + "Your User ID : " + userInfo.get("user_id")
						+ System.lineSeparator() + System.lineSeparator() +

						"Below is some Information about your supervisor : " + System.lineSeparator() + "First Name : "
						+ supervisorInfo.get("first_name") + System.lineSeparator() + "Last Name : "
						+ supervisorInfo.get("last_name") + System.lineSeparator() + "Gender : "
						+ supervisorInfo.get("gender").toUpperCase() + System.lineSeparator() + "E-Mail : "
						+ supervisorInfo.get("email") + System.lineSeparator() + System.lineSeparator() +

						"Your VAKS | Siegen" + System.lineSeparator() + "-----------------------"
						+ System.lineSeparator() + "Hinterstraße 52" + System.lineSeparator() + "57072, Siegen"
						+ System.lineSeparator() + "Tel. 0271 21900";
			} else {
				msg = "Dear Mrs. " + userInfo.get("last_name") + "," + System.lineSeparator() +

						"you have been registerd successfully, " + "Your User ID : " + userInfo.get("user_id")
						+ System.lineSeparator() + System.lineSeparator() +

						"Below is some Information about your supervisor : " + System.lineSeparator() + "First Name : "
						+ supervisorInfo.get("first_name") + System.lineSeparator() + "Last Name : "
						+ supervisorInfo.get("last_name") + System.lineSeparator() + "Gender : "
						+ supervisorInfo.get("gender").toUpperCase() + System.lineSeparator() + "E-Mail : "
						+ supervisorInfo.get("email") + System.lineSeparator() + System.lineSeparator() +

						"Your VAKS | Siegen" + System.lineSeparator() + "-----------------------"
						+ System.lineSeparator() + "Hinterstraße 52" + System.lineSeparator() + "57072, Siegen"
						+ System.lineSeparator() + "Tel. 0271 21900";
			}

			message.setText(msg);

			Transport.send(message);

			System.out.println("Mail Sent...");

		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}

}