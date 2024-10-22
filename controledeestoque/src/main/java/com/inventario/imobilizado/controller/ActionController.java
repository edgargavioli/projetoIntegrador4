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

    @PostMapping("/emprestarItens")
    public ResponseEntity<?> postActionList(@RequestBody List<ActionRequest> data) {

        for (ActionRequest actionRequest : data) {
            Action action = new Action();
            action.setEntidade(actionRequest.getEntidade());

            // Setar data_emprestimo e data_devolucao diretamente como String
            action.setData_emprestimo(actionRequest.getData_emprestimo());
            action.setData_devolucao(actionRequest.getData_devolucao());

            // Verificar se o usuário está presente
            action.setUsuario(userInterface.findById(actionRequest.getId_usuario())
                    .orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado")));

            // Verificar se o item está presente
            action.setItem(itemInterface.findById(actionRequest.getId_item())
                    .orElseThrow(() -> new IllegalArgumentException("Item não encontrado")));

            // Verificar se o anexo está presente
            action.setAnexos(attachmentInterface.findById(actionRequest.getId_anexos())
                    .orElseThrow(() -> new IllegalArgumentException("Anexo não encontrado")));

            action.setEmprestante(emprestanteInterface.findByNumIdentificacao(actionRequest.getNum_identificacao_emprestante()));
            action.getItem().setEstado(actionRequest.getEstado());
            action.setLocalizacao_id_localizacao(actionRequest.getId_localizacao_atual());
            actionInterface.save(action);
        }

        return ResponseEntity.ok("Itens emprestados com sucesso");
    }



    @GetMapping("/")
    public ResponseEntity<List<Action>> GetAll(){
        List<Action> AllItems = actionInterface.findAll();

        return ResponseEntity.ok(AllItems);
    }



}
