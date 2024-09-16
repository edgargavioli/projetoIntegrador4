package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.model.Model;
import com.inventario.imobilizado.repository.ModelInterface;
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
public class ModelController {

    private static final Logger logger = LoggerFactory.getLogger(BrandController.class);

    @Autowired
    private ModelInterface modelInterface;

    @GetMapping
    public List<Model> getAllModels() {
        return modelInterface.findAll();
    }

    @GetMapping("/edit/{id}")
    public ModelAndView getModel(@PathVariable("id") int id) {
        Model model = modelInterface.findById(id).orElse(null);
        ModelAndView modelAndView = new ModelAndView("editModel");
        modelAndView.addObject("model", model);
        return modelAndView;
    }

    @PostMapping(value = "/edit/{id}", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public ModelAndView updateModel(@PathVariable("id") int id, @RequestParam("name") String name, RedirectAttributes redirectAttributes) {
        logger.info("Updating model with id {}", id);

        if (name == null || name.isEmpty()) {
            throw new IllegalArgumentException("Name cannot be null or empty");
        }

        Model existingModel = modelInterface.findById(id).orElse(null);
        if (existingModel != null) {
            existingModel.setName(name); // Assuming you have a setName method in Model model
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
