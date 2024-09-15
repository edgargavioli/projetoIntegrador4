package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.Location;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LocationInterface extends JpaRepository<Location,Integer> {
    @Query("select l.nome from localizacao l where l.nome = ?1")
    Location findByNome(String nome);
}
