package com.inventario.imobilizado.model;

import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode(of = "id_item")
public class RequestItem {

        private Integer id_item;

        private String descricao;

        private Integer potencia;

        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private Date data_entrada;

        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private Date data_nota_fiscal;

        private String localizacao_atual;

        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private Date ultima_qualificacao;

        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private Date proxima_qualificacao;

        private Integer estado;

        private Integer categoria;

        private Integer status;

        private String numero_de_serie;

        private Integer modelo;
        
        private Integer marca;

        private Integer localizacao;

        private String numero_nota_fiscal;

        private String comentario_manutencao;

        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private Date prazo_manutencao;
}