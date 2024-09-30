package com.inventario.imobilizado.model;

import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.text.SimpleDateFormat;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode(of = "id_item")
public class RequestItem {

        private Integer id_item;

        private String descricao;

        private Integer potencia;

        private String patrimonio;

        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private Date data_entrada;

        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private Date data_nota_fiscal;

        private String localizacao_atual;

        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private Date ultima_qualificacao;

        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private Date proxima_qualificacao;

        private String estado;

        private Integer categoria;

        private String status;

        private String numero_de_serie;

        private Integer modelo;

        private Integer marca;

        private Integer localizacao;

        private String numero_nota_fiscal;

        private String comentario_manutencao;

        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private Date prazo_manutencao;

        public String toJson() {
                StringBuilder json = new StringBuilder();
                json.append("{");

                json.append("\"id_item\": ").append(id_item != null ? id_item : "null").append(", ");
                json.append("\"descricao\": \"").append(descricao).append("\", ");
                json.append("\"potencia\": ").append(potencia != null ? potencia : "null").append(", ");
                json.append("\"patrimonio\": \"").append(patrimonio).append("\", ");
                json.append("\"data_entrada\": \"").append(data_entrada != null ? new SimpleDateFormat("yyyy-MM-dd").format(data_entrada) : "null").append("\", ");
                json.append("\"data_nota_fiscal\": \"").append(data_nota_fiscal != null ? new SimpleDateFormat("yyyy-MM-dd").format(data_nota_fiscal) : "null").append("\", ");
                json.append("\"localizacao_atual\": \"").append(localizacao_atual).append("\", ");
                json.append("\"ultima_qualificacao\": \"").append(ultima_qualificacao != null ? new SimpleDateFormat("yyyy-MM-dd").format(ultima_qualificacao) : "null").append("\", ");
                json.append("\"proxima_qualificacao\": \"").append(proxima_qualificacao != null ? new SimpleDateFormat("yyyy-MM-dd").format(proxima_qualificacao) : "null").append("\", ");
                json.append("\"estado\": \"").append(estado).append("\", ");
                json.append("\"categoria\": ").append(categoria != null ? categoria : "null").append(", ");
                json.append("\"status\": \"").append(status).append("\", ");
                json.append("\"numero_de_serie\": \"").append(numero_de_serie).append("\", ");
                json.append("\"modelo\": ").append(modelo != null ? modelo : "null").append(", ");
                json.append("\"marca\": ").append(marca != null ? marca : "null").append(", ");
                json.append("\"localizacao\": ").append(localizacao != null ? localizacao : "null").append(", ");
                json.append("\"numero_nota_fiscal\": \"").append(numero_nota_fiscal).append("\", ");
                json.append("\"comentario_manutencao\": \"").append(comentario_manutencao).append("\", ");
                json.append("\"prazo_manutencao\": \"").append(prazo_manutencao != null ? new SimpleDateFormat("yyyy-MM-dd").format(prazo_manutencao) : "null").append("\"");

                json.append("}");
                return json.toString();
        }

}