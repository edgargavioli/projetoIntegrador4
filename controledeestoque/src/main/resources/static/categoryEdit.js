function editCategory(button) {
    var id = button.getAttribute('data-id');
    var name = button.getAttribute('data-name');

    // Inside your modal content creation
    var modalContent = document.createElement('div');
    modalContent.innerHTML = `
      <h2 class="h2-modal">Editar Categoria</h2>
      <form id="editCategoryForm" action="/categories/edit/${id}" method="post" style="display: flex; flex-direction: row; align-items: center;">
        <input type="hidden" name="id" value="${id}">
        <label class="label-modal" for="name">Nome:</label>
        <input class="input-modal" type="text" id="name" name="name" value="${name}">
        <button class="button-modal" type="submit">Salvar</button>
      </form>
    `;

    // Display the modal
    var modal = document.getElementById('CategoryModal');
    modal.style.display = 'block';

    // Add the modal content to the modal
    var modalContentContainer = document.getElementById('categoryModalContentContainer');
    while (modalContentContainer.firstChild) {
      modalContentContainer.removeChild(modalContentContainer.firstChild);
    }
    modalContentContainer.appendChild(modalContent);

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target == modal) {
        modal.style.display = 'none';
      }
    };

    // Event listener for the form submission within the modal
    var form = document.getElementById('editCategoryForm');
    form.addEventListener('submit', function(event) {
        event.preventDefault();
        var nameField = document.getElementById('name');
        if (!nameField.value.trim()) {
            document.getElementById("CategoryModalText").innerText = 'Nome não pode ser vazio';
            modal.style.display = "block";
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('POST', form.action);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function() {
            if (xhr.status === 200) {
                // Redirect to the active field registration page with a success message
                localStorage.setItem('modalMessage', 'Categoria atualizada com sucesso');
                window.location.href = '/page/activeFieldRegistration';
            } else {
                localStorage.setItem('modalMessage', 'Error: ' + xhr.responseText);
                window.location.reload();
            }
        };
        xhr.send(new URLSearchParams(new FormData(form)).toString());
    });
}