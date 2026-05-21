package Utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

public class PropertiesReader{
	String Filepath ="TestData_QA.properties";
	private static PropertiesReader instance = null;
	private Properties properties;
	private FileOutputStream outputStream;

	protected PropertiesReader() throws Exception{

		properties = new Properties();
		properties.load(new FileInputStream(new File(Filepath)));

	}

	public static PropertiesReader getInstance() {
		if(instance == null) {
			try {
				instance = new PropertiesReader();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return instance;
	}

	public String getValue(String key) {
		return properties.getProperty(key);
	}

	public void setValue(String key,String value) {


		try {

			outputStream=new FileOutputStream(Filepath);
			properties.putIfAbsent(key, value);
			properties.store(outputStream, "This is a comment");

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}

