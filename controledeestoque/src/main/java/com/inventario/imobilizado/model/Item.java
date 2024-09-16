package com.inventario.imobilizado.model;


import com.inventario.imobilizado.repository.StateInterface;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;


@Entity
@Table(name = "item")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id_item")
public class Item {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id_item;

    private String descricao;

    private String localizacao_atual;

    private Integer potencia;

    private String numero_de_serie;

    private String numero_nota_fiscal;

    private String comentario_manutencao;

    @Temporal(TemporalType.DATE)
    private Date data_entrada;

    @Temporal(TemporalType.DATE)
    private Date ultima_qualificacao;

    @Temporal(TemporalType.DATE)
    private Date data_nota_fiscal;

    @Temporal(TemporalType.DATE)
    private Date proxima_qualificacao;

    @Temporal(TemporalType.DATE)
    private Date prazo_manutencao;


    @ManyToOne
    @JoinColumn(name = "estado_id_estado")
    private State estado;

    @ManyToOne
    @JoinColumn(name = "categoria_id_categoria")
    private Category categoria;

    @ManyToOne
    @JoinColumn(name = "status_id_status")
    private Status status;

    @ManyToOne
    @JoinColumn(name = "modelo_id_modelo")
    private Model modelo;

    @ManyToOne
    @JoinColumn(name = "marca_id_marca")
    private Brand marca;

    @ManyToOne
    @JoinColumn(name = "localizacao_id_localizacao")
    private Location localizacao;

}
