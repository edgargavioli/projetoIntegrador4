package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.model.State;
import com.inventario.imobilizado.repository.StateInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class StateController {

    @Autowired
    private StateInterface stateInterface;

    @GetMapping("/state")
    public List<State> getAllState() {
        return stateInterface.findAll();
    }

}
