package com.inventario.imobilizado.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "anexos")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id_anexos")
public class Attachment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_anexos")
    private int id_anexos;

    @Column(name = "nome")
    private String nome;

    @Column(name = "descricao")
    private String descricao;

    @Column(name = "anexo")
    private String anexo;

    @ManyToOne
    @JoinColumn(name = "Item_id_item")
    private Item item;

}
