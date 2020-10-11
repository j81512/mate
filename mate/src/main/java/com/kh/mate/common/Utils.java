package com.kh.mate.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Utils {

	public static String getRenamedFileName(String originalFilename) {
		String renamedFilename = null;
		
		//확장자 처리
		int beginIndex = originalFilename.lastIndexOf('.');
		String ext = originalFilename.substring(beginIndex); // .png ....
		
		//년월일 포맷, 난수 포맷
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000");
		
		renamedFilename = sdf.format(new Date())
						+ df.format(Math.random() * 1000 )
						+ ext;
		
		return renamedFilename;
	}

	//파일 복사
	public static void fileCopy(File temp, File img) {
		File[] target_file = temp.listFiles();
		for(File file : target_file) {
			File t = new File(temp.getAbsolutePath() + File.separator + file.getName());
			if(file.isDirectory()) {
				t.mkdir();
				fileCopy(file, t);
			}
			else {
				FileInputStream fis = null;
				FileOutputStream fos = null;
				try {
					byte[] b = new byte[4096];
					int cnt = 0;
					while((cnt = fis.read(b)) != -1) {
						fos.write(b, 0, cnt);
					
					}
					
				} catch(Exception e) {
					e.printStackTrace();
				} finally {
					try {
						fis.close();
						fos.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			
		}
	}
	
	//파일 삭제
	public static void fileDelete(String path) {
		File folder = new File(path);
		try {
			if(folder.exists()) {
				File[] folder_list = folder.listFiles();
				
				for(int i=0; i < folder_list.length; i++) {
					if(folder_list[i].isFile()) {
						folder_list[i].delete();
					}else {
						fileDelete(folder_list[i].getPath());
					}
					folder_list[i].delete();
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
