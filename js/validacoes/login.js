function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
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
var loginError = getParameterByName('loginError');
if (loginError === 'true') {
// Se houver um erro de login, mostra a mensagem de erro
var errorSpan = document.getElementById('errorLogin');
if (errorSpan) {
errorSpan.textContent = 'Email ou senha incorretos.';
errorSpan.style.display = 'flex';
errorSpan.style.justifyContent = 'center';
errorSpan.style.fontSize = '15px';
}
}
function verificar(){
    Limpar();
    var enviar = true;
    var email = document.getElementById("email");
    var senha = document.getElementById("senha");

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

    if(enviar){
        document.form1.submit();
    }

}

function Limpar(){
    document.querySelector("#errorEmail").textContent = "";
    document.querySelector("#errorSenha").textContent = "";

    email.style.borderBottomColor = "#00ff2a";
    senha.style.borderBottomColor = "#00ff2a";
    
}