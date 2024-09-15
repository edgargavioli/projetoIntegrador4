package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.Model;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ModelInterface extends JpaRepository<Model, Integer> {
    List<Model> findAll();

    Model findByNome(String nome);
}