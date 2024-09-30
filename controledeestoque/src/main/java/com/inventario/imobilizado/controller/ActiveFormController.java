package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.model.ActiveFieldForm;
import com.inventario.imobilizado.model.Brand;
import com.inventario.imobilizado.model.Category;
import com.inventario.imobilizado.model.Modelo;
import com.inventario.imobilizado.repository.BrandInterface;
import com.inventario.imobilizado.repository.CategoryInterface;
import com.inventario.imobilizado.repository.ModeloInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ActiveFormController {

    @Autowired
    private CategoryInterface categoryInterface;
    @Autowired
    private BrandInterface brandInterface;
    @Autowired
    private ModeloInterface modeloInterface;

    @PostMapping("/activeFieldRegistration")
    public ResponseEntity<String> handleActiveFieldRegistration(@ModelAttribute ActiveFieldForm activeFieldForm) {
        // Check if name is null or empty
        if (activeFieldForm.getName() == null || activeFieldForm.getName().trim().isEmpty()) {
            return ResponseEntity.badRequest().body("Name is required");
        }

        // Check the activeFieldType and save the name to the corresponding instance
        switch (activeFieldForm.getActiveFieldType()) {
            case "Modelo":
                Modelo modelo = new Modelo();
                modelo.setName(activeFieldForm.getName());
                modelo.setMarca(brandInterface.findById(activeFieldForm.getBrandId()).orElse(null));
                modeloInterface.save(modelo);
                break;
            case "Marca":
                Brand brand = new Brand();
                brand.setName(activeFieldForm.getName());
                brandInterface.save(brand);
                break;
            case "Categoria":
                Category category = new Category();
                category.setNome(activeFieldForm.getName());
                categoryInterface.save(category);
                break;
            default:
                return ResponseEntity.badRequest().body("Invalid active field type");
        }

        // Return a 200 OK status code with a success message
        return ResponseEntity.ok("Active field registration successful");
    }
}
