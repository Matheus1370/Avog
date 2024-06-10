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
