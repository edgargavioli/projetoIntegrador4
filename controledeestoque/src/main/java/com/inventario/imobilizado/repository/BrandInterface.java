package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.Brand;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BrandInterface extends JpaRepository<Brand,Integer> {
    Brand findByNome(String name);
}
