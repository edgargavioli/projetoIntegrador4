const button_cadastro = document.querySelector('#cadastrar');
const errorDiv = document.querySelector('#error-mensage-login');

function addEventListenersLogon() {
    button_cadastro.addEventListener('click', (event) => {
        event.preventDefault();

        fetch('/logon', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                nome: document.querySelector('#nome').value,
                sobrenome: document.querySelector('#sobrenome').value,
                tipo_usuario: document.querySelector('#tipo_usuario').value,
                email: document.querySelector('#email').value,
                senha: document.querySelector('#senha').value,
                confirmar_senha: document.querySelector('#confirmar-senha').value
            })
        }).then(response => {
            if (response.ok) {
                console.log("DEU CERTO")
                window.location.href = '/page/login';
                return response.json();
            } else {
                return response.text().then(error => {
                    console.log("DEU ERRADO")
                    throw new Error(error.message || "Erro ao realizar login");
                });
            }
        }).catch(error => {
            console.log(error);
            errorDiv.innerText = error.message;
            errorDiv.classList.remove('hidden');
            localStorage.setItem("token", JSON.stringify(null));
        });
    });
}

function startup() {
    localStorage.setItem("token", JSON.stringify(null));
    addEventListenersLogon();
}

startup();