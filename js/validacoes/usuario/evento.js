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
        mensagem.textContent = 'Participação registrada com sucesso!';
        setTimeout(function() {
            mensagemCard.style.display = 'none';
        }, 3000); // 3 segundos
    }
}
// Definimos a função `selecao` e a tornamos global
function selecao(event, divId) {
    event.preventDefault(); // Previne o comportamento padrão do link

    // Pegar todas as divs com a classe 'evento'
    var divs = document.getElementsByClassName('evento');

    // Ocultar todas as divs
    for (var i = 0; i < divs.length; i++) {
        divs[i].style.display = 'none';
    }

    // Exibir a div selecionada
    var selectedDiv = document.getElementById(divId);
    if (selectedDiv) {
        selectedDiv.style.display = 'block';
    } else {
        console.error('Div não encontrada: ' + divId);
    }
}

// Função para verificar todas as validações antes de enviar o formulário
function verificar() {
    Limpar();
    var enviar = true;

    if (enviar) {
        document.form1.submit();
    }
}
function Limpar() {
}
