function editBrand(button) {
    var id = button.getAttribute('data-id');
    var name = button.getAttribute('data-name');

    // Inside your modal content creation
    var modalContent = document.createElement('div');
    modalContent.innerHTML = `
      <h2 class="h2-modal">Editar Marca</h2>
      <form id="editBrandForm" action="/brands/edit/${id}" method="post" style="display: flex; flex-direction: row; align-items: center;">
        <input type="hidden" name="id" value="${id}">
        <label class="label-modal" for="name">Nome:</label>
        <input class="input-modal" type="text" id="name" name="name" value="${name}">
        <button class="button-modal" type="submit">Salvar</button>
      </form>
    `;

    // Display the modal
    var modal = document.getElementById('BrandModal');
    modal.style.display = 'block';

    // Add the modal content to the modal
    var modalContentContainer = document.getElementById('modalContentContainer');
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
    var form = document.getElementById('editBrandForm');
    form.addEventListener('submit', function(event) {
        event.preventDefault();
        var nameField = document.getElementById('name');
        if (!nameField.value.trim()) {
            document.getElementById("BrandModalText").innerText = 'Nome não pode ser vazio';
            modal.style.display = "block";
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('POST', form.action);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function() {
            if (xhr.status === 200) {
                // Redirect to the active field registration page with a success message
                localStorage.setItem('modalMessage', 'Marca atualizada com sucesso');
                window.location.href = '/page/activeFieldRegistration';
            } else {
                localStorage.setItem('modalMessage', 'Error: ' + xhr.responseText);
                window.location.reload();
            }
        };
        xhr.send(new URLSearchParams(new FormData(form)).toString());
    });
}

document.addEventListener('DOMContentLoaded', function() {
    var modal = document.getElementById('BrandModal');

    // Function to show the modal
    function showModal(message) {
        document.getElementById("BrandModalText").innerText = message;
        modal.style.display = "block";
    }

    // Event listener to close the modal
    var closeModal = document.getElementById('closeModal');
    closeModal.onclick = function() {
        modal.style.display = 'none';
    };

    // Event listener to close the modal when clicking outside of it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    };

    // Check if there is a modal message in localStorage and show the modal
    var modalMessage = localStorage.getItem('modalMessage');
    if (modalMessage) {
        showModal(modalMessage);
        localStorage.removeItem('modalMessage');
    }

    // Check for successMessage and errorMessage directly in the HTML template
    var successMessageElement = document.getElementById('successMessage');
    var errorMessageElement = document.getElementById('errorMessage');

    if (successMessageElement && successMessageElement.value) {
        localStorage.setItem('modalMessage', successMessageElement.value);
        window.location.href = '/page/activeFieldRegistration';
    }

    if (errorMessageElement && errorMessageElement.value) {
        localStorage.setItem('modalMessage', errorMessageElement.value);
        window.location.reload();
    }
});
