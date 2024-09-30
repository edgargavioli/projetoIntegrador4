package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.Brand;
import com.inventario.imobilizado.model.Modelo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ModeloInterface extends JpaRepository<Modelo,Integer> {
    Modelo findByNomeAndMarca(String name, Brand marca);
    List<Modelo> findByMarca(Brand marca);
}
