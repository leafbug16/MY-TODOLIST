package com.leafbug.todolist.controller;

import java.io.File;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

@Controller
public class UploadController {
	@ResponseBody
	@PostMapping("/upload")
	public String uploadAjaxPost( MultipartFile[] upload, HttpServletResponse resp, HttpServletRequest req) {
		System.out.println("upload ��Ʈ�ѷ�");
		System.out.println(upload);
		String uploadFolder = "C:/ckUpload";
		 
		for (MultipartFile multipartFile : upload) { // �������� ������ ��� ���� for�� �̿�

			System.out.println("------------------------");
			System.out.println("Upload file name : " + multipartFile.getOriginalFilename()); // ���� �̸�
			System.out.println("Upload file size : " + multipartFile.getSize()); // ���� ũ��

			String uploadFileName = multipartFile.getOriginalFilename(); 
			System.out.println("uplodaFileName : "+uploadFileName);
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1); // ��ΰ� �ִٸ� ���� �̸��� ������ �� �ֵ���
			System.out.println("last file name : " + uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString()+"_"+uploadFileName;
			System.out.println("��ȯ �� �����̸� "+uploadFileName);
			
			File saveFile = new File(uploadFolder, uploadFileName); //uploadFolder ��ġ�� uploadFileName���� ����
			JsonObject json = new JsonObject();
			// Json ��ü�� ����ϱ� ���� PrintWriter ����
			PrintWriter printWriter = null;
			OutputStream out = null;
			try {
				multipartFile.transferTo(saveFile); // ���������� �����ϴ� ���� ��ü�� �ڹ� ���� ��ü�� ��ȯ
				printWriter = resp.getWriter();
				resp.setContentType("application/json;charset=utf-8");
				
				//������ ����Ǵ� Url �ּ� ����
				String fileUrl = uploadFolder + uploadFileName;
				
				//������ jason ��ü�� �̿��� ���� ���ε� + �̸� + �ּҸ� CkEditor�� ����
				json.addProperty("uploaded", 1);
				json.addProperty("fileName", uploadFileName);
				json.addProperty("url", "/ckUpload/"+uploadFileName);
				printWriter.println(json);
			} catch (Exception e) {
				e.getMessage();
				
			}
		}
		return null;

	} // uploadAjaxPost END
	
}
