function editLocation(button) {
    var id = button.getAttribute('data-id');
    var name = button.getAttribute('data-name');

    // Inside your modal content creation
    var modalContent = document.createElement('div');
    modalContent.innerHTML = `
        <h2 class="h2-modal">Editar Localização</h2>
        <form id="editLocationForm" action="/page/location/edit/${id}" method="post" style="display: flex; flex-direction: row; align-items: center;">
            <input type="hidden" name="id" value="${id}">
            <label class="label-modal" for="name">Nome:</label>
            <input class="input-modal" type="text" id="name" name="name" value="${name}">
            <button class="button-modal" type="submit">Salvar</button>
        </form>
    `;

    // Display the modal
    var modal = document.getElementById('LocationModal');
    modal.style.display = 'block';

    // Add the modal content to the modal
    var modalContentContainer = document.getElementById('modalContentContainer');
    while (modalContentContainer.firstChild) {
        modalContentContainer.removeChild(modalContentContainer.firstChild);
    }
    modalContentContainer.appendChild(modalContent);

    // Event listener for the form submission within the modal
    var form = document.getElementById('editLocationForm');
    form.addEventListener('submit', function(event) {
        event.preventDefault();
        var nameField = document.getElementById('name');
        if (!nameField.value.trim()) {
            // Handle empty name field scenario
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open('POST', form.action); // Ensure 'form.action' points to the correct endpoint
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function() {
            if (xhr.status === 200) {
                // Redirect to the location registration page with a success message
                localStorage.setItem('modalMessage', 'Localização atualizada com sucesso!');
                window.location.href = '/page/location'; // Adjust the redirect URL as per your application
            } else {
                // Handle error scenario
                localStorage.setItem('modalMessage', 'Error: ' + xhr.responseText);
                window.location.reload();
            }
        };
        xhr.send(new URLSearchParams(new FormData(form)).toString());
    });
}

document.addEventListener('DOMContentLoaded', function() {
    var modalLocation = document.getElementById('modalLocation');
    var modalText = document.getElementById('modalText');

    var LocationModal = document.getElementById('LocationModal');
    var LocationModalText = document.getElementById('LocationModalText');
    var modalContentContainer = document.getElementById('modalContentContainer');

    // Function to show the message modal
    function showMessageModal(message) {
        modalText.innerText = message;
        modalLocation.style.display = "block";
        localStorage.removeItem('modalMessage'); // Remove the modal message after displaying
    }

    // Function to show the location edit modal
    function showLocationModal(locationId, locationName) {
        var modalContent = document.createElement('div');
        modalContent.innerHTML = `
            <h2>Editar Localização</h2>
            <form id="editLocationForm" action="/page/location/edit/${locationId}" method="post" style="display: flex; flex-direction: row; align-items: center;">
                <input type="hidden" name="id" value="${locationId}">
                <label for="name">Nome:</label>
                <input type="text" id="name" name="name" value="${locationName}">
                <button type="submit">Salvar</button>
            </form>
        `;

        modalContentContainer.innerHTML = '';
        modalContentContainer.appendChild(modalContent);
        LocationModal.style.display = 'block';
    }

    // Event listener to close the message modal
    var closeMessageModal = document.querySelector('#modalLocation .close');
    if (closeMessageModal) {
        closeMessageModal.onclick = function() {
            modalLocation.style.display = 'none';
        };
    }

    // Event listener to close the location edit modal
    var closeLocationModal = document.querySelector('#LocationModal .close');
    if (closeLocationModal) {
        closeLocationModal.onclick = function() {
            LocationModal.style.display = 'none';
        };
    }

    // Event listener for the location edit form submission
    var editLocationForm = document.getElementById('editLocationForm');
    if (editLocationForm) {
        editLocationForm.addEventListener('submit', function(event) {
            event.preventDefault();

            var nameField = document.getElementById('name');
            if (!nameField.value.trim()) {
                LocationModalText.innerText = 'Nome não pode ser vazio';
                LocationModal.style.display = "block";
                return;
            }

            var xhr = new XMLHttpRequest();
            xhr.open('POST', editLocationForm.action);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    localStorage.setItem('modalMessage', 'Localização atualizada com sucesso');
                    window.location.href = '/page/location';
                } else {
                    localStorage.setItem('modalMessage', 'Error: ' + xhr.responseText);
                    window.location.reload();
                }
            };
            xhr.send(new URLSearchParams(new FormData(editLocationForm)).toString());
        });
    }

    // Check if there is a modal message in localStorage and show the message modal
    var modalMessage = localStorage.getItem('modalMessage');
    if (modalMessage) {
        showMessageModal(modalMessage);
    }

    // Check for successMessage and errorMessage directly in the HTML template
    var successMessageElement = document.getElementById('successMessage');
    var errorMessageElement = document.getElementById('errorMessage');

    if (successMessageElement && successMessageElement.value) {
        showMessageModal(successMessageElement.value);
        localStorage.removeItem('modalMessage'); // Remove the modal message after displaying
        window.location.href = '/page/location';
    }

    if (errorMessageElement && errorMessageElement.value) {
        showMessageModal(errorMessageElement.value);
        localStorage.removeItem('modalMessage'); // Remove the modal message after displaying
        window.location.reload();
    }

    // Function to show the location edit modal when clicking the edit button
    function editLocation(button) {
        var id = button.getAttribute('data-id');
        var name = button.getAttribute('data-name');

        showLocationModal(id, name);
    }
});

