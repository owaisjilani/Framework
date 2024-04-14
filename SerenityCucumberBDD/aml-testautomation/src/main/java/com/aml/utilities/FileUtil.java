package com.aml.utilities;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.FileWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.*;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import com.opencsv.CSVReader;

import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.PutObjectRequest;

/*
@Author 
owais Jilani
26-June-21  */

public class FileUtil {
	public static String folderPath = System.getProperty("user.dir");
	public static String bucket_name = "evidences-bucket";
	public static String key_name = "dataiq/dataintake/DataIntakeInput.zip";
	public static String AWS_ACCESS_KEY_ID = "AKIAIZ7IKXNGBHXS5DWQ";
	public static String AWS_SECRET_ACCESS_KEY = "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";
	public static String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

	public static HashMap<String, String> hmap = new HashMap<>();

	public static void cleanUpDirectory() {
		try {
			File dir = new File(folderPath + "\\DataIntakeInput\\");
			for (File file : dir.listFiles()) {
				if (file.isDirectory())
					cleanUpDirectory();
				file.delete();
			}
			dir.delete();
			System.out.format("\n---Clean Up Completed---\n");
		} catch (Exception e) {
			System.out.format("\n---No Need for Clean Up Folder doesn't Exist---\n");
		}
	}

	public static void createDataIntakeDirectory() {
		File directory = new File(folderPath + "\\DataIntakeInput\\");
		if (!directory.exists()) {
			directory.mkdir();
		}
	}

	protected static void saveToFile(String data, String filename) {
		try (FileWriter fw = new FileWriter(filename)) {
			fw.write(data);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	static public void createzipFolder(String srcFolder, String destZipFile) throws Exception {
		ZipOutputStream zip = null;
		FileOutputStream fileWriter = null;

		fileWriter = new FileOutputStream(destZipFile);
		zip = new ZipOutputStream(fileWriter);

		addFolderToZip("", srcFolder, zip);
		zip.flush();
		zip.close();
		System.out.format("\n---All CSV Files Generated Successfully---\n");
	}

	static private void addFileToZip(String path, String srcFile, ZipOutputStream zip) throws Exception {

		File folder = new File(srcFile);
		if (folder.isDirectory()) {
			addFolderToZip(path, srcFile, zip);
		} else {
			byte[] buf = new byte[1024];
			int len;
			FileInputStream in = new FileInputStream(srcFile);
			zip.putNextEntry(new ZipEntry(path + "/" + folder.getName()));
			while ((len = in.read(buf)) > 0) {
				zip.write(buf, 0, len);
			}
		}
	}

	static private void addFolderToZip(String path, String srcFolder, ZipOutputStream zip) throws Exception {
		File folder = new File(srcFolder);

		for (String fileName : folder.list()) {
			if (path.equals("")) {
				addFileToZip(folder.getName(), srcFolder + "/" + fileName, zip);
			} else {
				addFileToZip(path + "/" + folder.getName(), srcFolder + "/" + fileName, zip);
			}
		}
	}

	public static void uploadFiletoS3() {
		String file_path = folderPath + "\\DataIntakeInput.zip";
		BasicAWSCredentials credentials = new BasicAWSCredentials(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY);
		AmazonS3 s3 = new AmazonS3Client(credentials);
		Region usWest2 = Region.getRegion(Regions.US_WEST_2);
		s3.setRegion(usWest2);
		System.out.format("\nUploading %s to S3 %s...\n", file_path, bucket_name);
		s3.putObject(new PutObjectRequest(bucket_name, key_name, new File(file_path)));
	}

	/*
	 * @Author Owais Jilani 13-July-21
	 */

	public static String readCSVByCustomerID(String fileName, String customerIdHeader, String customerId,
			String valueHeader) {
		String value = null;
		String filepath = folderPath + "\\DataIntakeInput\\" + fileName;
		String csvcustomerId = null;
		try (BufferedReader br = new BufferedReader(new FileReader(filepath));
				CSVParser parser = CSVFormat.DEFAULT.withDelimiter(',').withHeader().parse(br);) {

			for (CSVRecord record : parser) {
				csvcustomerId = record.get(customerIdHeader);

				if (csvcustomerId.equalsIgnoreCase(customerId)) {
					value = record.get(valueHeader);
					System.out.println("CSV Value::" + value);
				}

			}

		} catch (Exception e) {
			System.out.println(e);
		}
		return value.trim();
	}

	public static String readProperty(String key) throws Exception {
		if (System.getProperty("environment") != null) {
			String executionEnv = System.getProperty("environment");
			FileReader reader = new FileReader(folderPath + "\\" + executionEnv + "_application.properties");
			Properties p = new Properties();
			p.load(reader);
			String value = p.getProperty(key);
			System.out.println(p.getProperty(key));
			return value;
		}

		FileReader reader = new FileReader(folderPath + "\\" + "application.properties");
		Properties p = new Properties();
		p.load(reader);
		String value = p.getProperty(key);
		System.out.println(p.getProperty(key));
		return value;

	}

	public static Map<String, String> readCSVasMap(String fileName) {
		String path = "";
		try {
			path = readProperty("downloadReportFolder") + fileName;
		} catch (Exception e) {
			System.out.println(e);
		}
		Map<String, String> map = new HashMap<>();
		try (FileReader filereader = new FileReader(path); CSVReader reader = new CSVReader(filereader);) {
			String[] keys = reader.readNext();
			String[] values = reader.readNext();
			if (keys.length == values.length) {
				for (int index = 0; index < keys.length; index++) {
					map.put(keys[index], values[index]);
				}
			}

		} catch (Exception e) {
			System.out.println(e);
		}
		return map;
	}

	public static ArrayList<String> getKeys(Map<String, String> map) {
		return new ArrayList<String>(map.keySet());

	}

	public static ArrayList<String> getValues(Map<String, String> map) {
		return new ArrayList<String>(map.values());

	}

	public static String getLatestFile(String path) {
		File chosenFile = null;
		try {
			File directory = new File(path);
			File[] files = directory.listFiles(File::isFile);
			long lastModifiedTime = Long.MIN_VALUE;

			if (files != null) {
				for (File file : files) {
					if (file.lastModified() > lastModifiedTime) {
						chosenFile = file;
						lastModifiedTime = file.lastModified();
					}
				}
			}

		} catch (Exception e) {
			System.out.println(e);
		}
		return chosenFile.getName();

	}

	public static void cleanUpDirectory(String path) {
		File dir = new File(path);
		for (File file : dir.listFiles()) {
			if (file.isDirectory())
				cleanUpDirectory();
			file.delete();
		}
		System.out.format("\n---Clean Up Completed---\n");
	}

	public static boolean verifyDateTimeFormat(String dateStr, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		sdf.setLenient(false);
		try {
			sdf.parse(dateStr);
		} catch (ParseException e) {
			return false;
		}
		return true;
	}

	public static Map<String, String> readCSVasMap(String path, String fileName) {
		try {
			path = readProperty(path) + fileName;
		} catch (Exception e) {
			System.out.println(e);
		}
		Map<String, String> map = new HashMap<>();
		try (FileReader filereader = new FileReader(path); CSVReader reader = new CSVReader(filereader);) {
			String[] keys = reader.readNext();
			String[] values = reader.readNext();
			if (keys.length == values.length) {
				for (int index = 0; index < keys.length; index++) {
					map.put(keys[index], values[index]);
				}
			}

		} catch (Exception e) {
			System.out.println(e);
		}
		return map;
	}

	public static String changeDateFormat(String Inputdate, String iDateFormat, String requiredDateFormat) {
		SimpleDateFormat inputDateFormat = new SimpleDateFormat(iDateFormat);
		String date = "";
		try {
			Date tempDate;
			tempDate = inputDateFormat.parse(Inputdate);
			SimpleDateFormat outputFORMAT = new SimpleDateFormat(requiredDateFormat);
			date = outputFORMAT.format(tempDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	public static String dateFormat(String requiredDateFormat) {
		Date date = Calendar.getInstance().getTime();
		DateFormat dateFormat = new SimpleDateFormat(requiredDateFormat);
		String strDate = dateFormat.format(date);
		return strDate;

	}

	public static String removeLeadingZeros(String str) {
		String regex = "^0+(?!$)";
		str = str.replaceAll(regex, "");
		str = str.replaceAll("/0", "/");
		return str;
	}

	public static String readQueryOutput() throws Exception {
		String queryOutput = "";
		queryOutput = new String(Files.readAllBytes(Paths.get(folderPath + "\\queryoutput.txt")));
		return queryOutput;
	}

	public static void getRandomCustomerID() {
		hmap.put("IndividualID", "" + (int) (Math.random() * (1000000 - 10000)));
		hmap.put("IndividualAccountNumber", "" + (int) (Math.random() * (1000000 - 10000)));
		hmap.put("BusinessID", "" + (int) (Math.random() * (1000000 - 10000)));
		hmap.put("BusinessAccountNumber", "" + (int) (Math.random() * (1000000 - 10000)));
	}

	public static String getRandomAlphanumericString(int length) {
		StringBuilder builder = new StringBuilder();
		while (length-- != 0) {
			int character = (int) (Math.random() * ALPHA_NUMERIC_STRING.length());
			builder.append(ALPHA_NUMERIC_STRING.charAt(character));
		}
		return builder.toString();
	}

	public static List<String> getAllCustomerIDfromCSV(String fileName, String ColumnID) {
		List<String> ar = new ArrayList<String>();
		String path = System.getProperty("user.dir") + "\\DataIntakeInput\\" + fileName;
		try (BufferedReader br = new BufferedReader(new FileReader(path));
				CSVParser parser = CSVFormat.DEFAULT.withDelimiter(',').withHeader().parse(br);) {
			for (CSVRecord record : parser) {
				String colNum = record.get(ColumnID);
				ar.add(colNum);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return ar;
	}

}
