package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.model.Action;
import com.inventario.imobilizado.model.ActionRequest;
import com.inventario.imobilizado.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/action")
public class ActionController {


    @Autowired
    private ItemInterface itemInterface;
    @Autowired
    private ActionInterface actionInterface;

    @Autowired
    private CategoryInterface categoryInterface;

    @Autowired
    private LocationInterface locationInterface;

    @Autowired
    private AttachmentInterface attachmentInterface;

    @Autowired
    private UserInterface userInterface;

    @Autowired
    private EmprestanteInterface emprestanteInterface;

    @PostMapping("/")
    public ResponseEntity<Action> postAction(@RequestBody ActionRequest data) {
        Action action = new Action();
        action.setEntidade(data.getEntidade());
//            action.setData_emprestimo(new Date(data.getData_emprestimo()));
//            action.setData_devolucao(new Date(data.getData_devolucao()));
        action.setUsuario(userInterface.findById(data.getId_usuario()).get());
        action.setItem(itemInterface.findById(data.getId_item()).get());
        action.setAnexos(attachmentInterface.findById(data.getId_anexos()).get());
        action.setEmprestante(emprestanteInterface.findByNumIdentificacao(data.getNum_identificacao_emprestante()));
//            action.setLocalizacao(data.getItem().getLocalizacao_atual());
        actionInterface.save(action);

        return ResponseEntity.ok(action);
    }



    @GetMapping("/")
    public ResponseEntity<List<Action>> GetAll(){
        List<Action> AllItems = actionInterface.findAll();

        return ResponseEntity.ok(AllItems);
    }



}
