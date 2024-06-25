<header>
    <nav class="nav-bar">
        <div class="logo">
            <a href="perfil_org.jsp"><img src="../../source/icons/peoples.svg" alt=""></a>
        </div>
        <div class="nav-list">
            <ul>
                <!-- endWith: verifica se no final existe "nome da página"
                     contains: verifica se contêm "nome da página"
                 -->
                <li class="nav-item"><a href="home.jsp" <%= (request.getRequestURI().endsWith("home.jsp")) || request.getRequestURI().contains("home.jsp?") ? "class='active nav-link'" : "class='nav-link'" %>>
                Home</a></li>
                <li class="nav-item"><a href="evento.jsp" <%= (request.getRequestURI().endsWith("evento.jsp")) || request.getRequestURI().contains("evento.jsp?") ? "class='active nav-link'" : "class='nav-link'" %>>
                Evento</a></li>
                <li class="nav-item"><a href="cadAdmin.jsp" <%= (request.getRequestURI().endsWith("cadAdmin.jsp")) || request.getRequestURI().contains("cadAdmin.jsp?") ? "class='active nav-link'": "class='nav-link'" %>>
                Cadastro</a>
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
            <!-- endWith: verifica se no final existe "nome da página"
                    contains: verifica se contêm "nome da página"
                -->
            <li class="nav-item"><a href="home.jsp" <%= (request.getRequestURI().endsWith("home.jsp")) || request.getRequestURI().contains("home.jsp?") ? "class='active nav-link'" : "class='nav-link'" %>>
            Home</a></li>
            <li class="nav-item"><a href="evento.jsp" <%= (request.getRequestURI().endsWith("evento.jsp")) || request.getRequestURI().contains("evento.jsp?") ? "class='active nav-link'" : "class='nav-link'" %>>
            Evento</a></li>
            <li class="nav-item"><a href="perfil_org.jsp" <%= (request.getRequestURI().endsWith("perfil_org.jsp")) || request.getRequestURI().contains("perfil_org.jsp?") ? "class='active nav-link'": "class='nav-link'" %>>
            Perfil</a>
            </li>
            <li class="nav-item"><a href="cadAdmin.jsp" <%= (request.getRequestURI().endsWith("cadAdmin.jsp")) || request.getRequestURI().contains("cadAdmin.jsp?") ? "class='active nav-link'": "class='nav-link'" %>>
            Cadastro</a>
            </li>
        </ul>
        <div class="login-button">
            <button><a href="../../db/logout.jsp">SAIR</a></button>
        </div>
    </div>
</header>