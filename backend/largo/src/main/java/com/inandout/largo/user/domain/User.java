package com.inandout.largo.user.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@Table(name="app_user")
@Entity
public class User {
    @Id
    @Column(name="user_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(name="user_name", nullable = false)
    private String name;

    @Column
    private String picture;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @Column(nullable = false)
    private boolean agreement;

    @Column(nullable = false)
    private Integer reward;

    @Builder
    public User(String email, String name, String picture, Role role, boolean agreement, Integer reward){
        this.email = email;
        this.name = name;
        this.picture = picture;
        this.role = role;
        this.agreement = agreement;
        this.reward = reward;
    }

    public User update(String name, String picture){
        this.name = name;
        this.picture = picture;

        return this;
    }

    public String getRoleKey(){
        return this.role.getKey();
    }
}
