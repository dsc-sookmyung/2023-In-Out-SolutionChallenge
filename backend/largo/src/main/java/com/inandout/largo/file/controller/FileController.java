package com.inandout.largo.file.controller;

import com.inandout.largo.file.dto.UploadRequestDto;
import com.inandout.largo.file.service.FileService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

import static org.springframework.http.MediaType.MULTIPART_FORM_DATA_VALUE;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/files")
public class FileController {
    private final FileService fileService;

    @PostMapping
    public ResponseEntity<?> uploadFile(@RequestBody UploadRequestDto requestDto){
        return ResponseEntity.ok(fileService.uploadFile(requestDto));
    }


    @PostMapping(consumes = MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> uploadFile(@RequestPart MultipartFile file, HttpServletRequest request) throws IOException {
        return ResponseEntity.ok(fileService.uploadFile(file, request.getParameter("path")));
    }
}
