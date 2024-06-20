<header>
    <nav class="nav-bar">
        <div class="logo">
            <img src="../../source/icons/Avog.svg" alt="">
        </div>
        <div class="nav-list">
            <ul>
                <li class="nav-item"><a href="home.jsp" <%= (request.getRequestURI().endsWith("home.jsp")) || request.getRequestURI().contains("home.jsp?") ? "class='active nav-link'" : "class='nav-link'" %>>
                Home</a></li>
                <li class="nav-item"><a href="evento.jsp" <%= (request.getRequestURI().endsWith("evento.jsp")) || request.getRequestURI().contains("evento.jsp?") ? "class='active nav-link'" : "class='nav-link'" %>>
                Evento</a></li>
                <li class="nav-item"><a href="perfil_usu.jsp" <%= (request.getRequestURI().endsWith("perfil_usu.jsp")) || request.getRequestURI().contains("perfil_usu.jsp?") ? "class='active nav-link'": "class='nav-link'" %>>
                Perfil</a>
                </li>
            </ul>
        </div>

        <div class="login-button">
            <button><a href="../../db/logout.jsp">SAIR</a></button>
        </div>

        <div class="mobile-menu-icon">
            <button onclick="menuShow()"><img class="icon" src="../../source/icons/hamburgue.svg" alt=""></button>
        </div>
    </nav>
    <div class="mobile-menu">
        <ul>
            <li class="nav-item"><a href="perfil_usu.jsp" class="nav-link">Perfil</a></li>
        </ul>
        <div class="login-button">
            <button><a href="../../db/logout.jsp">SAIR</a></button>
        </div>
    </div>
</header>