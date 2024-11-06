document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('tbody tr').forEach(function(row) {
        var lastCell = row.cells[row.cells.length - 1];
        var estadoText = lastCell.textContent.trim();
        lastCell.innerHTML = '<span>' + estadoText + '</span>';

        if (estadoText === 'Disponivel') {
            lastCell.textContent = 'Disponível';
        lastCell.classList.add('disponibilidade-disponivel');
        } else if (estadoText === 'Emprestado') {
            lastCell.textContent = 'Emprestado';
        lastCell.classList.add('disponibilidade-emprestado');
        } else if (estadoText === 'Manutencao') {
            lastCell.textContent = 'Manutenção';
        lastCell.classList.add('disponibilidade-manutencao');
        }

        var disponibilidadeCell = row.cells[6];
        var disponibilidadeText = disponibilidadeCell.textContent.trim();
        disponibilidadeCell.innerHTML = '<span>' + disponibilidadeText + '</span>';
    });
});
