package com.inventario.imobilizado.model;

import jakarta.persistence.*;
import lombok.*;


@Entity
@Table(name = "Usuario")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id_usuario")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_usuario")
	private int id_usuario;
	private String nome;
	private String sobrenome;
	private String tipo_usuario;
    private String email;
    private String senha;

	public User get() {
		return this;
	}
}