package com.inventario.imobilizado.model;

import jakarta.persistence.*;
import lombok.*;


@Entity
@Table(name = "localizacao")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id_localizacao")
public class Location {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_localizacao")
    private int id_localizacao;
    private String nome;

    @Override
    public String toString() {
        return nome;
    }

    public void setName(String locationName) {
        this.nome = locationName;
    }

    public Location(String locationName) {
        this.nome = locationName;
    }
}
