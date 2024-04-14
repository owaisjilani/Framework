package com.aml.testrunners;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = { "pretty", "rerun:target/failures.txt" },
        features = "src/test/resources/features",
        tags = "@Regression",
        glue = {"com.aml.stepdefinitions", "com.aml.utilities" }
)

public class CucumberTestSuite {

}
