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
    var nomeInput = document.getElementById('nome');
    var nome = nomeInput.value.trim();
    var descricaoInput = document.getElementById('descricao');
    var descricao = descricaoInput.value.trim();
    var dataInput = document.getElementById('data');
    var data = dataInput.value.trim();
    var horaInput = document.getElementById('hora');
    var hora = horaInput.value.trim();


    // Função para validar o campo de nome
    if (nome === '') {
        enviar = false;
        document.querySelector('#errorNome').textContent = 'Por favor, insira seu nome.';
        nomeInput.focus();
    }
    // Função para validar o campo de descrição
    if (descricao === '') {
        enviar = false;
        document.querySelector('#errorDescricao').textContent = 'Por favor, insira uma descrição.';
        descricaoInput.focus();
    }

    // Função para validar o campo de data
    if (data === '') {
        enviar = false;
        document.querySelector('#errorData').textContent = 'Por favor, insira a data do evento.';
        dataInput.focus();
    }

    // Função para validar o campo de hora
    if (hora === '') {
        enviar = false;
        document.querySelector('#errorHora').textContent = 'Por favor, insira a hora do evento.';
        horaInput.focus();
    }

    if (enviar) {
        document.form1.submit();
    }
}
function Limpar() {
    document.querySelector("#errorNome").textContent = "";
    document.querySelector("#errorDescricao").textContent = "";
    document.querySelector("#errorData").textContent = "";
    document.querySelector("#errorHora").textContent = "";
}
