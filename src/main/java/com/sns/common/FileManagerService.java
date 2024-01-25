package com.sns.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class FileManagerService {
	public static final String FILE_UPLOAD_PATH = "D:\\sohuiham\\6_spring_project\\SNS\\sns_workspace\\images/";
//	public static final String FILE_UPLOAD_PATH = "/Users/sohuiham/sns/sns_workspace/images/"; // 노트북

	public String saveFile(String loginId, MultipartFile file) {
		String directoryName = loginId + "_" + System.currentTimeMillis();
		String filePath = FILE_UPLOAD_PATH + directoryName;

		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;
		}

		try {
			byte[] bytes = file.getBytes();
			// ★★★★★ 한글 이름 이미지는 올릴 수 없으므로 나중에 영문자로 바꿔서 올리기
			Path path = Paths.get(filePath + "/" + file.getOriginalFilename());
			Files.write(path, bytes);
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}

		return "/images/" + directoryName + "/" + file.getOriginalFilename();
	}

	public void deleteFile(String imagePath) {
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));

		if (Files.exists(path)) {
			try {
				Files.delete(path);
			} catch (IOException e) {
				log.info("[파일매니저 삭제] 이미지 삭제 실패. path:{}", path.toString());
				return;
			}

			path = path.getParent();
			if (Files.exists(path)) {
				try {
					Files.delete(path);
				} catch (IOException e) {
					log.info("[파일매니저 삭제] 폴더 삭제 실패. path:{}", path.toString());
				}
			}
		}
	}
}
