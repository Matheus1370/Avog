function menuShow() {
    let menuMobile = document.querySelector('.mobile-menu');
    if (menuMobile.classList.contains('open')) {
        menuMobile.classList.remove('open');
        document.querySelector('.icon').src = "../source/icons/hamburgue.svg";
    } else {
        menuMobile.classList.add('open');
        document.querySelector('.icon').src = "../source/icons/hamburgue-close.svg";
    }
}

function menuShow2() {
    let menuMobile = document.querySelector('.mobile-menu');
    if (menuMobile.classList.contains('open')) {
        menuMobile.classList.remove('open');
        document.querySelector('.icon').src = "../../source/icons/hamburgue.svg";
    } else {
        menuMobile.classList.add('open');
        document.querySelector('.icon').src = "../../source/icons/hamburgue-close.svg";
    }
}