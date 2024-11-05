package com.inventario.imobilizado.dto;

import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.*;

import java.util.Date;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id_item")
public class ItemDTO {
    private Integer id_item;

    private String descricao;

    private String localizacao_atual;

    private Integer potencia;

    private String patrimonio;

    private String numero_de_serie;

    private String numero_nota_fiscal;

    private String comentario_manutencao;

    @Temporal(TemporalType.DATE)
    private Date data_entrada;

    @Temporal(TemporalType.DATE)
    private Date ultima_qualificacao;

    @Temporal(TemporalType.DATE)
    private Date data_nota_fiscal;

    @Temporal(TemporalType.DATE)
    private Date proxima_qualificacao;

    @Temporal(TemporalType.DATE)
    private Date prazo_manutencao;

    private String estado;

    private Integer categoria;

    private String status;

    private Integer modelo;

    private Integer localizacao;
}
