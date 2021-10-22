package VAKS.run.GoogleCalendar;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.security.GeneralSecurityException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Collections;
import java.util.List;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.DateTime;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.CalendarScopes;
import com.google.api.services.calendar.model.AclRule;
import com.google.api.services.calendar.model.AclRule.Scope;
import com.google.api.services.calendar.model.Event;
import com.google.api.services.calendar.model.EventDateTime;
import com.google.api.services.calendar.model.Events;

/**
 * Google Calendar API
 * 
 * @author Mohammed Ali Anis
 * @version 1.0
 * @since 1.0
 *
 */
public class GoogleKalendar {

	static NetHttpTransport HTTP_TRANSPORT;
	static Calendar service;

	private static final String APPLICATION_NAME = "Google Calendar API Java Quickstart";
	private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
	private static final String TOKENS_DIRECTORY_PATH = "tokens";

	private static final List<String> SCOPES = Collections.singletonList(CalendarScopes.CALENDAR);
	private static final String CREDENTIALS_FILE_PATH = "/credentials.json";

	/**
	 * Creates an authorized Credential object.
	 * 
	 * @param HTTP_TRANSPORT The network HTTP Transport.
	 * @return An authorized Credential object.
	 * @throws IOException If the credentials.json file cannot be found.
	 */
	private static Credential getCredentials(final NetHttpTransport HTTP_TRANSPORT) throws IOException {
		// Load client secrets.
		InputStream in = GoogleKalendar.class.getResourceAsStream(CREDENTIALS_FILE_PATH);
		if (in == null) {
			throw new FileNotFoundException("Resource not found: " + CREDENTIALS_FILE_PATH);
		}
		GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));

		// Build flow and trigger user authorization request.
		GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(HTTP_TRANSPORT, JSON_FACTORY,
				clientSecrets, SCOPES)
						.setDataStoreFactory(new FileDataStoreFactory(new java.io.File(TOKENS_DIRECTORY_PATH)))
						.setAccessType("offline").build();
		LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8888).build();
		return new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");
	}

	public static void showUpcomingEvents() throws IOException, GeneralSecurityException {

		HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
		service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
				.setApplicationName(APPLICATION_NAME).build();

		// List the next events from the primary calendar.
		DateTime now = new DateTime("2000-10-07T18:01:53.114+02:00");
		// Print the started date
		System.err.println("Start From : " + now.toString());

		Events events = service.events().list("primary").setTimeMin(now).setOrderBy("startTime").setSingleEvents(true)
				.execute();
		List<Event> items = events.getItems();
		// Print the Events count
		System.err.println("The number of the events Is : " + items.size());

		System.out.println();

		if (items.isEmpty()) {
			System.out.println("No upcoming events found.");
		} else {
			System.out.println("Upcoming events");
			for (Event event : items) {
				DateTime start = event.getStart().getDateTime();
				if (start == null) {
					start = event.getStart().getDate();
				}
				System.out.printf("%s (%s)\n", event.getSummary(), start);
			}
		}

	}

	/**
	 * Respone about creating new Event
	 * 
	 * @param calendarID the Id of the Calendar whcih the new event must be belongs
	 *                   to
	 * @param eventName  The event name
	 * @param Location   the location of the event
	 * @param startDate  the start date of the event
	 * @param endDate    the end date of the event
	 * @param startTime  the start time of the event
	 * @param endTime    the end time of the event
	 * @return the event_id
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	public static String creatEvent(String calendarID, String eventName, String Location, String startDate,
			String endDate, String startTime, String endTime) throws IOException, GeneralSecurityException {

		HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
		Calendar service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
				.setApplicationName("applicationName").build();

		Event event = new Event().setSummary(eventName).setLocation(Location);

		DateTime startDateTime = new DateTime(startDate + "T" + startTime + ":00+02:00"); // :00 is Seconds and +02:00
																							// is the time zone offset
		EventDateTime start = new EventDateTime().setDateTime(startDateTime).setTimeZone("Europe/Berlin");
		event.setStart(start);

		DateTime endDateTime = new DateTime(endDate + "T" + endTime + ":00+02:00"); // :00 is Seconds and +02:00 is the
																					// time zone offset
		EventDateTime end = new EventDateTime().setDateTime(endDateTime).setTimeZone("Europe/Berlin");
		event.setEnd(end);

		try {
			event = service.events().insert(calendarID, event).execute();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		System.out.printf("Event created: %s\n", event.getHtmlLink());
//		System.out.println("ID " + event.getId());
//		System.out.println("RecurringEventId " + event.getRecurringEventId());
//		System.out.println("ICalUID " + event.getICalUID());

		return event.getId();
	}

	/**
	 * Respone about creating new Calendar to new User
	 * 
	 * @param calenderName The name of the calendar (UserRole, Firstname, Lastname)
	 * @return the calendarID before the @ sign (xxxxxxx@group.gmail.com)
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	public static String creatCalender(String calenderName) throws IOException, GeneralSecurityException {

		HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
		Calendar service2 = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
				.setApplicationName("applicationName").build();

		// Create a new calendar
		com.google.api.services.calendar.model.Calendar calendar = new com.google.api.services.calendar.model.Calendar();
		calendar.setSummary(calenderName);
		calendar.setTimeZone("Europe/Berlin");

		// Insert the new calendar
		com.google.api.services.calendar.model.Calendar createdCalendar = service2.calendars().insert(calendar)
				.execute();

		System.out.println("calender Created, The calender ID : " + createdCalendar.getId());
		/*
		 * CalendarID = qe3vrs29258alk1rcnk7h4h26o@group.calendar.google.com return the
		 * first part before @
		 */
		return createdCalendar.getId().split("@")[0];
	}

	/**
	 * Response about deleting Event
	 * 
	 * @param eventID    the id of the vent which must be deleted
	 * @param calendarID the calendar id which the event belongs to
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	public static void deleteEvent(String eventID, String calendarID) throws IOException, GeneralSecurityException {

		HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
		Calendar service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
				.setApplicationName("applicationName").build();

		// Delete an event
		service.events().delete(calendarID, eventID).execute();
		System.out.println("Event has been deleted");
	}

	public static String decoderEventId(String eventID) {
		// Decoder Base64 to UTF-8
		String encodedString = eventID;

		Decoder decoder = Base64.getDecoder();
		byte[] bytes = decoder.decode(encodedString);
		String dec = new String(bytes);

		String[] splitStr = dec.trim().split("\\s+");
		// splitStr[0] = EventID
		// splitStr[0] = MailID
		return splitStr[0];
	}

	/**
	 * Response about deleting calendar
	 * 
	 * @param calenderID the calendar ID which must be deleted
	 * @throws IOException
	 */
	public static void deleteCalender(String calenderID) throws IOException {

		Calendar service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
				.setApplicationName("applicationName").build();

		// Delete a calendar
		service.calendars().delete(calenderID).execute();
		System.out.println("Calender has been deleted");
	}

	/**
	 * Response about changing the calendar to public
	 * 
	 * @param string_calendar_id the id of the calendar which must be public
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	public static void makeCalendarPublic(String string_calendar_id) throws IOException, GeneralSecurityException {
		// Initialize Calendar service with valid OAuth credentials
		HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
		Calendar service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
				.setApplicationName("applicationName").build();

		// Create access rule with associated scope
		AclRule rule = new AclRule();
		Scope scope = new Scope();
		scope.setType("default");
		scope.setValue("");

		rule.setScope(scope);
		rule.setRole("reader");

		// Insert new access rule
		AclRule createdRule = service.acl().insert(string_calendar_id + "@group.calendar.google.com", rule).execute();
		System.out.println(createdRule.getId());

	}

	/**
	 * To Encode from UTF to BASE64
	 * 
	 * @param string_calendar_id
	 * @return enodedString
	 */
	public static String utfTObase(String string_calendar_id) {

		String UTF = string_calendar_id + "@group.calendar.google.com";
		String BASE64 = Base64.getEncoder().encodeToString(UTF.getBytes());

		return BASE64.split("==")[0] + "&amp";

	}

	/**
	 * Response about editing Event
	 * 
	 * @param event_id    the id of the event which must be edited
	 * @param calendar_id the calendar_id of the event which belong to
	 * @param eventName   the changed Event name
	 * @param Location    the location of the changed the vent
	 * @param startDate   the start date of the new event
	 * @param endDate     the end date of the new event
	 * @param startTime   the start date of the new event
	 * @param endTime     the end date of the new event
	 * @throws GeneralSecurityException
	 * @throws IOException
	 */
	public static void editEvent(String event_id, String calendar_id, String eventName, String Location,
			String startDate, String endDate, String startTime, String endTime)
			throws GeneralSecurityException, IOException {

		// Initialize Calendar service with valid OAuth credentials
		HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
		Calendar service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
				.setApplicationName("applicationName").build();

		// Retrieve the event from the API
		Event event = service.events().get(calendar_id, event_id).execute();

		DateTime startDateTime = new DateTime(startDate + "T" + startTime + ":00+02:00"); // :00 is Seconds and +02:00
																							// is the time zone offset
		EventDateTime start = new EventDateTime().setDateTime(startDateTime).setTimeZone("Europe/Berlin");

		DateTime endDateTime = new DateTime(endDate + "T" + endTime + ":00+02:00"); // :00 is Seconds and +02:00 is the
																					// time zone offset
		EventDateTime end = new EventDateTime().setDateTime(endDateTime).setTimeZone("Europe/Berlin");

		// Make a change
		event.setSummary(eventName);
		event.setLocation(Location);
		event.setStart(start);
		event.setEnd(end);

		// Update the event
		Event updatedEvent = service.events().update(calendar_id, event_id, event).execute();

		System.out.println(updatedEvent.getUpdated());

	}

	/**
	 * To get the event ID
	 * 
	 * @param calendarID the calendar ID which the event belongs to
	 * @param title      the name of the vent
	 * @param location   the location of the event
	 * @param startTime  the start date of the event
	 * @param endTime    the end time of the event
	 * @param startDate  the start date of the event
	 * @param endDate    the end Date of the event
	 * @return return the event ID
	 * @throws GeneralSecurityException
	 * @throws IOException
	 */
	public static String getEventID(String calendarID, String title, String location, String startTime, String endTime,
			String startDate, String endDate) throws GeneralSecurityException, IOException {
		HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
		Calendar service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
				.setApplicationName("applicationName").build();

		Events events = service.events().list(calendarID).execute();

		List<Event> items = events.getItems();
		String id = null;

		for (int i = 0; i < items.size(); i++) {

			if (items.get(i).getSummary().equals(title) && items.get(i).getLocation().equals(location)
					&& items.get(i).getStart().getDateTime().toString()
							.equals(startDate + "T" + startTime + ":00.000+02:00")
					&& items.get(i).getEnd().getDateTime().toString()
							.equals(endDate + "T" + endTime + ":00.000+02:00")) {
				id = items.get(i).getId();
			}
		}
		return id;
	}

	/**
	 * response about check the avalible time in the calendar to book an appointemnt
	 * 
	 * @param string_calendar_id the calendar ID
	 * @param day                the date which nust be checked
	 * @return ArrayList with the free times !
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	public static ArrayList<String> avalibleTimeForUser(String string_calendar_id, String day)
			throws IOException, GeneralSecurityException {

		HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
		service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
				.setApplicationName(APPLICATION_NAME).build();

		DateTime fromTime = new DateTime(day + "T00:00:00.000+02:00");
		DateTime toTime = new DateTime(day + "T23:59:00.000+02:00");

		Events events = service.events().list(string_calendar_id + "@group.calendar.google.com").setTimeMin(fromTime)
				.setTimeMax(toTime).setOrderBy("startTime").setSingleEvents(true).execute();
		List<Event> items = events.getItems();

		ArrayList<String> bookedEvent = new ArrayList<String>();

		if (items.isEmpty()) {

		} else {

			for (Event event : items) {
				DateTime start = event.getStart().getDateTime();
				DateTime end = event.getEnd().getDateTime();

				if (start == null) {
					start = event.getStart().getDateTime();
				}
				bookedEvent.add(start.toString().split("T")[1].split(":00.000")[0] + " - "
						+ end.toString().split("T")[1].split(":00.000")[0]);

			}
		}

		ArrayList<String> hours = new ArrayList<String>();
		hours.add("08:00 - 08:30");
		hours.add("08:30 - 09:00");

		hours.add("09:00 - 09:30");
		hours.add("09:30 - 10:00");

		hours.add("10:00 - 10:30");
		hours.add("10:30 - 11:00");

		hours.add("11:00 - 11:30");
		hours.add("11:30 - 12:00");

		hours.add("12:00 - 12:30");
		hours.add("12:30 - 13:00");

		hours.add("13:00 - 13:30");
		hours.add("13:30 - 14:00");

		hours.add("14:00 - 14:30");
		hours.add("14:30 - 15:00");

		hours.add("15:00 - 15:30");
		hours.add("15:30 - 16:00");

		hours.add("16:00 - 16:30");
		hours.add("16:30 - 17:00");

		hours.add("17:00 - 17:30");
		hours.add("17:30 - 18:00");

		ArrayList<String> free = hours;

		free.removeAll(bookedEvent);

		return free;

	}

	public static void main(String[] args) throws GeneralSecurityException, IOException, SQLException {

		showUpcomingEvents();

	}
}