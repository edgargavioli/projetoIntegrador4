package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.Brand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BrandInterface extends JpaRepository<Brand, Integer> {
    List<Brand> findAll();

    Brand findByNome(String nome);
}