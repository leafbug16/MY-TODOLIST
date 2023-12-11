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
		System.out.println("upload 컨트롤러");
		System.out.println(upload);
		String uploadFolder = "C:/ckUpload";
		 
		for (MultipartFile multipartFile : upload) { // 여러개의 파일일 경우 향상된 for문 이용

			System.out.println("------------------------");
			System.out.println("Upload file name : " + multipartFile.getOriginalFilename()); // 파일 이름
			System.out.println("Upload file size : " + multipartFile.getSize()); // 파일 크기

			String uploadFileName = multipartFile.getOriginalFilename(); 
			System.out.println("uplodaFileName : "+uploadFileName);
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1); // 경로가 있다면 원래 이름만 가져올 수 있도록
			System.out.println("last file name : " + uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString()+"_"+uploadFileName;
			System.out.println("변환 후 파일이름 "+uploadFileName);
			
			File saveFile = new File(uploadFolder, uploadFileName); //uploadFolder 위치에 uploadFileName으로 생성
			JsonObject json = new JsonObject();
			// Json 객체를 출력하기 위해 PrintWriter 생성
			PrintWriter printWriter = null;
			OutputStream out = null;
			try {
				multipartFile.transferTo(saveFile); // 스프링에서 제공하는 파일 객체를 자바 파일 객체로 변환
				printWriter = resp.getWriter();
				resp.setContentType("application/json;charset=utf-8");
				
				//파일이 연결되는 Url 주소 설정
				String fileUrl = uploadFolder + uploadFileName;
				
				//생성된 jason 객체를 이용해 파일 업로드 + 이름 + 주소를 CkEditor에 전송
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
