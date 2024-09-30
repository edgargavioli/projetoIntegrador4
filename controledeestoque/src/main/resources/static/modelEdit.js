function editModel(button) {
    var id = button.getAttribute('data-id');
    var name = button.getAttribute('data-name');

    // Inside your modal content creation
    var modalContent = document.createElement('div');
    modalContent.innerHTML = `
      <h2 class="h2-modal">Editar Modelo</h2>
      <form id="editModelForm" action="/models/edit/${id}" method="post" style="display: flex; flex-direction: column; align-items: center;">
        <input type="hidden" name="id" value="${id}">
        <label class="label-modal" for="marca">Marca:</label>
        <select id="input3" name="marca" required>
            <option value="">Selecione a Marca</option>        
        </select>
        <label class="label-modal" for="name">Nome:</label>
        <input class="input-modal" type="text" id="name" name="name" value="${name}">
        <button class="button-modal" type="submit">Salvar</button>
      </form>
    `;

    // Display the modal
    var modal = document.getElementById('ModelModal');
    modal.style.display = 'block';

    // Add the modal content to the modal
    var modalContentContainer = document.getElementById('modelModalContentContainer');
    while (modalContentContainer.firstChild) {
      modalContentContainer.removeChild(modalContentContainer.firstChild);
    }
    modalContentContainer.appendChild(modalContent);

    fetch('/brands')
        .then(response => response.json())
        .then(brands => {
            var select = document.getElementById('input3');
            brands.forEach(brand => {
                var option = document.createElement('option');
                option.value = brand.id_marca; // ou o campo que representa a identificação da marca
                option.textContent = brand.nome; // ou o campo que representa o nome da marca
                select.appendChild(option);
            });
        })
        .catch(error => console.error('Error fetching brands:', error));

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target == modal) {
        modal.style.display = 'none';
      }
    };

    // Event listener for the form submission within the modal
    var form = document.getElementById('editModelForm');
    form.addEventListener('submit', function(event) {
        event.preventDefault();
        var nameField = document.getElementById('name');
        var brandSelect = document.getElementById('input3');
        if (!nameField.value.trim()) {
            document.getElementById("ModelModalText").innerText = 'Nome não pode ser vazio';
            modal.style.display = "block";
            return;
        }
        if (!brandSelect.value) {
            document.getElementById("ModelModalText").innerText = 'Selecione uma marca';
            modal.style.display = "block";
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('POST', form.action);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function() {
            if (xhr.status === 200) {
                // Redirect to the active field registration page with a success message
                localStorage.setItem('modalMessage', 'Modelo atualizado com sucesso');
                window.location.href = '/page/activeFieldRegistration';
            } else {
                localStorage.setItem('modalMessage', 'Error: ' + xhr.responseText);
                window.location.reload();
            }
        };
        xhr.send(new URLSearchParams(new FormData(form)).toString());
    });
}