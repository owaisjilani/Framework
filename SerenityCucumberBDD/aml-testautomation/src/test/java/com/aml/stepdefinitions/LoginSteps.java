package com.aml.stepdefinitions;

import com.aml.pages.LoginPage;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.thucydides.core.annotations.Steps;


public class LoginSteps  {

	@Steps
	LoginPage LoginPage;

	@Given("user is on login page")
	public void user_is_on_login_page() {
		LoginPage.open();
		LoginPage.verifyLoginPage();
	}

	@When("user login as {string}")
	public void user_login_as_admin(String User_Role) throws Exception {
		LoginPage.enterUsername(User_Role);
		LoginPage.enterPassword(User_Role);
	}
	@Then("User should be redirected to the inventory page")
	public void user_should_be_redirected_to_the_inventory_page()
	{
		LoginPage.verifyRedirectedToInventoryPage();
	}
}
