document.addEventListener('DOMContentLoaded', function() {
    const fileInput = document.getElementById('fileInput');
    const importButton = document.getElementById('importButton');
    const successModal = document.getElementById('successModal');
    const closeButton = document.querySelector('.close');

    importButton.addEventListener('click', function() {
        fileInput.click();
    });

    fileInput.addEventListener('change', function() {
        const file = fileInput.files[0];
        if (file) {
            const formData = new FormData();
            formData.append('file', file);

            fetch('http://localhost:8080/item/import/excel', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    showSuccessModal();
                } else {
                    throw new Error('Failed to import items');
                }
            })
            .catch(error => {
                console.error('Error importing data:', error);
                alert('Failed to import items. Please try again.');
            });
        }
    });

    closeButton.addEventListener('click', function() {
        successModal.style.display = 'none';
        location.reload();
    });

    function showSuccessModal() {
        successModal.style.display = 'block';
    }
});
