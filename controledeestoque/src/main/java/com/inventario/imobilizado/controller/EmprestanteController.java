package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.model.Emprestante;
import com.inventario.imobilizado.model.User;
import com.inventario.imobilizado.repository.EmprestanteInterface;
import com.inventario.imobilizado.repository.UserInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/emprestantes")
public class EmprestanteController {
    @Autowired
    private EmprestanteInterface emprestanteInterface;

    @GetMapping("/")
    public List<Emprestante> getAllEmprestantes() {
        return emprestanteInterface.findAll();
    }

    @GetMapping("/paged")
    public Page<Emprestante> PagedUser(Integer page, Integer pageSize, EmprestanteInterface emprestanteInterface, String order) {
        // http://localhost:8080/page/Emprestantes?order=nome
        if (order.equals("nome")){
            Page<Emprestante> emprestantes = emprestanteInterface.findAll(PageRequest.of(page,pageSize, Sort.by("nome")));
            return emprestantes;
        }
        // http://localhost:8080/page/Emprestatnes?order=sobrenome
        if (order.equals("num_identificacao")){
            Page<Emprestante> emprestantes = emprestanteInterface.findAll(PageRequest.of(page,pageSize, Sort.by("num_identificacao")));
            return emprestantes;
        }
        else {
            Page<Emprestante> emprestantes = emprestanteInterface.findAll(PageRequest.of(page, pageSize));
            return emprestantes;
        }
    }

    @PostMapping("/")
    public Emprestante createEmprestante(@RequestBody Emprestante emprestante) {
        Emprestante existingEmprestante = emprestanteInterface.findByNumIdentificacao(emprestante.getNum_identificacao());
        if (existingEmprestante != null) {
            throw new IllegalArgumentException("Emprestante com essa identificação já existe");
        }

        return emprestanteInterface.save(emprestante);
    }

    @PutMapping("/edit/{id}")
    public Emprestante updateEmprestante(@PathVariable("id") Integer id, @RequestBody Emprestante emprestante) {
        Emprestante editEmprestante = emprestanteInterface.findById(id).orElse(null);

        if (editEmprestante == null) {
            throw new IllegalArgumentException("Emprestante não encontrado");
        }

        editEmprestante.setNome(emprestante.getNome());
        editEmprestante.setNum_identificacao(emprestante.getNum_identificacao());

        Emprestante existingEmprestante = emprestanteInterface.findByNumIdentificacao(editEmprestante.getNum_identificacao());

        if (existingEmprestante != null && !Integer.valueOf(existingEmprestante.getId_emprestante()).equals(id)) {
            throw new IllegalArgumentException("Emprestante com essa identificação já existe");
        }        

        return emprestanteInterface.save(editEmprestante);
    }

    @DeleteMapping("/{id}")
    public void deleteEmprestante(@PathVariable("id") Integer id) {
        if (!emprestanteInterface.existsById(id)) {
            throw new IllegalArgumentException("Emprestante não encontrado");
        }

        emprestanteInterface.deleteById(id);
    }
}
