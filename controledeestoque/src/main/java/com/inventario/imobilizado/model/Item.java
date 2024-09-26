package com.inventario.imobilizado.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;


@Entity
@Table(name = "item")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id_item")
public class Item {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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

    @ManyToOne
    @JoinColumn(name = "categoria_id_categoria")
    private Category categoria;

    @Column(name = "status_item")
    private String status;

    @ManyToOne
    @JoinColumn(name = "modelo_id_modelo")
    private Modelo modelo;

    @ManyToOne
    @JoinColumn(name = "localizacao_id_localizacao")
    private Location localizacao;

}
