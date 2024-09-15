package com.inventario.imobilizado.model;


import jakarta.persistence.*;
import lombok.*;


@Entity
@Table(name = "status")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id_status")
public class Status {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_status")
    private int id_status;
    private String nome;

    @Override
    public String toString() {
        return nome;
    }

    public void setName(String statusName) {
        this.nome = statusName;
    }

    public Status (String statusName) {
        this.nome = statusName;
    }
}