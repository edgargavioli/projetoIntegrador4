package com.inventario.imobilizado.model;

import jakarta.persistence.*;
import lombok.*;


@Entity
@Table(name = "modelo")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id_model")
public class Model {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_modelo")
    private int id_model;
    private String nome;

    @Override
    public String toString() {
        return nome;
    }

    public void setName(String modelName) {
        this.nome = modelName;
    }

    public Model(String modelName) {
        this.nome = modelName;
    }
}