package com.inventario.imobilizado.model;


import jakarta.persistence.*;
import lombok.*;


@Entity
@Table(name = "estado")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id_estado")
public class State {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_estado")
    private int id_estado;
    private String nome;

    @Override
    public String toString() {
        return nome;
    }

    public void setName(String stateName) {
        this.nome = stateName;
    }

    public State(String nome) {
        this.nome = nome;
    }
}