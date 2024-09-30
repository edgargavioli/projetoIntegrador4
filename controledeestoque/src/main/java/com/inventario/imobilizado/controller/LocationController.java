package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.model.Location;
import com.inventario.imobilizado.repository.LocationInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

@RestController
@RequestMapping("/page")
public class LocationController {

    private static final Logger logger = LoggerFactory.getLogger(LocationController.class);

    @Autowired
    private LocationInterface locationInterface;

    @GetMapping("/")
    public List<Location> getAllLocations() {
        return locationInterface.findAll();
    }

    @GetMapping("/locationList")
    public ModelAndView GetAll(){
        ModelAndView modelAndView = new ModelAndView();
        List<Location> AllLocations = locationInterface.findAll();
        modelAndView.addObject("locations", AllLocations);
        modelAndView.setViewName("location");
        return modelAndView;
    }

    @GetMapping("/location/getByName/{nome}")
    public ResponseEntity<Location> GetByEmail(@PathVariable String nome){
        Location location = locationInterface.findByNome(nome);
        return ResponseEntity.ok(location);
    }

    @PostMapping("/location")
    public ModelAndView PostLocation(@ModelAttribute Location location, RedirectAttributes redirectAttributes){
        System.out.println(location.getNome());
        locationInterface.save(location);
        redirectAttributes.addFlashAttribute("locationSaved", true);
        return new ModelAndView("redirect:/page/location");
    }

    @GetMapping("/location/edit/{id}")
    public ModelAndView getLocation(@PathVariable("id") int id) {
        Location location = locationInterface.findById(id).orElse(null);
        ModelAndView modelAndView = new ModelAndView("editLocation");
        modelAndView.addObject("location", location);
        return modelAndView;
    }

    @PostMapping(value = "/location/edit/{id}", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public ModelAndView updateLocation(@PathVariable("id") int id, @RequestParam("name") String name, RedirectAttributes redirectAttributes) {
        logger.info("Updating location with id {}", id);

        if (name == null || name.isEmpty()) {
            throw new IllegalArgumentException("Name cannot be null or empty");
        }

        Location existingLocation = locationInterface.findById(id).orElse(null);
        if (existingLocation != null) {
            existingLocation.setName(name); // Assuming you have a setName method in Location model
            locationInterface.save(existingLocation);

            // Redirect with flash attribute for displaying a success message
            redirectAttributes.addFlashAttribute("successMessage", "Location updated successfully");

            // Redirect to the desired URL
            return new ModelAndView("redirect:/page/location"); // Adjust the redirect URL as per your application
        }

        // Handle the case where the location with given ID is not found
        redirectAttributes.addFlashAttribute("errorMessage", "Failed to update location");
        return new ModelAndView("redirect:/locations/edit/" + id);
    }

    @DeleteMapping("/location/delete/{id}")
    public String deleteLocation(@PathVariable("id") int id) {
        locationInterface.deleteById(id);
        return "Location deleted successfully";
    }
}

