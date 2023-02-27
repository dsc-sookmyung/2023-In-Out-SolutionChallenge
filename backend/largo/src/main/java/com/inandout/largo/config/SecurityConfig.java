package com.inandout.largo.config;

import com.inandout.largo.auth.jwt.JwtAuthenticationFilter;
import com.inandout.largo.auth.jwt.JwtTokenProvider;
import com.inandout.largo.auth.security.CustomOAuth2SuccessHandler;
import com.inandout.largo.auth.service.CustomOAuth2UserService;
import com.inandout.largo.user.domain.Role;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.logout.LogoutFilter;

@Configuration
@RequiredArgsConstructor
@EnableWebSecurity
public class SecurityConfig {
    private final CustomOAuth2UserService customOAuth2UserService;
    private final CustomOAuth2SuccessHandler customOAuth2SuccessHandler;
    private final JwtTokenProvider jwtTokenProvider;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf().disable()
                .formLogin().disable()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                    .authorizeHttpRequests()
                    .requestMatchers("/", "/css/**", "/images/**", "/js/**").permitAll()
                    .requestMatchers("/api/v1/**").hasRole(Role.USER.name())
                    .anyRequest().authenticated()
                .and()
                    .logout()
                        .logoutSuccessUrl("/")
                .and()
                    .addFilterAfter(new JwtAuthenticationFilter(jwtTokenProvider), LogoutFilter.class)
                    .oauth2Login()
                        .successHandler(customOAuth2SuccessHandler)
                        .userInfoEndpoint()
                            .userService(customOAuth2UserService);

        return http.build();
    }
}
