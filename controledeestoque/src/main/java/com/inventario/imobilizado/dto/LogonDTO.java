package com.inventario.imobilizado.dto;

import java.util.Objects;

public class LogonDTO {
    private String nome;
    private String sobrenome;
    private String email;
    private String tipo_usuario;
    private String senha;
    private String confirmar_senha;

    public LogonDTO(String nome, String sobrenome, String email, String tipo_usuario, String senha, String confirmar_senha) {
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.email = email;
        this.tipo_usuario = tipo_usuario;
        this.senha = senha;
        this.confirmar_senha = confirmar_senha;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSobrenome() {
        return sobrenome;
    }

    public void setSobrenome(String sobrenome) {
        this.sobrenome = sobrenome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTipo_usuario() {
        return tipo_usuario;
    }

    public void setTipo_usuario(String tipo_usuario) {
        this.tipo_usuario = tipo_usuario;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getConfirmar_senha() {
        return confirmar_senha;
    }

    public void setConfirmar_senha(String confirmar_senha) {
        this.confirmar_senha = confirmar_senha;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        LogonDTO logonDTO = (LogonDTO) o;
        return Objects.equals(nome, logonDTO.nome) && Objects.equals(sobrenome, logonDTO.sobrenome) && Objects.equals(email, logonDTO.email) && Objects.equals(tipo_usuario, logonDTO.tipo_usuario) && Objects.equals(senha, logonDTO.senha) && Objects.equals(confirmar_senha, logonDTO.confirmar_senha);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nome, sobrenome, email, tipo_usuario, senha, confirmar_senha);
    }
}
