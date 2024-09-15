package com.inventario.imobilizado.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
    public class AttachmentRequest {

    private int id_anexos;

    private String nome;

    private String descricao;

    private String anexo;

    private int id_item;
}
