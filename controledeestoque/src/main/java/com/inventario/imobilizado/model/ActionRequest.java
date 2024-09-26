package com.inventario.imobilizado.model;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id_acao")
@ToString
public class ActionRequest {

    private String ra_rna;

    private String entidade;

    private String data_emprestimo;

    private String data_devolucao;

    private int id_usuario;

    private int id_item;

    private int id_localizacao_atual;

    private int id_anexos;

    private boolean status_emprestimo;

    private String estado;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date prazo_manutencao;


}

