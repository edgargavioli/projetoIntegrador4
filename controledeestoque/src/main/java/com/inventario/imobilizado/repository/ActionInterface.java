package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.Action;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ActionInterface extends JpaRepository<Action, Integer>, PagingAndSortingRepository<Action, Integer> {
    @Query("SELECT a FROM Action a WHERE a.item.id_item = :itemId")
    List<Action> findByItem_IdItem(@Param("itemId") Integer itemId);
}
