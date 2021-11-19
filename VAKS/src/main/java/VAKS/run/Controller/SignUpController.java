package VAKS.run.Controller;

import java.sql.SQLException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import VAKS.run.Model.AppWithDB;

/**
 * Customer Controller
 * 
 * @author Mohammed Ali Anis
 * @version 1.0
 * @since 1.0
 *
 */
@Controller
public class SignUpController {

	/**
	 * For Mapping
	 * 
	 * @return the the Signup view
	 */
	@GetMapping(value = "SignUp")
	public String mapping() {

		return "SignUp";
	}

	/**
	 * Response about register new user from the public page ( By him self )
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
	 * @return the HomePage
	 * @throws SQLException
	 */
	@RequestMapping(value = "register")
	public String getInfo3(@RequestParam(required = false) String firstName, String lastName, String birthday,
			String gender, String email, String userName, String password, String country, String motherLanguage,
			String residencePermit, String street, String number, String city, String post_code, String high_school,
			String university, String integration_course, String dsh_course, String german_level) throws SQLException {

		AppWithDB.sqlAddCustomerByHimSelf(firstName, lastName, birthday, gender, email, userName, password, country,
				motherLanguage, residencePermit, street, number, city, post_code, high_school, university,
				integration_course, dsh_course, german_level);

		VAKS.run.GoogleMail.Email.giveSupervisorInfoEmail(userName, email);

		return "HomePage";

	}

}
