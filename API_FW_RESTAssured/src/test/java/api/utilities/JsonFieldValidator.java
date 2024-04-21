package api.utilities;

import io.restassured.response.ValidatableResponse;

import static org.hamcrest.Matchers.equalTo;

public class JsonFieldValidator implements ResponseValidator {
    private final String jsonPath;
    private final Object expectedValue;

    public JsonFieldValidator(String jsonPath, Object expectedValue) {
        this.jsonPath = jsonPath;
        this.expectedValue = expectedValue;
    }

    @Override
    public void validate(ValidatableResponse response) {
        response.body(jsonPath, equalTo(expectedValue));
    }
}
