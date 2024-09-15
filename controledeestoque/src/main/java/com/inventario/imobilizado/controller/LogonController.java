package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.repository.UserInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.inventario.imobilizado.model.User;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
public class LogonController {

    @Autowired
    private UserInterface userInterface;

    @PostMapping("/logon")
    public ModelAndView logonSubmit(
            @ModelAttribute("user") User user,
            @RequestParam("confirmar-senha") String confirmarSenha,
            Model model)
    {
        ModelAndView modelAndView = new ModelAndView();
        List<User> allUsers =  userInterface.findAll();
        if (user.getNome() != null && user.getSobrenome() != null
                && user.getTipo_usuario() != null && user.getEmail() != null) {
            User usuarioBanco = userInterface.findByEmail(user.getEmail());
            if (usuarioBanco != null){
                model.addAttribute("error", "Email já cadastrado.");
                modelAndView.setViewName("logon");

            }
            else {
                if (user.getSenha().equals(confirmarSenha)){
                    if(allUsers.size() == 0) {
                        userInterface.save(user);
                        modelAndView.setViewName("redirect:page/login");
                    }
                    else {
                        if (user.getTipo_usuario().equalsIgnoreCase("Administrador")) {
                            model.addAttribute("error", "Não é permitido criar usuário com tipo 'Administrador'.");
                            modelAndView.setViewName("logon");

                        } else {
                            userInterface.save(user);
                            modelAndView.setViewName("redirect:page/login");
                        }
                    }
                }
                else {
                    model.addAttribute("error", "As senhas não coincidem.");
                    modelAndView.setViewName("logon");
                }
            }
        }
        else {
            modelAndView.setViewName("redirect:page/logon");
        }
        return modelAndView;
    }

}