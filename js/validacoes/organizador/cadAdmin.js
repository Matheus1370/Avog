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
var mostrarCard = getParameterByName('mostrarCard');
if (mostrarCard === 'true') {
    // Se houver um erro de login, mostra a mensagem de erro
    var mensagemCard = document.getElementById('mensagemCard');
    if (mensagemCard) {
        mensagemCard.style.display = 'flex';
        var mensagem= document.getElementById('mensagem');
        mensagem.textContent = 'Cadastro realizado com sucesso!';
        setTimeout(function() {
            mensagemCard.style.display = 'none';
        }, 3000); // 3 segundos
    }
}

function verificar(){
    Limpar();
    var enviar = true;
    var nome = document.getElementById("nome");
    var email = document.getElementById("email");
    var senha = document.getElementById("senha");
    var confirmeSenha = document.getElementById("confirmeSenha");
    var cargo = document.getElementById("cargo");

    if( nome.value.length == 0){
        enviar = false;
        document.querySelector("#errorNome").textContent = "Preencha o campo nome!";
        nome.style.borderBottomColor = "red";
    }

    if( email.value.length == 0){
        enviar = false;
        document.querySelector("#errorEmail").textContent = "Preencha o campo email!";
        email.style.borderBottomColor = "red";
    }else if(email.value.indexOf("@") < 0 || email.value.includes(".com") == false && email.value.includes(".br") == false){
        enviar = false;
        document.querySelector("#errorEmail").textContent = "Digite um email válido!";
        email.style.borderBottomColor = "red";
    }

    if( senha.value.length < 8){
        enviar = false;
        document.querySelector("#errorSenha").textContent = "Digite pelo menos 8 caracteres!";
        senha.style.borderBottomColor = "red";
    }

    if(confirmeSenha.value.length < 8){
        enviar = false;
        document.querySelector("#errorConfirmeSenha").textContent = "Digite pelo menos 8 caracteres!";
        confirmeSenha.style.borderBottomColor = "red";
    }else if(confirmeSenha.value != senha.value){
        enviar = false;
        document.querySelector("#errorConfirmeSenha").textContent = "Digite a mesma senha";
        confirmeSenha.style.borderBottomColor = "red";
    }

    if( cargo.value == "" || cargo.value == "0"){
        enviar = false;
        document.querySelector("#errorCargo").textContent = "Selecione um cargo";
        cargo.style.borderBottomColor = "red";
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
    document.querySelector("#errorCargo").textContent = "";

    
}