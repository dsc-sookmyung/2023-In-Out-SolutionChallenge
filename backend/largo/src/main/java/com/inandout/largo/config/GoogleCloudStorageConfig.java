package com.inandout.largo.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.FileInputStream;
import java.io.IOException;
import java.security.GeneralSecurityException;

@Configuration
public class GoogleCloudStorageConfig {
    @Value("${spring.cloud.gcp.storage.project-id}")
    private String projectId;

    @Value("${spring.cloud.gcp.storage.credentials.location}")
    private String credentialsLocation;

    @Bean
    Storage configStorageClient() throws GeneralSecurityException, IOException {
        Storage storage = StorageOptions.newBuilder()
                .setProjectId(projectId)
                .setCredentials(GoogleCredentials.fromStream(new FileInputStream(credentialsLocation)))
                .build()
                .getService();

        return storage;
    }
}
