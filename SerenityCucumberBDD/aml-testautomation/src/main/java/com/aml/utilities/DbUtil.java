package com.aml.utilities;

import java.io.IOException;
import java.io.InputStream;

import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

/*
@Author 
owais Jilani
27-June-21  */

public class DbUtil extends FileUtil {

	public static String folderPath = System.getProperty("user.dir");
	public static int REMOTE_PORT = 22;
	public static int SESSION_TIMEOUT = 10000;
	public static int CHANNEL_TIMEOUT = 5000;
	public static Session jschSession = null;

	public static void setStorageConfig() throws Exception {
		String environment = FileUtil.readProperty("testEnvironment");

		try {

			JSch jsch = new JSch();
			jschSession = jsch.getSession(FileUtil.readProperty("hostUsername_" + environment),
					FileUtil.readProperty("remoteHost_" + environment), REMOTE_PORT);

			jschSession.setConfig("StrictHostKeyChecking", "no");
			jsch.addIdentity(folderPath + "\\" + FileUtil.readProperty("hostcertfileName_" + environment));
			jschSession.connect(SESSION_TIMEOUT);
			ChannelExec channelExec = (ChannelExec) jschSession.openChannel("exec");
			System.out.format("\n---Setting Storage Config---\n");
			channelExec.setCommand(
					"docker cp setStorageConfig.js mongodb:/tmp && docker exec -t mongodb /bin/bash -c \"mongo db1 -u admin -p#serenity1234 --host mongodb:27017 --sslAllowInvalidHostnames --authenticationDatabase admin --ssl --sslCAFile /certs/mongodb-ca.crt --sslPEMKeyFile /certs/mongodb-client.pem< /tmp/setStorageConfig.js\"");
			channelExec.setErrStream(System.err);
			InputStream in = channelExec.getInputStream();
			channelExec.connect(CHANNEL_TIMEOUT);
			byte[] tmp = new byte[1024];
			while (true) {
				while (in.available() > 0) {
					int i = in.read(tmp, 0, 1024);
					if (i < 0)
						break;
					System.out.print(new String(tmp, 0, i));

				}
				if (channelExec.isClosed()) {
					if (in.available() > 0)
						continue;
					System.out.println("exit-status: " + channelExec.getExitStatus());
					break;
				}
				try {
					Thread.sleep(1000);
				} catch (Exception ee) {
				}
			}
			channelExec.disconnect();

		} catch (JSchException | IOException e) {

			e.printStackTrace();

		} finally {
			if (jschSession != null) {
				jschSession.disconnect();
			}
		}
	}

	public static void connectPostgresDB(String filename) throws Exception {
		String environment = FileUtil.readProperty("testEnvironment");
		String tenantID = FileUtil.readProperty("tenantID");
		try {

			JSch jsch = new JSch();
			jschSession = jsch.getSession(FileUtil.readProperty("hostUsername_" + environment),
					FileUtil.readProperty("remoteHost_" + environment), REMOTE_PORT);

			jschSession.setConfig("StrictHostKeyChecking", "no");
			jsch.addIdentity(folderPath + "\\" + FileUtil.readProperty("hostcertfileName_" + environment));
			jschSession.connect(SESSION_TIMEOUT);
			ChannelExec channelExec = (ChannelExec) jschSession.openChannel("exec");
			/*
			 * To be used for manual execution88
			 */
			/*
			 * channelExec.setCommand(
			 * "PGPASSWORD=#serenity1234 psql -h 172.17.0.1 -U admin -d db_ceb03599-6a15-4ab9-a87e-82194703c507 -c 'select employer,sic_code,soc_code from public.customer limit 5'"
			 * );
			 */
			channelExec.setCommand(
					"PGPASSWORD=#serenity1234 psql -h 172.17.0.1 -U admin -d db_"+tenantID+" < ./"
							+ filename);

			channelExec.setErrStream(System.err);
			InputStream in = channelExec.getInputStream();
			channelExec.connect(CHANNEL_TIMEOUT);
			byte[] tmp = new byte[1024];
			while (true) {
				while (in.available() > 0) {
					int i = in.read(tmp, 0, 1024);
					saveToFile(new String(tmp, 0, 1024), folderPath + "\\queryoutput.txt");
					if (i < 0)
						break;
					System.out.print(new String(tmp, 0, i));

				}
				if (channelExec.isClosed()) {
					if (in.available() > 0)
						continue;
					System.out.println("exit-status: " + channelExec.getExitStatus());
					break;
				}
				try {
					Thread.sleep(1000);
				} catch (Exception ee) {
				}
			}

			channelExec.disconnect();

		} catch (JSchException | IOException e) {

			e.printStackTrace();

		} finally {
			if (jschSession != null) {
				jschSession.disconnect();
			}
		}
	}

	public static void disableSanctionsFeature() throws Exception {
		String environment = FileUtil.readProperty("testEnvironment");

		try {

			JSch jsch = new JSch();
			jschSession = jsch.getSession(FileUtil.readProperty("hostUsername_" + environment),
					FileUtil.readProperty("remoteHost_" + environment), REMOTE_PORT);

			jschSession.setConfig("StrictHostKeyChecking", "no");
			jsch.addIdentity(folderPath + "\\" + FileUtil.readProperty("hostcertfileName_" + environment));
			jschSession.connect(SESSION_TIMEOUT);
			ChannelExec channelExec = (ChannelExec) jschSession.openChannel("exec");
			System.out.format("\n---Setting Storage Config---\n");
			channelExec.setCommand(
					"docker cp disableSanctionsFeature.js mongodb:/tmp && docker exec -t mongodb /bin/bash -c \"mongo db1 -u admin -p#serenity1234 --host mongodb:27017 --sslAllowInvalidHostnames --authenticationDatabase admin --ssl --sslCAFile /certs/mongodb-ca.crt --sslPEMKeyFile /certs/mongodb-client.pem< /tmp/disableSanctionsFeature.js\"");
			channelExec.setErrStream(System.err);
			InputStream in = channelExec.getInputStream();
			channelExec.connect(CHANNEL_TIMEOUT);
			byte[] tmp = new byte[1024];
			while (true) {
				while (in.available() > 0) {
					int i = in.read(tmp, 0, 1024);
					saveToFile(new String(tmp, 0, 1024), folderPath + "\\queryoutput.txt");
					if (i < 0)
						break;
					System.out.print(new String(tmp, 0, i));

				}
				if (channelExec.isClosed()) {
					if (in.available() > 0)
						continue;
					System.out.println("exit-status: " + channelExec.getExitStatus());
					break;
				}
				try {
					Thread.sleep(1000);
				} catch (Exception ee) {
				}
			}
			channelExec.disconnect();

		} catch (JSchException | IOException e) {

			e.printStackTrace();

		} finally {
			if (jschSession != null) {
				jschSession.disconnect();
			}
		}
	}

	public static void enableSanctionsFeature() throws Exception {
		String environment = FileUtil.readProperty("testEnvironment");

		try {

			JSch jsch = new JSch();
			jschSession = jsch.getSession(FileUtil.readProperty("hostUsername_" + environment),
					FileUtil.readProperty("remoteHost_" + environment), REMOTE_PORT);

			jschSession.setConfig("StrictHostKeyChecking", "no");
			jsch.addIdentity(folderPath + "\\" + FileUtil.readProperty("hostcertfileName_" + environment));
			jschSession.connect(SESSION_TIMEOUT);
			ChannelExec channelExec = (ChannelExec) jschSession.openChannel("exec");
			System.out.format("\n---Setting Storage Config---\n");
			channelExec.setCommand(
					"docker cp enableSanctionsFeature.js mongodb:/tmp && docker exec -t mongodb /bin/bash -c \"mongo db1 -u admin -p#serenity1234 --host mongodb:27017 --sslAllowInvalidHostnames --authenticationDatabase admin --ssl --sslCAFile /certs/mongodb-ca.crt --sslPEMKeyFile /certs/mongodb-client.pem< /tmp/enableSanctionsFeature.js\"");
			channelExec.setErrStream(System.err);
			InputStream in = channelExec.getInputStream();
			channelExec.connect(CHANNEL_TIMEOUT);
			byte[] tmp = new byte[1024];
			while (true) {
				while (in.available() > 0) {
					int i = in.read(tmp, 0, 1024);
					saveToFile(new String(tmp, 0, 1024), folderPath + "\\queryoutput.txt");
					if (i < 0)
						break;
					System.out.print(new String(tmp, 0, i));

				}
				if (channelExec.isClosed()) {
					if (in.available() > 0)
						continue;
					System.out.println("exit-status: " + channelExec.getExitStatus());
					break;
				}
				try {
					Thread.sleep(1000);
				} catch (Exception ee) {
				}
			}
			channelExec.disconnect();

		} catch (JSchException | IOException e) {

			e.printStackTrace();

		} finally {
			if (jschSession != null) {
				jschSession.disconnect();
			}
		}
	}

	public static void disableRules(String[] args) throws Exception
	{		
		String environment = FileUtil.readProperty("testEnvironment");
		try 
		{
			JSch jsch = new JSch();
			jschSession = jsch.getSession(FileUtil.readProperty("hostUsername_" + environment),FileUtil.readProperty("remoteHost_" + environment), REMOTE_PORT);
			jschSession.setConfig("StrictHostKeyChecking", "no");
			jsch.addIdentity(folderPath + "\\" + FileUtil.readProperty("hostcertfileName_" + environment));
			jschSession.connect(SESSION_TIMEOUT);
			
			ChannelExec channelExec = (ChannelExec) jschSession.openChannel("exec");			
			channelExec.setCommand("PGPASSWORD=#serenity1234 psql -h 172.17.0.1 -U admin -d db_ceb03599-6a15-4ab9-a87e-82194703c507 -c 'update rule set active=false where deleted=false'");						
			channelExec.connect(CHANNEL_TIMEOUT);	
			System.out.println("Rules got disabled successfully");
			channelExec.disconnect();		
		} 
		catch (JSchException | IOException e) 
		{
			e.printStackTrace();
		} 
		finally 
		{
			if (jschSession != null) 
			{
				jschSession.disconnect();
			}
		}				
	}
	
	public static void deleteEntriesForRuleProcessing() throws Exception
	{		
		String environment = FileUtil.readProperty("testEnvironment");
		try 
		{
			JSch jsch = new JSch();
			jschSession = jsch.getSession(FileUtil.readProperty("hostUsername_" + environment),FileUtil.readProperty("remoteHost_" + environment), REMOTE_PORT);
			jschSession.setConfig("StrictHostKeyChecking", "no");
			jsch.addIdentity(folderPath + "\\" + FileUtil.readProperty("hostcertfileName_" + environment));
			jschSession.connect(SESSION_TIMEOUT);
			
			ChannelExec channelExec = (ChannelExec) jschSession.openChannel("exec");			
			channelExec.setCommand("PGPASSWORD=#serenity1234 psql -h 172.17.0.1 -U admin -d db_ceb03599-6a15-4ab9-a87e-82194703c507 -c 'delete from alert_incident delete from incident delete from condition_run delete from alert'");						
			channelExec.connect(CHANNEL_TIMEOUT);	
			System.out.println("Rules got disabled successfully");
			channelExec.disconnect();		
		} 
		catch (JSchException | IOException e) 
		{
			e.printStackTrace();
		} 
		finally 
		{
			if (jschSession != null) 
			{
				jschSession.disconnect();
			}
		}				
	}
	
}
