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
    //futuramente validações com o banco de dados e a requisição da página como,
    // nome digitado é o mesmo que o nome do banco de dados? e o mesmo vale para a senha

    // fazendo também dupla verificação de email e senha vendo se estão 
    //cadastrados na tabela do usuário senão verifica na tabela do 
    //organizador senão retorna mensagem

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