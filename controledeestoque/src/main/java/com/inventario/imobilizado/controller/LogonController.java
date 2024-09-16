package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.dto.LogonDTO;
import com.inventario.imobilizado.repository.UserInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.inventario.imobilizado.model.User;

@RestController
public class LogonController {

    @Autowired
    private UserInterface userInterface;

    @PostMapping("/logon")
    public ResponseEntity<?> userLogon(@RequestBody LogonDTO user){
        User usuarioBanco = userInterface.findByEmail(user.getEmail());

        if (usuarioBanco == null) {
            if (user.getSenha().equals(user.getConfirmar_senha())) {
                User usuario = new User();
                usuario.setNome(user.getNome());
                usuario.setSobrenome(user.getSobrenome());
                usuario.setEmail(user.getEmail());
                usuario.setTipo_usuario(user.getTipo_usuario());
                usuario.setSenha(user.getSenha());
                userInterface.save(usuario);

                return ResponseEntity.ok().body("Usuário cadastrado com sucesso.");
            }
            else {
                return ResponseEntity.badRequest().body("As senhas não coincidem.");
            }
        }
        else {
            return ResponseEntity.badRequest().body("Email já cadastrado.");
        }
    }

}