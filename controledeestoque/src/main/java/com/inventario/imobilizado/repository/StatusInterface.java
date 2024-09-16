package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.Status;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StatusInterface extends JpaRepository<Status,Integer> {
    List<Status> findAll();

    Status findByNome(String nome);
}
