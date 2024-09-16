document.addEventListener('DOMContentLoaded', function() {
  const toggleBtn = document.querySelector('.toggle-btn');
  if (toggleBtn) {
    toggleBtn.addEventListener('click', toggleSidebar);
  }

  function toggleSidebar() {
    const sidebar = document.getElementById('mySidebar');
    const mainContent = document.querySelector('.main-content-registration');

    if (sidebar.classList.contains('closed')) {
      sidebar.style.width = '141px';
      mainContent.style.marginLeft = '161px';
      mainContent.style.width = 'calc(100% - 181px)';
      sidebar.classList.remove('closed');
    } else {
      sidebar.style.width = '0px';
      mainContent.style.marginLeft = '20px';
      mainContent.style.width = 'calc(100% - 40px)';
      sidebar.classList.add('closed');
    }
  }
});

document.addEventListener('DOMContentLoaded', function() {

  // Get the modal
  var modal = document.getElementById("modalLocation");

  // Get the <span> element that closes the modal
  var span = document.getElementsByClassName("close")[0];

  // When the user clicks on <span> (x), close the modal
  span.onclick = function() {
    modal.style.display = "none";
  }

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }

  // Get the form
  var form = document.getElementById('formLocation');

  // Listen for form submission
  form.addEventListener('submit', function(event) {
    // Prevent the default form submission
    event.preventDefault();

    // Get the name field
    var nameField = document.getElementById('nome');

    // Check if the name field is filled
    if (!nameField.value) {
      // If the name field is not filled, show the modal and prevent the form from being submitted
      document.getElementById("modalText").innerText = 'Campo não pode ser vazio';
      modal.style.display = "block";
      return;
    }

    // Make an AJAX request to the server
    var xhr = new XMLHttpRequest();
    xhr.open(form.method, form.action);
    xhr.onload = function() {
      if (xhr.status === 200) {
        // If the server returns a success status, store the success message in localStorage
        localStorage.setItem('modalMessage', 'Campo salvo com sucesso!');
      } else {
        // If the server returns an error status, store the error message in localStorage
        localStorage.setItem('modalMessage', 'Error: ' + xhr.responseText);
      }
      // Reload the page
      window.location.reload();
    };
    xhr.send(new FormData(form));
  });

  // When the page is loaded, check if there is a message in localStorage
  window.onload = function() {
    var modalMessage = localStorage.getItem('modalMessage');
    if (modalMessage) {
      // If there is a message, show it in the modal and remove it from localStorage
      document.getElementById("modalText").innerText = modalMessage;
      modal.style.display = "block";
      localStorage.removeItem('modalMessage');
    }
  };

});