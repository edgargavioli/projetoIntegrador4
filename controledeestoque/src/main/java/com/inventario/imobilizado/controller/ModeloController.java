package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.model.Brand;
import com.inventario.imobilizado.model.Modelo;
import com.inventario.imobilizado.repository.BrandInterface;
import com.inventario.imobilizado.repository.ModeloInterface;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import java.util.List;

@RestController
@RequestMapping("/models")
public class ModeloController {

    private static final Logger logger = LoggerFactory.getLogger(BrandController.class);

    @Autowired
    private ModeloInterface modelInterface;
    @Autowired
    private BrandInterface brandInterface;

    @GetMapping
    public List<Modelo> getAllModels() {
        return modelInterface.findAll();
    }

    @GetMapping("/edit/{id}")
    public ModelAndView getModel(@PathVariable("id") int id) {
        Modelo model = modelInterface.findById(id).orElse(null);
        ModelAndView modelAndView = new ModelAndView("editModel");
        modelAndView.addObject("model", model);
        return modelAndView;
    }

    @GetMapping("/{marcaId}")
    public List<Modelo> getModelByBrand(@PathVariable int marcaId) {
        Brand brand = brandInterface.findById(marcaId).orElse(null);
        return modelInterface.findByMarca(brand);
    }

    @PostMapping(value = "/edit/{id}", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public ModelAndView updateModel(@PathVariable("id") int id, @RequestParam("name") String name, @RequestParam("marca") Integer marca, RedirectAttributes redirectAttributes) {
        logger.info("Updating model with id {}", id);

        if (name == null || name.isEmpty() || marca == null || marca == 0) {
            throw new IllegalArgumentException("Name cannot be null or empty");
        }

        Modelo existingModel = modelInterface.findById(id).orElse(null);
        if (existingModel != null) {
            existingModel.setName(name); // Assuming you have a setName method in Model model
            existingModel.setMarca(brandInterface.findById(marca).orElse(null));
            modelInterface.save(existingModel);

            // Redirect with flash attribute for displaying a success message
            redirectAttributes.addFlashAttribute("successMessage", "Model updated successfully");

            // Redirect to the desired URL
            return new ModelAndView("redirect:/page/activeFieldRegistration");
        }

        // Handle the case where the model with given ID is not found
        redirectAttributes.addFlashAttribute("errorMessage", "Failed to update model");
        return new ModelAndView("redirect:/models/edit/" + id);
    }

    @DeleteMapping("/delete/{id}")
    public String deleteModel(@PathVariable("id") int id) {
        modelInterface.deleteById(id);
        return "Model deleted successfully";
    }

}