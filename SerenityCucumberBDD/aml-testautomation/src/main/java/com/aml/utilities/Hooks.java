package com.aml.utilities;

//@Author :Owais Jilani

import io.cucumber.java.After;
import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.core.pages.PageObject;

public class Hooks extends PageObject {

	String username = "loginForm:user";
	String logout = "logoutBadge-icon";

	// Use tag "@LogoutNotRequired" on specific scenario outline to exclude logout
	// functionality

	@After("not @LogoutNotRequired")
	public void logout() {
		FileUtil.cleanUpDirectory();
	}
}
