package com.aml.base;

import com.aml.utilities.*;

public class DataIntakeRuleAutomation {

	public static String folderPath = System.getProperty("user.dir");

	public static void main(String[] args) throws Exception {
		DbUtil.setStorageConfig();
		FileUtil.createDataIntakeDirectory();
		CSVGenerator_DD4_0.generateAllCSVs(5,95801002,95803002,95806002,95809002);
 		FileUtil.createzipFolder(folderPath + "\\DataIntakeInput\\", folderPath + "\\DataIntakeInput.zip");
		FileUtil.uploadFiletoS3();
		ServiceUtil.startDataIntake();
		FileUtil.cleanUpDirectory();
		
	}
}
