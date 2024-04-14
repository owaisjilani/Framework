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
26-June-21  */

public class ServiceUtil {

	public static String folderPath = System.getProperty("user.dir");
	public static int REMOTE_PORT = 22;
	public static int SESSION_TIMEOUT = 10000;
	public static int CHANNEL_TIMEOUT = 5000;
	public static Session jschSession = null;

	public static void startDataIntake() throws Exception {
		String environment = FileUtil.readProperty("testEnvironment");

		try {

			JSch jsch = new JSch();
			System.out.format("\n---Data Intake Started---\n");
			jschSession = jsch.getSession(FileUtil.readProperty("hostUsername_" + environment),
					FileUtil.readProperty("remoteHost_" + environment), REMOTE_PORT);
			jschSession.setConfig("StrictHostKeyChecking", "no");
			jsch.addIdentity(folderPath + "\\" + FileUtil.readProperty("hostcertfileName_" + environment));
			jschSession.connect(SESSION_TIMEOUT);
			ChannelExec channelExec = (ChannelExec) jschSession.openChannel("exec");
			channelExec.setCommand("curl -X POST https://172.17.0.1:8087/internal/integration/"
					+ FileUtil.readProperty("tenantID") + "/intake/ -H \"Content-Type: application/json\" --insecure");
			channelExec.setErrStream(System.err);
			InputStream in = channelExec.getInputStream();
			channelExec.connect(CHANNEL_TIMEOUT);
			byte[] tmp = new byte[1024];
			System.out.format("\nOutput:\n");
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

	public static void rulesProcessing() throws Exception {
		String environment = FileUtil.readProperty("testEnvironment");
		try {

			JSch jsch = new JSch();
			System.out.format("\n--Rules Processing Started---\n");
			jschSession = jsch.getSession(FileUtil.readProperty("hostUsername_" + environment),
					FileUtil.readProperty("remoteHost_" + environment), REMOTE_PORT);
			jschSession.setConfig("StrictHostKeyChecking", "no");
			jsch.addIdentity(folderPath + "\\" + FileUtil.readProperty("hostcertfileName_" + environment));
			jschSession.connect(SESSION_TIMEOUT);
			ChannelExec channelExec = (ChannelExec) jschSession.openChannel("exec");
			channelExec.setCommand("curl --location --request POST 'https://172.17.0.1:8093/internal/rules/batch' --insecure --header 'Content-Type: application/json' --data '{ \"tenant\" : \"ceb03599-6a15-4ab9-a87e-82194703c507\" }'");

			channelExec.setErrStream(System.err);
			InputStream in = channelExec.getInputStream();
			channelExec.connect(CHANNEL_TIMEOUT);
			byte[] tmp = new byte[1024];
			System.out.format("\nOutput:\n");
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
}
