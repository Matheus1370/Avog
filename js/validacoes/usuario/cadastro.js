function verificar(){
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
    }else if(email.value.indexOf("@") < 0){
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