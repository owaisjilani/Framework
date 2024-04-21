package com.programs;

public class EntityPage //extends PageObject 
{
	
	String firstName="//input[text()='First Name']";
	String lastName="//input[text()='Last Name']";
	String submitButton="//button[@id='Submit']";
	String cancelButton="//button[@id='Cancel']";
	
	
	public void setFirstName()
	{
//		$By.xpath(firstName).click();
//		$By.xpath(firstName).sendKeys("NameOS");
		
	}
	
	public void setLastName()
	{
//		$By.xpath(lastName).click();
//		$By.xpath(lastName).sendKeys("LastOS");
		
	}
	
	public void clickSubmit()
	{
//		$By.xpath(submitButton).click();
		
	}
	
	public void clickCancel()
	{
//		$By.xpath(cancelButton).click();
		
	}


}
