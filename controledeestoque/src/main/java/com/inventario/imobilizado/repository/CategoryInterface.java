package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryInterface extends JpaRepository<Category, Integer> {
    List<Category> findAll();

    Category findByNome(String nome);
}