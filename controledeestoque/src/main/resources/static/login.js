const login_button = document.querySelector('#login-button');
const errorDiv = document.querySelector('#error-mensage-login');

function addLoginEvent(){
  login_button.addEventListener('click', (event) => {
    event.preventDefault();

    const email = document.getElementById('email').value;
    const password = document.getElementById('senha').value;
    fetch('/login', { // substituir pela URL do servidor
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({email: email, password: password}),
    })
        .then(response => {
          if (response.ok) {
            return response.json();
          } else {
              return response.text().then(error => {
                throw new Error(error.message || "Erro ao realizar login");
              });
          }
        })
        .then(data => {
          localStorage.setItem("token", JSON.stringify(data.token));
          window.location.href = '/page/infoGeral';
        })
        .catch(error => {
          console.log(error);
          errorDiv.innerText = error.message;
          errorDiv.classList.remove('hidden');
          localStorage.setItem("token", JSON.stringify(null));
        });
  });
}

function startup(){
  localStorage.setItem("token", JSON.stringify(null));
  addLoginEvent();
}

startup();
