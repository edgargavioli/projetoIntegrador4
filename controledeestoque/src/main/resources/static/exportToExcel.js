function exportToExcel() {
    fetch('/item/export/excel')
        .then(response => response.blob())
        .then(blob => {
            var url = window.URL.createObjectURL(blob);
            var a = document.createElement('a');
            a.href = url;
            a.download = 'Relatorio_infoGeral.xlsx';
            document.body.appendChild(a); // we need to append the element to the dom -> otherwise it will not work in firefox
            a.click();
            a.remove();  //afterwards we remove the element again
        });
}

window.onload = function() {
    const urlParams = new URLSearchParams(window.location.search);
    const reportSaved = urlParams.get('reportSaved');
    if (reportSaved) {
        var modal = document.getElementById("excelModal");
        var span = document.getElementsByClassName("close")[0];
        document.getElementById('ExcelModalText').innerText = 'Relatório salvo com sucesso';
        modal.style.display = "block";
        span.onclick = function() {
            modal.style.display = "none";
        }
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    }
}