package VAKS.run.GoogleCharts;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import VAKS.run.Model.AppWithDB;
/**
 * Google Charts API
 * 
 * @author Mohammed Ali Anis
 * @version 1.0
 * @since 1.0
 *
 */
@Controller
public class GoogleCharts {

	public static HashMap<String, Integer> residenceCountCard = new HashMap<String, Integer>();
	public static HashMap<String, Integer> integrationCourseCard = new HashMap<String, Integer>();
	public static HashMap<String, Integer> homeLandCard = new HashMap<String, Integer>();
	public static HashMap<String, String> genderCard = new HashMap<String, String>();
	public static HashMap<String, Integer> residentCard = new HashMap<String, Integer>();

	/**
	 * To Connect to the DB
	 * @return Connection
	 */
	public static Connection connect() {

		Connection connect = null;
		// Path of the DB
		String path = "src/main/resources/Database/VAKS.db";

		File file = new File(path);
		String absolutePath = file.getAbsolutePath();

		try {

			connect = DriverManager.getConnection("jdbc:sqlite:" + absolutePath);

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return connect;
	}

	@GetMapping("/demoStatistik")
	public String demoStatistik() {

		return "demoStatistik";
	}

	/**
	 * Respone about get values to show statistic about the type of the residence Permit of the users
	 * @return the Result to Manager Script
	 * @throws SQLException
	 */
	public static Map<String, Integer> residenceCount() throws SQLException {
		ResultSet r = null;

		String Query = "SELECT residence_permit_type, COUNT(residence_permit_id) AS Number FROM User Natural Join Residence_Permit Natural Join User_Residence_Permit GROUP BY residence_permit_type;";
		Statement s = null;
		s = AppWithDB.connect().createStatement();
		r = s.executeQuery(Query);

		while (r.next()) {

//			System.out.println(r.getString("residence_permit_type"));
//			System.out.println(r.getString(2));
			residenceCountCard.put(r.getString("residence_permit_type"), Integer.parseInt(r.getString(2)));
		}
		r.close();
		s.close();

//		System.out.println(residenceCountCard);
		Map<String, Integer> graphData = new TreeMap<>();

		for (int i = 0; i < residenceCountCard.size(); i++) {

			graphData.put(residenceCountCard.keySet().toArray()[i].toString(),
					residenceCountCard.get(residenceCountCard.keySet().toArray()[i]));

		}
//		System.out.println("GD" + graphData);

		return graphData;
	}

	/**
	 * Respone about get values to show statistic about the type of the Integration Course
	 * @return the Result to Manager Script
	 * @throws SQLException
	 */
	public static Map<String, Integer> integrationCourse() throws SQLException {
		ResultSet r = null;

		String Query = "SELECT german_level, COUNT(german_level) AS Number FROM User Natural Join Education Natural Join User_Education where german_level!='Nicht Interessiert' GROUP BY german_level;";
		Statement s = null;
		s = AppWithDB.connect().createStatement();
		r = s.executeQuery(Query);

		while (r.next()) {

//			System.out.println(r.getString("german_level"));
//			System.out.println(r.getString(2));
			integrationCourseCard.put(r.getString("german_level"), Integer.parseInt(r.getString(2)));
		}
		r.close();
		s.close();

//		System.out.println(integrationCourseCard);
		Map<String, Integer> graphData = new TreeMap<>();

		for (int i = 0; i < integrationCourseCard.size(); i++) {

			graphData.put(integrationCourseCard.keySet().toArray()[i].toString(),
					integrationCourseCard.get(integrationCourseCard.keySet().toArray()[i]));

		}
//		System.out.println("GD" + graphData);

		return graphData;
	}

	/**
	 * Respone about get values to show statistic about the origin country of the users
	 * @return the Result to Manager Script
	 * @throws SQLException
	 */
	public static Map<String, Integer> homeLand() throws SQLException {
		ResultSet r = null;

		String Query = "SELECT country, COUNT(country) AS Number FROM User Natural Join Role Natural Join User_Role where role_id=4 GROUP BY country;";
		Statement s = null;
		s = AppWithDB.connect().createStatement();
		r = s.executeQuery(Query);

		while (r.next()) {

//			System.out.println(r.getString("country"));
//			System.out.println(r.getString(2));
			homeLandCard.put(r.getString("country"), Integer.parseInt(r.getString(2)));
		}
		r.close();
		s.close();

//		System.out.println(homeLandCard);
		Map<String, Integer> graphData = new TreeMap<>();

		for (int i = 0; i < homeLandCard.size(); i++) {

			graphData.put(homeLandCard.keySet().toArray()[i].toString(),
					homeLandCard.get(homeLandCard.keySet().toArray()[i]));

		}
//		System.out.println("GD" + graphData);

		return graphData;
	}

	/**
	 * Respone about get values to show statistic about the gender of the users
	 * @return the Result to Manager Script
	 * @throws SQLException
	 */
	public static HashMap<String, HashMap<String, String>> gender() throws SQLException {
		ResultSet r = null;
		ArrayList<String> land = new ArrayList<String>();
		String Query = "SELECT DISTINCT country from User;";
		Statement s = null;
		s = AppWithDB.connect().createStatement();
		r = s.executeQuery(Query);
		int cnt = 0;
		while (r.next()) {
			land.add(r.getString(1));
			cnt++;
		}
		r.close();
		s.close();

		HashMap<String, HashMap<String, String>> answer = new HashMap<String, HashMap<String, String>>();

		for (int i = 0; i < land.size(); i++) {

			ResultSet r1 = null;
			String Query1 = "SELECT gender, COUNT(gender) AS Number FROM User where country = '" + land.get(i)
					+ "' AND gender = 'male' GROUP By country, gender;";
			Statement s1 = null;
			s1 = AppWithDB.connect().createStatement();
			r1 = s1.executeQuery(Query1);
			int maleCnt = 0;
			while (r1.next()) {
				maleCnt = Integer.parseInt(r1.getString(2));
			}
			r1.close();
			s1.close();

			ResultSet r2 = null;
			String Query2 = "SELECT gender, COUNT(gender) AS Number FROM User where country = '" + land.get(i)
					+ "' AND gender = 'female' GROUP By country, gender;";
			Statement s2 = null;
			s2 = AppWithDB.connect().createStatement();
			r2 = s2.executeQuery(Query2);
			int femaleCnt = 0;
			while (r2.next()) {
				femaleCnt = Integer.parseInt(r2.getString(2));
			}
			r2.close();
			s2.close();

			HashMap<String, String> sex = new HashMap<String, String>();
			sex.put("male", String.valueOf(maleCnt));
			sex.put("female", String.valueOf(femaleCnt));

			answer.put(land.get(i), sex);

			maleCnt = 0;
			femaleCnt = 0;

		}

		return answer;
	}

	/**
	 * Respone about get values to show statistic about the type of the residence city of the users
	 * @return the Result to Manager Script
	 * @throws SQLException
	 */
	public static Map<String, Integer> resident() throws SQLException {
		ResultSet r = null;

		String Query = "SELECT city, COUNT(city) AS Number FROM User Natural Join Address Natural Join User_Address GROUP BY city;";
		Statement s = null;
		s = AppWithDB.connect().createStatement();
		r = s.executeQuery(Query);

		while (r.next()) {

//			System.out.println(r.getString("city"));
//			System.out.println(r.getString(2));
			residentCard.put(r.getString("city"), Integer.parseInt(r.getString(2)));
		}
		r.close();
		s.close();

//		System.out.println(residentCard);
		Map<String, Integer> graphData = new TreeMap<>();

		for (int i = 0; i < residentCard.size(); i++) {

			graphData.put(residentCard.keySet().toArray()[i].toString(),
					residentCard.get(residentCard.keySet().toArray()[i]));

		}
//		System.out.println("GD" + graphData);

		return graphData;
	}

}
