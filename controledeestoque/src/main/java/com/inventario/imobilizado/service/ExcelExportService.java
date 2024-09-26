package com.inventario.imobilizado.service;

import com.inventario.imobilizado.model.Item;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

@Service
public class ExcelExportService {

    public ResponseEntity<byte[]> exportItensToExcel(List<Item> itens) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Itens");
        Row headerRow = sheet.createRow(0);

        // Create a Font for styling header cells
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerFont.setFontHeightInPoints((short) 14);
        headerFont.setColor(IndexedColors.BLACK.getIndex());

        // Create a CellStyle with the font
        CellStyle headerCellStyle = workbook.createCellStyle();
        headerCellStyle.setFont(headerFont);

        // Creating header cells
        Cell cell = headerRow.createCell(0);
        cell.setCellValue("Descrição");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(1);
        cell.setCellValue("Marca");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(2);
        cell.setCellValue("Modelo");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(3);
        cell.setCellValue("Categoria");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(4);
        cell.setCellValue("Número de série");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(5);
        cell.setCellValue("Disponibilidade");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(6);
        cell.setCellValue("Local de origem");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(7);
        cell.setCellValue("Local atual");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(8);
        cell.setCellValue("Potência");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(9);
        cell.setCellValue("Nota fiscal");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(10);
        cell.setCellValue("Data da nota fiscal");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(11);
        cell.setCellValue("Data de entrada");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(12);
        cell.setCellValue("Última manutenção");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(13);
        cell.setCellValue("Próxima manutenção");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(14);
        cell.setCellValue("Prazo de manutenção");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(15);
        cell.setCellValue("Comentário de Manutenção");
        cell.setCellStyle(headerCellStyle);

        cell = headerRow.createCell(16);
        cell.setCellValue("Status");
        cell.setCellStyle(headerCellStyle);


        // Create CellStyle for formatting date
        CreationHelper createHelper = workbook.getCreationHelper();
        CellStyle dateCellStyle = workbook.createCellStyle();
        dateCellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-MM-yyyy"));

        // Creating data rows
        int rowNum = 1;
        for (Item item : itens) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(item.getDescricao());
            row.createCell(1).setCellValue(item.getModelo().getMarca().toString());
            row.createCell(2).setCellValue(item.getModelo().toString());
            row.createCell(3).setCellValue(item.getCategoria().toString());
            row.createCell(4).setCellValue(item.getNumero_de_serie());
            row.createCell(5).setCellValue(item.getEstado().toString());
            row.createCell(6).setCellValue(item.getLocalizacao().toString());
            row.createCell(7).setCellValue(item.getLocalizacao_atual());
            row.createCell(8).setCellValue(item.getPotencia());
            row.createCell(9).setCellValue(item.getNumero_nota_fiscal());

            Cell dataNotaFiscal = row.createCell(10);
            dataNotaFiscal.setCellValue(item.getData_nota_fiscal());
            dataNotaFiscal.setCellStyle(dateCellStyle);

            Cell dataEntrada = row.createCell(11);
            dataEntrada.setCellValue(item.getData_entrada());
            dataEntrada.setCellStyle(dateCellStyle);

            Cell ultimaManutencao = row.createCell(12);
            ultimaManutencao.setCellValue(item.getUltima_qualificacao());
            ultimaManutencao.setCellStyle(dateCellStyle);

            Cell proximaManutencao = row.createCell(13);
            proximaManutencao.setCellValue(item.getProxima_qualificacao());
            proximaManutencao.setCellStyle(dateCellStyle);

            Cell prazoManutencao = row.createCell(14);
            prazoManutencao.setCellValue(item.getPrazo_manutencao());
            prazoManutencao.setCellStyle(dateCellStyle);

            row.createCell(15).setCellValue(item.getComentario_manutencao());
            row.createCell(16).setCellValue(item.getStatus().toString());
        }

        // Resize all columns to fit the content size
        for(int i = 0; i < 19; i++) {
            sheet.autoSizeColumn(i);
        }

        // Freeze the first row so it remains visible when scrolling down
        sheet.createFreezePane(0, 1);

        // Write the output to a byte array
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        // Return the byte array as a ResponseEntity
        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=items.xlsx");

        return ResponseEntity.ok()
                .headers(headers)
                .body(outputStream.toByteArray());
    }
}