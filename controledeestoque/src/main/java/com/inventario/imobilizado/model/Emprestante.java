package com.inventario.imobilizado.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.Objects;

@Entity
@Table(name = "emprestante")
@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode(of = "id_emprestante")
public class Emprestante {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_emprestante")
    private int id_emprestante;
    @Column(name = "num_identificacao")
    private String num_identificacao;
    @Column(name = "nome")
    private String nome;
    @Column(name = "status_emprestante")
    private String status_emprestante;

    public Emprestante(String num_identificacao, String nome, String status_emprestante) {
        this.num_identificacao = num_identificacao;
        this.nome = nome;
        this.status_emprestante = status_emprestante;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Emprestante that = (Emprestante) o;
        return id_emprestante == that.id_emprestante && num_identificacao == that.num_identificacao && Objects.equals(nome, that.nome) && Objects.equals(status_emprestante, that.status_emprestante);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id_emprestante, num_identificacao, nome, status_emprestante);
    }
}
