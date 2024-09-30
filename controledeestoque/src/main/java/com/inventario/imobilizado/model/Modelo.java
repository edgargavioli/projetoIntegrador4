package com.inventario.imobilizado.model;


import jakarta.persistence.*;
import lombok.*;


@Entity
@Table(name = "modelo")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id_modelo")
public class Modelo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_modelo")
    private int id_modelo;
    private String nome;
    @ManyToOne
    @JoinColumn(name = "marca_id_marca")
    private Brand marca;

    @Override
    public String toString() {
        return nome;
    }

    public void setName(String modeloName) {
        this.nome = modeloName;
    }

    public Modelo(String nome, Brand marca) {
        this.nome = nome;
        this.marca = marca;
    }
}