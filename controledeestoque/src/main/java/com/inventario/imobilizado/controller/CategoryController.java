package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.model.Category;
import com.inventario.imobilizado.repository.CategoryInterface;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@RestController
@RequestMapping("/categories")
public class CategoryController {

    private static final Logger logger = LoggerFactory.getLogger(CategoryController.class);

    @Autowired
    private CategoryInterface categoryInterface;

    @GetMapping("/")
    public List<Category> getAllCategories() {
        return categoryInterface.findAll();
    }

    @GetMapping("/edit/{id}")
    public ModelAndView getCategory(@PathVariable("id") int id) {
        Category category = categoryInterface.findById(id).orElse(null);
        ModelAndView modelAndView = new ModelAndView("editCategory");
        modelAndView.addObject("category", category);
        return modelAndView;
    }

    @PostMapping(value = "/edit/{id}", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public ModelAndView updateCategory(@PathVariable("id") int id, @RequestParam("name") String name, RedirectAttributes redirectAttributes) {
        logger.info("Updating category with id {}", id);

        if (name == null || name.isEmpty()) {
            throw new IllegalArgumentException("Name cannot be null or empty");
        }

        Category existingCategory = categoryInterface.findById(id).orElse(null);
        if (existingCategory != null) {
            existingCategory.setName(name); // Assuming you have a setName method in Category model
            categoryInterface.save(existingCategory);

            // Redirect with flash attribute for displaying a success message
            redirectAttributes.addFlashAttribute("successMessage", "Category updated successfully");

            // Redirect to the desired URL
            return new ModelAndView("redirect:/page/activeFieldRegistration");
        }

        // Handle the case where the category with given ID is not found
        redirectAttributes.addFlashAttribute("errorMessage", "Failed to update category");
        return new ModelAndView("redirect:/categories/edit/" + id);
    }

    @DeleteMapping("/delete/{id}")
    public String deleteCategory(@PathVariable("id") int id) {
        categoryInterface.deleteById(id);
        return "Category deleted successfully";
    }

}