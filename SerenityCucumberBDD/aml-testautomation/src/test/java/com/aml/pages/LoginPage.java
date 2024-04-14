package com.aml.pages;

import com.aml.utilities.FileUtil;
import net.serenitybdd.core.pages.PageObject;
import net.thucydides.core.annotations.Step;
import org.openqa.selenium.By;

//@DefaultUrl("https://www.saucedemo.com/")
public class LoginPage extends PageObject {

	String username = "user-name";
	String password = "password";

	@Step
	public void verifyLoginPage() {
		$(By.id(username)).waitUntilEnabled();
	}

	@Step
	public void enterUsername(String User_Role) throws Exception {

		$(By.id(username)).typeAndEnter(FileUtil.readProperty("username_" + User_Role));
	}

	@Step
	public void enterPassword(String User_Role) throws Exception {

		$(By.id(password)).typeAndEnter(FileUtil.readProperty("password_" + User_Role));
	}

	@Step
	public void verifyRedirectedToInventoryPage() {
		// Imple
	}
}
