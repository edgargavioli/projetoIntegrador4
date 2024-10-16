package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.Emprestante;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface EmprestanteInterface extends JpaRepository<Emprestante, Integer> {
    @Query("SELECT e FROM Emprestante e WHERE e.num_identificacao = ?1")
    Emprestante findByNumIdentificacao(String num_identificacao);
}
