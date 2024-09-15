package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.State;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StateInterface extends JpaRepository<State,Integer> {
    List<State> findAll();

    State findByNome(String nome);
}
