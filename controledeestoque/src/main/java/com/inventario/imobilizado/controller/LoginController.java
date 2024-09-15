package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.dto.LoginDTO;
import com.inventario.imobilizado.repository.UserInterface;
import com.inventario.imobilizado.utils.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.inventario.imobilizado.model.User;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
public class LoginController {

    @Autowired
    private UserInterface userInterface;
    @Autowired
    private JwtUtils jwtUtils;

    @PostMapping("/login")
    public ResponseEntity<?> userLogin(@RequestBody LoginDTO user){
        User usuarioBanco = userInterface.findByEmail(user.getEmail());

        if (usuarioBanco != null) {
            if (usuarioBanco.getSenha().equals(user.getPassword())) {
                return ResponseEntity.ok().body(jwtUtils.generateToken(usuarioBanco.get(), 3600000));
            }
            else {
                return ResponseEntity.badRequest().body("Senha Incorreta.");
            }
        }
        else {
            return ResponseEntity.badRequest().body("Usuário não encontrado.");
        }
    }
}
