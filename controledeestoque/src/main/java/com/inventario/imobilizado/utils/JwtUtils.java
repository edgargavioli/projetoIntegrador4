package com.inventario.imobilizado.utils;

import com.inventario.imobilizado.model.JwtToken;
import com.inventario.imobilizado.model.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;

@Component
public class JwtUtils {

    private final Key SECRET_KEY = Keys.secretKeyFor(SignatureAlgorithm.HS256);

    // Gera um token JWT com base nos dados do usuário
    public JwtToken generateToken(User user, long expirationMillis) {
        Key key = Keys.hmacShaKeyFor(SECRET_KEY.getEncoded());
        String token = Jwts.builder()
                .setSubject(user.getEmail())
                .setExpiration(new Date(System.currentTimeMillis() + expirationMillis))
                .claim("name", user.getNome())
                .claim("profile", user.getSobrenome())
                .claim("email", user.getEmail())
                .claim("tipo_user", user.getTipo_usuario())
                .claim("id_user", user.getId_usuario())
                .signWith(key)
                .compact();
        return new JwtToken(token, expirationMillis);
    }

    // Verifica e extrai as reivindicações (claims) de um token JWT
    public Claims extractClaims(String token) {
        Key key = Keys.hmacShaKeyFor(SECRET_KEY.getEncoded());
        return Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    // Verifica a validade de um token JWT
    public boolean isValidToken(String token) {
        try {
            Key key = Keys.hmacShaKeyFor(SECRET_KEY.getEncoded());
            Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    // Verifica se um token JWT expirou
    public boolean isTokenExpired(String token) {
        Date expirationDate = extractClaims(token).getExpiration();
        return expirationDate.before(new Date());
    }
}
