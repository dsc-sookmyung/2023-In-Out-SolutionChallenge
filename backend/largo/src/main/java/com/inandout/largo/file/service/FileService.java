package com.inandout.largo.file.service;

import com.google.cloud.storage.*;
import com.inandout.largo.exception.CustomException;
import com.inandout.largo.exception.ErrorCode;
import com.inandout.largo.file.dto.UploadRequestDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

@Slf4j
@PropertySource("classpath:application.properties")
@RequiredArgsConstructor
@Service
public class FileService {
    @Value("${spring.cloud.gcp.storage.bucket}")
    private String bucketName;

    @Autowired
    private Storage storage;

    @Transactional
    public String uploadFile(UploadRequestDto requestDto){
        return this.create(requestDto.getPath(), new ByteArrayInputStream(requestDto.getFile()));
        /*
        BlobId blobId = BlobId.of(bucketName, requestDto.getPath());
        BlobInfo blobInfo = BlobInfo.newBuilder(blobId)
                .setContentType("image/jpeg")
                .build();
        try {
            storage.create(blobInfo, requestDto.getFile());
            String url = "https://storage.googleapis.com/"+bucketName+"/"+ requestDto.getPath();

            return url;
        } catch (Exception ex) {
            log.error("fail to upload gcs", ex);
            throw new CustomException(ErrorCode.FAIL_TO_UPLOAD);
        }
        */
    }

    @Transactional
    public String uploadFile(MultipartFile file, String path) throws IOException {
        return this.create(path, file.getInputStream());
    }

    public String create(String path, InputStream inputStream){
        try {
            BlobInfo blobInfo = storage.create(BlobInfo.newBuilder(bucketName, path)
                            .setContentType("image/jpeg")
                            .build(),
                    inputStream
            );
            String url = "https://storage.googleapis.com/"+bucketName+"/"+path;

            return url;
        } catch (Exception ex) {
            log.error("fail to upload gcs", ex);
            throw new CustomException(ErrorCode.FAIL_TO_UPLOAD);
        }
    }
}
