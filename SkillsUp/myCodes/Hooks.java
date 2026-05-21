package com.aml.utilities;


import io.cucumber.java.After;
import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.core.pages.PageObject;
import net.thucydides.core.annotations.Steps;

public class Hooks extends PageObject {
	
	String username = "loginForm:user";
	String logout = "logoutBadge-icon";
	
	@After
	public void logout() {

		$(By.id(logout)).waitUntilClickable();
		$(By.id(logout)).click();
		$(By.id(username)).waitUntilEnabled();
	}
}
