package com.inventario.imobilizado.service;

import com.inventario.imobilizado.model.*;
import com.inventario.imobilizado.repository.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;
import java.util.*;

@Service
public class ExcelImportService {

    @Autowired
    private ItemInterface itemInterface;

    @Autowired
    private CategoryInterface categoryInterface;

    @Autowired
    private LocationInterface locationInterface;
    @Autowired
    private ModeloInterface modeloInterface;
    @Autowired
    private BrandInterface brandInterface;

    @Transactional
    public List<Item> importItemsFromExcel(InputStream is) {
        List<Item> items = new ArrayList<>();

        try (Workbook workbook = new XSSFWorkbook(is)) {
            Sheet sheet = workbook.getSheetAt(0);
            for (Row row : sheet) {
                if (row.getRowNum() == 0) {
                    continue; // skip header row
                }

                Item item = new Item();
                item.setDescricao(getCellValueAsString(row.getCell(0)));
                Brand marca = getOrCreateMarca(getCellValueAsString(row.getCell(1)));
                item.setModelo(getOrCreateModelo(getCellValueAsString(row.getCell(2)), marca));
                item.setCategoria(getOrCreateCategory(getCellValueAsString(row.getCell(3))));
                item.setNumero_de_serie(getCellValueAsString(row.getCell(4)));
                item.setEstado(getCellValueAsString(row.getCell(5)));
                item.setLocalizacao(getOrCreateLocation(getCellValueAsString(row.getCell(6))));
                item.setLocalizacao_atual(getCellValueAsString(row.getCell(7)));
                item.setPotencia(getCellValueAsInteger(row.getCell(8)));
                item.setNumero_nota_fiscal(getCellValueAsString(row.getCell(9)));

                item.setData_nota_fiscal(getCellValueAsDate(row.getCell(10)));
                item.setData_entrada(getCellValueAsDate(row.getCell(11)));
                item.setUltima_qualificacao(getCellValueAsDate(row.getCell(12)));
                item.setProxima_qualificacao(getCellValueAsDate(row.getCell(13)));
                item.setPrazo_manutencao(getCellValueAsDate(row.getCell(14)));
                item.setComentario_manutencao(getCellValueAsString(row.getCell(15)));
                item.setStatus(getCellValueAsString(row.getCell(16)));

                items.add(item);
            }

            // Save all items to the database
            itemInterface.saveAll(items);

        } catch (Exception e) {
            throw new RuntimeException("Failed to import Excel data: " + e.getMessage(), e);
        }

        return items;
    }

    private String getCellValueAsString(Cell cell) {
        if (cell == null) {
            return null;
        }
        if (cell.getCellType() == CellType.STRING) {
            return cell.getStringCellValue();
        } else if (cell.getCellType() == CellType.NUMERIC) {
            return String.valueOf((int) cell.getNumericCellValue());
        } else {
            return null;
        }
    }

    private Integer getCellValueAsInteger(Cell cell) {
        if (cell == null || cell.getCellType() == CellType.BLANK) {
            return null;
        }
        try {
            if (cell.getCellType() == CellType.NUMERIC) {
                // Directly cast numeric cell value to integer
                return (int) cell.getNumericCellValue();
            } else if (cell.getCellType() == CellType.STRING) {
                // Handle cases where the cell contains a string representation of an integer
                String cellValue = cell.getStringCellValue().trim();
                if (cellValue.isEmpty()) {
                    return null;
                }
                // Attempt to parse the string value to integer
                try {
                    return Integer.parseInt(cellValue);
                } catch (NumberFormatException e) {
                    // Log or handle the error gracefully (e.g., skip or set to null)
                    return null;
                }
            } else {
                return null; // Handle other cell types as needed
            }
        } catch (Exception e) {
            // Log the error or handle it appropriately
            throw new RuntimeException("Failed to convert cell value to Integer: " + e.getMessage(), e);
        }
    }


    private Date getCellValueAsDate(Cell cell) {
        if (cell == null || cell.getCellType() == CellType.BLANK) {
            return null; // Return null for empty cells
        }
        if (cell.getCellType() == CellType.NUMERIC && DateUtil.isCellDateFormatted(cell)) {
            return cell.getDateCellValue();
        } else if (cell.getCellType() == CellType.STRING) {
            String cellValue = cell.getStringCellValue().trim();
            if (cellValue.isEmpty()) {
                return null; // Return null for empty strings
            }
            try {
                return java.sql.Date.valueOf(cellValue); // Convert valid date strings
            } catch (IllegalArgumentException e) {
                return null; // Handle invalid date format gracefully
            }
        } else {
            return null; // Handle other cell types as needed
        }
    }

    private Category getOrCreateCategory(String categoryName) {
        Category category = categoryInterface.findByNome(categoryName);
        if (category == null) {
            category = new Category(categoryName);
            category = categoryInterface.save(category);
        }
        return category;
    }

    private Location getOrCreateLocation(String locationName) {
        Location location = locationInterface.findByNome(locationName);
        if (location == null) {
            location = new Location(locationName);
            location = locationInterface.save(location);
        }
        return location;
    }

    private Brand getOrCreateMarca(String marcaName) {
        Brand marca = brandInterface.findByNome(marcaName);
        if (marca == null) {
            marca = new Brand(marcaName);
            marca = brandInterface.save(marca);
        }
        return marca;
    }

    private Modelo getOrCreateModelo(String modelName, Brand marca) {
        Modelo model = modeloInterface.findByNomeAndMarca(modelName, marca);
        if (model == null) {
            model = new Modelo(modelName, marca);
            model = modeloInterface.save(model);
        }
        return model;
    }
}
