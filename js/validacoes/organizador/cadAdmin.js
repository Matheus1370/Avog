function verificar(){
    Limpar();
    var enviar = true;
    var nome = document.getElementById("nome");
    var email = document.getElementById("email");
    var senha = document.getElementById("senha");
    var cargo = document.getElementById("cargo");

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

    if( cargo.value == ""){
        enviar = false;
        document.querySelector("#errorCargo").textContent = "Selecione um cargo";
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
    document.querySelector("#errorCargo").textContent = "";
}