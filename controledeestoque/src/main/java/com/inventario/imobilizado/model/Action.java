package com.inventario.imobilizado.model;

import jakarta.persistence.*;
import lombok.*;
import java.util.Date;


@Entity
@Table(name = "acao")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id_acao")
public class Action {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_acao")
    private int id_acao;

    private String entidade;

    @Column(name = "ra_rna")
    private String ra_rna;

    @Temporal(TemporalType.DATE)
    private String data_emprestimo;

    @Temporal(TemporalType.DATE)
    private String data_devolucao;

    @ManyToOne
    @JoinColumn(name = "usuario_id_usuario")
    private User usuario;

    @ManyToOne
    @JoinColumn(name = "item_id_item")
    private Item item;

    private int tipo_acao;

    @ManyToOne
    @JoinColumn(name = "anexos_id_anexos")
    private Attachment anexos;

    private int localizacao_id_localizacao;

}
