function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
var emailError = getParameterByName('emailError');
if (emailError === 'true') {
    // Se houver um erro de login, mostra a mensagem de erro
    var errorSpan = document.getElementById('errorEmailURL');
    if (errorSpan) {
    errorSpan.textContent = 'Email já foi cadastrado.';
    errorSpan.style.display = 'flex';
    }
}

function verificar(){
    Limpar();
    var enviar = true;
    var nome = document.getElementById("nome");
    var email = document.getElementById("email");
    var senha = document.getElementById("senha");
    var confrimeSenha = document.getElementById("confirmeSenha");

    if( nome.value.length == 0){
        enviar = false;
        document.querySelector("#errorNome").textContent = "Preencha o campo nome!";
    }

    if( email.value.length == 0){
        enviar = false;
        document.querySelector("#errorEmail").textContent = "Preencha o campo email!";
    }else if(email.value.indexOf("@") < 0 || email.value.includes(".com") == false && email.value.includes(".br") == false){
        enviar = false;
        document.querySelector("#errorEmail").textContent = "Digite um email válido!";
    }

    if( senha.value.length < 8){
        enviar = false;
        document.querySelector("#errorSenha").textContent = "Digite pelo menos 8 caracteres!";
    }

    if(confirmeSenha.value != senha.value){
        enviar = false;
        document.querySelector("#errorConfirmeSenha").textContent = "Digite a mesma senha";
    }

    if(enviar){
        document.form1.submit();
    }

}

function Limpar(){
    document.querySelector("#errorNome").textContent = "";
    document.querySelector("#errorEmail").textContent = "";
    document.querySelector("#errorSenha").textContent = "";
    document.querySelector("#errorConfirmeSenha").textContent = "";

    nome.style.borderBottomColor = "#00ff2a";
    email.style.borderBottomColor = "#00ff2a";
    senha.style.borderBottomColor = "#00ff2a";
    confirmeSenha.style.borderBottomColor = "#00ff2a";
    
}