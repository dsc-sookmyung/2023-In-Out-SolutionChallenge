package com.inandout.largo.auth.security;

import com.inandout.largo.auth.jwt.JwtTokenProvider;
import com.inandout.largo.user.domain.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Component
public class CustomOAuth2SuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
    private final JwtTokenProvider jwtTokenProvider;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
        Map<String,Object> attributes = oAuth2User.getAttributes();

        String token = jwtTokenProvider.createToken(attributes.get("email").toString(), Role.USER);
        String targetUrl = "/login?token=" + token;
        getRedirectStrategy().sendRedirect(request, response, targetUrl);

        log.info("created token {}", token);
        log.info("targetUrl {}", targetUrl);
    }
}
