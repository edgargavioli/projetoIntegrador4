package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.User;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

public interface UserInterface extends JpaRepository<User,Integer>,PagingAndSortingRepository<User,Integer> {
    @Query("select u.email, u.senha from usuario u where u.email = ?1")
    User findByEmail(String email);


}

