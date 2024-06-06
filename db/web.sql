-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 06/06/2024 às 02:13
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `web`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `atividade`
--

CREATE TABLE `atividade` (
  `id_ativ` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `descricao` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `atividade`
--

INSERT INTO `atividade` (`id_ativ`, `nome`, `descricao`) VALUES
(1, 'Jogador', 'Participa das partidas'),
(2, 'Juiz', 'Ordena as partidas'),
(3, 'Ajudante', 'ajuda no recolhimento e distribuição dos alimentos'),
(4, 'Coordenador', 'Gerencia todo o evento');

-- --------------------------------------------------------

--
-- Estrutura para tabela `atividadeevento`
--

CREATE TABLE `atividadeevento` (
  `id_ativEvento` int(11) NOT NULL,
  `atividade` int(11) NOT NULL,
  `evento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cargo`
--

CREATE TABLE `cargo` (
  `id_cargo` int(11) NOT NULL,
  `nome` varchar(30) DEFAULT NULL,
  `descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cargo`
--

INSERT INTO `cargo` (`id_cargo`, `nome`, `descricao`) VALUES
(1, 'Presidente', 'Presidente'),
(2, 'Vice', 'Vice'),
(3, 'Secretário', 'Secretário');

-- --------------------------------------------------------

--
-- Estrutura para tabela `doacao`
--

CREATE TABLE `doacao` (
  `id_doacao` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `fundo_financeiro` int(11) NOT NULL,
  `datahora` date NOT NULL DEFAULT current_timestamp(),
  `formapag` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `evento`
--

CREATE TABLE `evento` (
  `id_evento` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `descricao` text NOT NULL,
  `data` date NOT NULL,
  `hora` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `fundo_financeiro`
--

CREATE TABLE `fundo_financeiro` (
  `id_finan` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `montante` double(10,8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `organizador`
--

CREATE TABLE `organizador` (
  `id_org` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `senha` varchar(50) DEFAULT NULL,
  `cargo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `organizadorevento`
--

CREATE TABLE `organizadorevento` (
  `id_orgEvento` int(11) NOT NULL,
  `organizador` int(11) NOT NULL,
  `evento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `organizadorfinanceiro`
--

CREATE TABLE `organizadorfinanceiro` (
  `id_orgFinan` int(11) NOT NULL,
  `organizador` int(11) NOT NULL,
  `fundo_financeiro` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `id_usu` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `senha` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarioevento`
--

CREATE TABLE `usuarioevento` (
  `id_usuEvento` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `evento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `atividade`
--
ALTER TABLE `atividade`
  ADD PRIMARY KEY (`id_ativ`);

--
-- Índices de tabela `atividadeevento`
--
ALTER TABLE `atividadeevento`
  ADD PRIMARY KEY (`id_ativEvento`),
  ADD KEY `fk_atividade_atividadeevento` (`atividade`),
  ADD KEY `fk_evento_atividadeevento` (`evento`);

--
-- Índices de tabela `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id_cargo`);

--
-- Índices de tabela `doacao`
--
ALTER TABLE `doacao`
  ADD PRIMARY KEY (`id_doacao`),
  ADD KEY `fk_usuario_doacao` (`usuario`),
  ADD KEY `fk_fundo_financeiro_doacao` (`fundo_financeiro`);

--
-- Índices de tabela `evento`
--
ALTER TABLE `evento`
  ADD PRIMARY KEY (`id_evento`);

--
-- Índices de tabela `fundo_financeiro`
--
ALTER TABLE `fundo_financeiro`
  ADD PRIMARY KEY (`id_finan`);

--
-- Índices de tabela `organizador`
--
ALTER TABLE `organizador`
  ADD PRIMARY KEY (`id_org`),
  ADD KEY `fk_cargo_organizador` (`cargo`);

--
-- Índices de tabela `organizadorevento`
--
ALTER TABLE `organizadorevento`
  ADD PRIMARY KEY (`id_orgEvento`),
  ADD KEY `fk_organizador_organizadoEvento` (`organizador`),
  ADD KEY `fk_evento_organizadorEvento` (`evento`);

--
-- Índices de tabela `organizadorfinanceiro`
--
ALTER TABLE `organizadorfinanceiro`
  ADD PRIMARY KEY (`id_orgFinan`),
  ADD KEY `fk_organizador_organizadoFinanceiro` (`organizador`),
  ADD KEY `fk_fundo_financeiro_organizadorFinanceiro` (`fundo_financeiro`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usu`);

--
-- Índices de tabela `usuarioevento`
--
ALTER TABLE `usuarioevento`
  ADD KEY `fk_usuario_usuarioevento` (`usuario`),
  ADD KEY `fk_evento_usuarioevento` (`evento`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `atividade`
--
ALTER TABLE `atividade`
  MODIFY `id_ativ` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `atividadeevento`
--
ALTER TABLE `atividadeevento`
  MODIFY `id_ativEvento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id_cargo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `doacao`
--
ALTER TABLE `doacao`
  MODIFY `id_doacao` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `evento`
--
ALTER TABLE `evento`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `fundo_financeiro`
--
ALTER TABLE `fundo_financeiro`
  MODIFY `id_finan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `organizador`
--
ALTER TABLE `organizador`
  MODIFY `id_org` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `organizadorevento`
--
ALTER TABLE `organizadorevento`
  MODIFY `id_orgEvento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `organizadorfinanceiro`
--
ALTER TABLE `organizadorfinanceiro`
  MODIFY `id_orgFinan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usu` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `atividadeevento`
--
ALTER TABLE `atividadeevento`
  ADD CONSTRAINT `fk_atividade_atividadeevento` FOREIGN KEY (`atividade`) REFERENCES `atividade` (`id_ativ`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_evento_atividadeevento` FOREIGN KEY (`evento`) REFERENCES `evento` (`id_evento`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para tabelas `doacao`
--
ALTER TABLE `doacao`
  ADD CONSTRAINT `fk_fundo_financeiro_doacao` FOREIGN KEY (`fundo_financeiro`) REFERENCES `fundo_financeiro` (`id_finan`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_doacao` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id_usu`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para tabelas `organizador`
--
ALTER TABLE `organizador`
  ADD CONSTRAINT `fk_cargo_organizador` FOREIGN KEY (`cargo`) REFERENCES `cargo` (`id_cargo`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para tabelas `organizadorevento`
--
ALTER TABLE `organizadorevento`
  ADD CONSTRAINT `fk_evento_organizadorEvento` FOREIGN KEY (`evento`) REFERENCES `evento` (`id_evento`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_organizador_organizadoEvento` FOREIGN KEY (`organizador`) REFERENCES `organizador` (`id_org`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para tabelas `organizadorfinanceiro`
--
ALTER TABLE `organizadorfinanceiro`
  ADD CONSTRAINT `fk_fundo_financeiro_organizadorFinanceiro` FOREIGN KEY (`fundo_financeiro`) REFERENCES `fundo_financeiro` (`id_finan`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_organizador_organizadoFinanceiro` FOREIGN KEY (`organizador`) REFERENCES `organizador` (`id_org`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para tabelas `usuarioevento`
--
ALTER TABLE `usuarioevento`
  ADD CONSTRAINT `fk_evento_usuarioevento` FOREIGN KEY (`evento`) REFERENCES `evento` (`id_evento`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_usuarioevento` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id_usu`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
