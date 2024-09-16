package com.inventario.imobilizado.repository;

import com.inventario.imobilizado.model.Attachment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AttachmentInterface extends JpaRepository<Attachment,Integer> {
}
