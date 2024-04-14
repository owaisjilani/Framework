/* @Author :Owais J
 Added For Executing the Failed Test Cases */
package com.aml.testrunners;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(plugin = { "pretty","rerun:target/failures.txt" }, features = "@target/failures.txt", glue = {
		"com.aml.stepdefinitions", "com.aml.utilities" })
public class FailedRunner {
}