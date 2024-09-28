package com.inventario.imobilizado.controller;
import com.inventario.imobilizado.model.Brand;
import com.inventario.imobilizado.repository.BrandInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@RestController
@RequestMapping("/brands")
public class BrandController {

    private static final Logger logger = LoggerFactory.getLogger(BrandController.class);

    @Autowired
    private BrandInterface brandInterface;

    @GetMapping("/")
    public List<Brand> getAllBrands() {
        return brandInterface.findAll();
    }

    @GetMapping("/edit/{id}")
    public ModelAndView getBrand(@PathVariable("id") int id) {
        Brand brand = brandInterface.findById(id).orElse(null);
        ModelAndView modelAndView = new ModelAndView("editBrand");
        modelAndView.addObject("brand", brand);
        return modelAndView;
    }

    @PostMapping(value = "/edit/{id}", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public ModelAndView updateBrand(@PathVariable("id") int id, @RequestParam("name") String name, RedirectAttributes redirectAttributes) {
        logger.info("Updating brand with id {}", id);

        if (name == null || name.isEmpty()) {
            throw new IllegalArgumentException("Name cannot be null or empty");
        }

        Brand existingBrand = brandInterface.findById(id).orElse(null);
        if (existingBrand != null) {
            existingBrand.setName(name); // Assuming you have a setName method in Brand model
            brandInterface.save(existingBrand);

            // Redirect with flash attribute for displaying a success message
            redirectAttributes.addFlashAttribute("successMessage", "Brand updated successfully");

            // Redirect to the desired URL
            return new ModelAndView("redirect:/page/activeFieldRegistration");
        }

        // Handle the case where the brand with given ID is not found
        redirectAttributes.addFlashAttribute("errorMessage", "Failed to update brand");
        return new ModelAndView("redirect:/brands/edit/" + id);
    }

    @DeleteMapping("/delete/{id}")
    public String deleteBrand(@PathVariable("id") int id) {
        brandInterface.deleteById(id);
        return "Brand deleted successfully";
    }
}