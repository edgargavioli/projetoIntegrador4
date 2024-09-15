package com.inventario.imobilizado.model;

import jakarta.persistence.*;

@Entity
public class ActiveFieldForm {

    @Id
    private Long id;

    private String activeFieldType;
    private String name;
    private Integer brandId;

    // Getters and setters
    public String getActiveFieldType() {
        return activeFieldType;
    }

    public void setActiveFieldType(String activeFieldType) {
        this.activeFieldType = activeFieldType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getBrandId() {
        return brandId;
    }

    public void setBrandId(Integer brandId) {
        this.brandId = brandId;
    }
}