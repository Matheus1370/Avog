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
    return false; // Impede a navegação do link
}

// Função para validar o campo de nome
function validarNome() {
    var nomeInput = document.getElementById('nome');
    var nome = nomeInput.value.trim();
    var errorSpan = document.getElementById('errorNome');

    if (nome === '') {
        errorSpan.textContent = 'Por favor, insira seu nome.';
        nomeInput.focus();
        return false;
    } else {
        errorSpan.textContent = '';
        return true;
    }
}

// Função para validar o campo de descrição
function validarDescricao() {
    var descricaoInput = document.getElementById('descricao');
    var descricao = descricaoInput.value.trim();
    var errorSpan = document.getElementById('errorDescricao');

    if (descricao === '') {
        errorSpan.textContent = 'Por favor, insira uma descrição.';
        descricaoInput.focus();
        return false;
    } else {
        errorSpan.textContent = '';
        return true;
    }
}

// Função para validar o campo de data
function validarData() {
    var dataInput = document.getElementById('data');
    var data = dataInput.value.trim();
    var errorSpan = document.getElementById('errorData');

    if (data === '') {
        errorSpan.textContent = 'Por favor, insira a data do evento.';
        dataInput.focus();
        return false;
    } else {
        errorSpan.textContent = '';
        return true;
    }
}

// Função para validar o campo de hora
function validarHora() {
    var horaInput = document.getElementById('hora');
    var hora = horaInput.value.trim();
    var errorSpan = document.getElementById('errorHora');

    if (hora === '') {
        errorSpan.textContent = 'Por favor, insira a hora do evento.';
        horaInput.focus();
        return false;
    } else {
        errorSpan.textContent = '';
        return true;
    }
}

// Função para verificar todas as validações antes de enviar o formulário
function verificar() {
    var nomeValido = validarNome();
    var descricaoValida = validarDescricao();
    var dataValida = validarData();
    var horaValida = validarHora();

    return nomeValido && descricaoValida && dataValida && horaValida;
}
