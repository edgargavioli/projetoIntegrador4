window.onload = function() {
    document.querySelectorAll('#userTableBody tr').forEach(function(row) {
        if (row.cells.length > 3) {
            var tipoUsuarioCell = row.cells[3]; // "Tipo de Usuário" is the fifth column
            var tipoUsuarioText = tipoUsuarioCell.textContent.trim();
            tipoUsuarioCell.innerHTML = '<span>' + tipoUsuarioText + '</span>';

            if (tipoUsuarioText === 'Administrador') {
                tipoUsuarioCell.classList.add('usuario-administrador');
            } else if (tipoUsuarioText === 'Colaborador') {
                tipoUsuarioCell.classList.add('usuario-colaborador');
            } else if (tipoUsuarioText === 'Aluno') {
                tipoUsuarioCell.classList.add('usuario-aluno');
            }
        }
    });
};