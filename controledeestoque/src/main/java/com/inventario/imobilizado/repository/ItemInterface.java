package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.Item;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface ItemInterface extends JpaRepository<Item,Integer>, PagingAndSortingRepository<Item,Integer> {

}
