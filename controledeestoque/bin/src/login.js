function submitForm(event) {
  event.preventDefault();

  var username = document.getElementById('username').value;
  var password = document.getElementById('password').value;

  fetch('http://localhost:8080/login', { // substituir pela URL do servidor
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({username: username, password: password}),
  })
  .then(response => response.json())
  .then(data => {
    console.log('Success:', data);
  })
  .catch((error) => {
    console.error('Error:', error);
  });
}