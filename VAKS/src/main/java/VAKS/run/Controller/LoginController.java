package VAKS.run.Controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import VAKS.run.Model.AppWithDB;
/**
 * Login Controller
 * 
 * @author Mohammed Ali Anis
 * @version 1.0
 * @since 1.0
 *
 */
@Controller
public class LoginController {

	private static String loggedInUsername;
	private static String loggedInUserId;

	public static String getLoggedInUsername() {
		return loggedInUsername;
	}

	public static void setLoggedInUsername(String loggedInUsername) {
		LoginController.loggedInUsername = loggedInUsername;
	}
	
	public static String getLoggedInUserId() {
		return loggedInUserId;
	}

	public static void setLoggedInUserId(String loggedInUserId) {
		LoginController.loggedInUserId = loggedInUserId;
	}

	@GetMapping("/Login")
	public String map() {

		return "Login";
	}

	@RequestMapping(value = "Login", method = RequestMethod.POST)
	public String mapToRightPage(@RequestParam(required = false) String username, String password) throws SQLException {
		
		ResultSet r = null;
		

		String Query = "Select user_id from User where username='" + username
				+ "' AND password='" + password + "';";
		Statement s = null;
		s = AppWithDB.connect().createStatement();
		r = s.executeQuery(Query);
		while (r.next()) {
			
			setLoggedInUserId(r.getString("user_id"));
		}
		r.close();
		s.close();
		
		System.out.println(getLoggedInUserId());

		if (AppWithDB.sqlLogin(username, password) == 1) {
			setLoggedInUsername(username);
			return "Manager";
		} else if (AppWithDB.sqlLogin(username, password) == 2) {
			setLoggedInUsername(username);
			return "Worker";
		} else if (AppWithDB.sqlLogin(username, password) == 3) {
			setLoggedInUsername(username);
			return "Volunteer";
		} else if (AppWithDB.sqlLogin(username, password) == 4) {
			setLoggedInUsername(username);
			return "redirect:/Customer#Dashboard";
			
		} else
			return "Error";
	}

}
