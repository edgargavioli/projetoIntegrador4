package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.model.Status;
import com.inventario.imobilizado.repository.StatusInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class StatusController {

    @Autowired
    private StatusInterface statusInterface;

    @GetMapping("/status")
    public List<Status> getAllStatus() {
        return statusInterface.findAll();
    }

}
