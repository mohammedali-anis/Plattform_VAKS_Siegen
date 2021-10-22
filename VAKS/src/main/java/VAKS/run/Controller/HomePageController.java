package VAKS.run.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
/**
 * Home Page Controller
 * 
 * @author Mohammed Ali Anis
 * @version 1.0
 * @since 1.0
 *
 */
@Controller
public class HomePageController {
	/**
	 * For Mapping
	 * 
	 * @return the the HomePage view
	 */
	@GetMapping(value = { "/", "home", "index" })
	public String mapping() {

		return "HomePage";

	}

}
