package com.inventario.imobilizado.controller;

import com.inventario.imobilizado.model.*;
import com.inventario.imobilizado.repository.*;
import com.inventario.imobilizado.service.ExcelExportService;
import com.inventario.imobilizado.service.ExcelImportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;


@RestController
@RequestMapping("/item")
public class ItemController {

    @Autowired
    private ItemInterface itemInterface;

    @Autowired
    private CategoryInterface categoryInterface;

    @Autowired
    private LocationInterface locationInterface;

    @Autowired
    private ExcelExportService excelExportService;
    @Autowired
    private ModeloInterface modeloInterface;
    @Autowired
    private BrandInterface brandInterface;

    @PostMapping("/")
    public ResponseEntity<?> registrarProduto(@RequestBody RequestItem data) {

        Brand brand = brandInterface.findById(data.getMarca()).get();

        Modelo modelo = modeloInterface.findById(data.getModelo()).get();

        Item item = new Item();

        item.setId_item(data.getId_item());

        item.setDescricao(data.getDescricao());

        item.setPotencia(data.getPotencia());

        item.setPatrimonio(data.getPatrimonio());

        item.setData_nota_fiscal(data.getData_nota_fiscal());

        item.setLocalizacao_atual(data.getLocalizacao_atual());

        item.setData_entrada(data.getData_entrada());

        item.setUltima_qualificacao(data.getUltima_qualificacao());

        item.setProxima_qualificacao(data.getProxima_qualificacao());

        item.setComentario_manutencao(data.getComentario_manutencao());

        item.setPrazo_manutencao(data.getPrazo_manutencao());

        item.setEstado(data.getEstado());

        item.setCategoria(categoryInterface.findById(data.getCategoria()).get());

        item.setStatus(data.getStatus());

        item.setNumero_de_serie(data.getNumero_de_serie());

        item.setModelo(modeloInterface.findByNomeAndMarca(modelo.getNome(), brand));

        item.setLocalizacao(locationInterface.findById(data.getLocalizacao()).get());

        item.setNumero_nota_fiscal(data.getNumero_nota_fiscal());

        itemInterface.save(item);
        return ResponseEntity.ok(item);

    }

    @GetMapping("/")
    public ResponseEntity<List<Item>> getAll() {
        List<Item> allItems = itemInterface.findAll();

        // Filter the items with status "Ativo"
        List<Item> allItemsAtivos = allItems.stream()
                                            .filter(item -> "Ativo".equals(item.getStatus()))
                                            .collect(Collectors.toList());

        return ResponseEntity.ok(allItemsAtivos);
    }


    @PutMapping("/{id_item}")
    public ResponseEntity<Item> PutUser(@PathVariable Integer id_item,@RequestBody Item newItem){
        itemInterface.findById(id_item).map(item -> {
            item.setDescricao(newItem.getDescricao());
            item.setPotencia(newItem.getPotencia());
            item.setPatrimonio(newItem.getPatrimonio());
            item.setData_nota_fiscal(newItem.getData_nota_fiscal());
            item.setLocalizacao_atual(newItem.getLocalizacao_atual());
            item.setData_entrada(newItem.getData_entrada());
            item.setUltima_qualificacao(newItem.getUltima_qualificacao());
            item.setProxima_qualificacao(newItem.getProxima_qualificacao());
            item.setEstado(newItem.getEstado());
            item.setCategoria(newItem.getCategoria());
            item.setStatus(newItem.getStatus());
            item.setNumero_de_serie(newItem.getNumero_de_serie());
            item.setModelo(newItem.getModelo());
            item.setLocalizacao(newItem.getLocalizacao());
            item.setNumero_de_serie(newItem.getNumero_de_serie());
            item.setComentario_manutencao(newItem.getComentario_manutencao());
            item.setPrazo_manutencao(newItem.getPrazo_manutencao());
            return itemInterface.save(item);
        }).orElseThrow();
        return ResponseEntity.ok(newItem);
    }

    @DeleteMapping("/{id_item}")
    public  ResponseEntity<String> DeleteUser(@PathVariable Integer id_item){
        itemInterface.deleteById(id_item);
        return ResponseEntity.ok("Item deletado com Sucesso");
    }

    @GetMapping("/paged")
    public Page<Item> PagedItem(Integer page, Integer pageSize, ItemInterface itemInterface, String order) {

        // http://localhost:8080/page/Usuarios?order=sobrenome
        if (order.equals("descricao")){
            Page<Item> itemList = itemInterface.findAll(PageRequest.of(page,pageSize, Sort.by("descricao")));
            return itemList;
        }
        else {
            Page<Item> itemList = itemInterface.findAll(PageRequest.of(page, pageSize));
            return itemList;
        }
    }

    @GetMapping("/export/excel")
    public ResponseEntity<byte[]> exportToExcel() {
        List<Item> items = itemInterface.findAll();
        try {
            return excelExportService.exportItensToExcel(items);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @Autowired
    private ExcelImportService excelImportService;

    @PostMapping("/import/excel")
    public ResponseEntity<?> importFromExcel(@RequestParam("file") MultipartFile file) {
        try {
            List<Item> items = excelImportService.importItemsFromExcel(file.getInputStream());
            return ResponseEntity.ok().body(items);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    

}
