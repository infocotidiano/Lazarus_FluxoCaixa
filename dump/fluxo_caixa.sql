-- MySQL dump 10.15  Distrib 10.0.38-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: fluxo_caixa
-- ------------------------------------------------------
-- Server version	10.0.38-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contas`
--

DROP TABLE IF EXISTS `contas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contas` (
  `id_conta` int(11) NOT NULL,
  `descricao` varchar(80) NOT NULL,
  `banco` varchar(20) DEFAULT NULL,
  `agencia` varchar(15) DEFAULT NULL,
  `conta` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id_conta`),
  KEY `idx_conta_desc` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entidades`
--

DROP TABLE IF EXISTS `entidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entidades` (
  `id_entidade` int(11) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_entidade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lancamentos`
--

DROP TABLE IF EXISTS `lancamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancamentos` (
  `conta` int(11) NOT NULL,
  `id_lcto` int(11) NOT NULL,
  `data_mvto` date NOT NULL,
  `plano` int(11) NOT NULL,
  `descricao` varchar(180) DEFAULT NULL,
  `valor` decimal(15,2) DEFAULT NULL,
  `idbanco` varchar(36) DEFAULT NULL,
  `idReceber` int(11) DEFAULT NULL,
  `idPagar` int(11) DEFAULT NULL,
  PRIMARY KEY (`conta`,`data_mvto`,`id_lcto`),
  KEY `fk_lcto_plano` (`plano`),
  KEY `idx_lcto_idReceber` (`idReceber`),
  KEY `idx_lcto_idPagar` (`idPagar`),
  CONSTRAINT `fk_lcto_conta` FOREIGN KEY (`conta`) REFERENCES `contas` (`id_conta`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_lcto_plano` FOREIGN KEY (`plano`) REFERENCES `planos` (`id_plano`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagar`
--

DROP TABLE IF EXISTS `pagar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagar` (
  `id_pagar` int(11) NOT NULL,
  `descricao` varchar(180) DEFAULT NULL,
  `dtlancamento` date DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `dtvencimento` date DEFAULT NULL,
  `valorpago` decimal(10,2) DEFAULT NULL,
  `situacao` char(1) DEFAULT NULL,
  `plano` int(11) DEFAULT NULL,
  `dtrecebimento` date DEFAULT NULL,
  `codconta` int(11) DEFAULT NULL,
  `entidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pagar`),
  KEY `plano` (`plano`),
  CONSTRAINT `pagar_ibfk_1` FOREIGN KEY (`plano`) REFERENCES `planos` (`id_plano`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `planos`
--

DROP TABLE IF EXISTS `planos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planos` (
  `id_plano` int(11) NOT NULL,
  `descricao` varchar(80) NOT NULL,
  `tipo` char(1) DEFAULT NULL,
  PRIMARY KEY (`id_plano`),
  KEY `idx_plano_desc` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `receber`
--

DROP TABLE IF EXISTS `receber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receber` (
  `id_receber` int(11) NOT NULL,
  `descricao` varchar(180) DEFAULT NULL,
  `dtlancamento` date DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `dtvencimento` date DEFAULT NULL,
  `valorrecebido` decimal(10,2) DEFAULT NULL,
  `situacao` char(1) DEFAULT NULL,
  `plano` int(11) DEFAULT NULL,
  `dtrecebimento` date DEFAULT NULL,
  `codconta` int(11) DEFAULT NULL,
  `entidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_receber`),
  KEY `plano` (`plano`),
  KEY `fk_receber_entidade` (`entidade`),
  CONSTRAINT `fk_receber_entidade` FOREIGN KEY (`entidade`) REFERENCES `entidades` (`id_entidade`),
  CONSTRAINT `receber_ibfk_1` FOREIGN KEY (`plano`) REFERENCES `planos` (`id_plano`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) DEFAULT NULL,
  `senha` varbinary(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `vw_pagar_baixadas`
--

DROP TABLE IF EXISTS `vw_pagar_baixadas`;
/*!50001 DROP VIEW IF EXISTS `vw_pagar_baixadas`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_pagar_baixadas` (
  `dtvencimento` tinyint NOT NULL,
  `id_pagar` tinyint NOT NULL,
  `descricao_pagar` tinyint NOT NULL,
  `valor` tinyint NOT NULL,
  `situacao` tinyint NOT NULL,
  `dtrecebimento` tinyint NOT NULL,
  `valorpago` tinyint NOT NULL,
  `entidade` tinyint NOT NULL,
  `nome` tinyint NOT NULL,
  `codconta` tinyint NOT NULL,
  `descricao_conta` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_pagar_pendentes`
--

DROP TABLE IF EXISTS `vw_pagar_pendentes`;
/*!50001 DROP VIEW IF EXISTS `vw_pagar_pendentes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_pagar_pendentes` (
  `dtvencimento` tinyint NOT NULL,
  `id_pagar` tinyint NOT NULL,
  `descricao_pagar` tinyint NOT NULL,
  `valor` tinyint NOT NULL,
  `situacao` tinyint NOT NULL,
  `dtrecebimento` tinyint NOT NULL,
  `valorpago` tinyint NOT NULL,
  `entidade` tinyint NOT NULL,
  `nome` tinyint NOT NULL,
  `codconta` tinyint NOT NULL,
  `descricao_conta` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_receber_baixadas`
--

DROP TABLE IF EXISTS `vw_receber_baixadas`;
/*!50001 DROP VIEW IF EXISTS `vw_receber_baixadas`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_receber_baixadas` (
  `dtvencimento` tinyint NOT NULL,
  `id_receber` tinyint NOT NULL,
  `descricao_receber` tinyint NOT NULL,
  `valor` tinyint NOT NULL,
  `situacao` tinyint NOT NULL,
  `dtrecebimento` tinyint NOT NULL,
  `valorrecebido` tinyint NOT NULL,
  `entidade` tinyint NOT NULL,
  `nome` tinyint NOT NULL,
  `codconta` tinyint NOT NULL,
  `descricao_conta` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_receber_pendentes`
--

DROP TABLE IF EXISTS `vw_receber_pendentes`;
/*!50001 DROP VIEW IF EXISTS `vw_receber_pendentes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_receber_pendentes` (
  `dtvencimento` tinyint NOT NULL,
  `id_receber` tinyint NOT NULL,
  `descricao_receber` tinyint NOT NULL,
  `valor` tinyint NOT NULL,
  `situacao` tinyint NOT NULL,
  `dtrecebimento` tinyint NOT NULL,
  `valorrecebido` tinyint NOT NULL,
  `entidade` tinyint NOT NULL,
  `nome` tinyint NOT NULL,
  `codconta` tinyint NOT NULL,
  `descricao_conta` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_pagar_baixadas`
--

/*!50001 DROP TABLE IF EXISTS `vw_pagar_baixadas`*/;
/*!50001 DROP VIEW IF EXISTS `vw_pagar_baixadas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`suporte`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_pagar_baixadas` AS select `p`.`dtvencimento` AS `dtvencimento`,`p`.`id_pagar` AS `id_pagar`,`p`.`descricao` AS `descricao_pagar`,`p`.`valor` AS `valor`,`p`.`situacao` AS `situacao`,`p`.`dtrecebimento` AS `dtrecebimento`,`p`.`valorpago` AS `valorpago`,`p`.`entidade` AS `entidade`,`e`.`nome` AS `nome`,`p`.`codconta` AS `codconta`,`c`.`descricao` AS `descricao_conta` from ((`pagar` `p` left join `entidades` `e` on((`e`.`id_entidade` = `p`.`entidade`))) left join `contas` `c` on((`c`.`id_conta` = `p`.`codconta`))) where (`p`.`situacao` = 'B') order by `p`.`dtvencimento` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_pagar_pendentes`
--

/*!50001 DROP TABLE IF EXISTS `vw_pagar_pendentes`*/;
/*!50001 DROP VIEW IF EXISTS `vw_pagar_pendentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`suporte`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_pagar_pendentes` AS select `p`.`dtvencimento` AS `dtvencimento`,`p`.`id_pagar` AS `id_pagar`,`p`.`descricao` AS `descricao_pagar`,`p`.`valor` AS `valor`,`p`.`situacao` AS `situacao`,`p`.`dtrecebimento` AS `dtrecebimento`,`p`.`valorpago` AS `valorpago`,`p`.`entidade` AS `entidade`,`e`.`nome` AS `nome`,`p`.`codconta` AS `codconta`,`c`.`descricao` AS `descricao_conta` from ((`pagar` `p` left join `entidades` `e` on((`e`.`id_entidade` = `p`.`entidade`))) left join `contas` `c` on((`c`.`id_conta` = `p`.`codconta`))) where (`p`.`situacao` = 'P') order by `p`.`dtvencimento` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_receber_baixadas`
--

/*!50001 DROP TABLE IF EXISTS `vw_receber_baixadas`*/;
/*!50001 DROP VIEW IF EXISTS `vw_receber_baixadas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`suporte`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_receber_baixadas` AS select `r`.`dtvencimento` AS `dtvencimento`,`r`.`id_receber` AS `id_receber`,`r`.`descricao` AS `descricao_receber`,`r`.`valor` AS `valor`,`r`.`situacao` AS `situacao`,`r`.`dtrecebimento` AS `dtrecebimento`,`r`.`valorrecebido` AS `valorrecebido`,`r`.`entidade` AS `entidade`,`e`.`nome` AS `nome`,`r`.`codconta` AS `codconta`,`c`.`descricao` AS `descricao_conta` from ((`receber` `r` left join `entidades` `e` on((`e`.`id_entidade` = `r`.`entidade`))) left join `contas` `c` on((`c`.`id_conta` = `r`.`codconta`))) where (`r`.`situacao` = 'B') order by `r`.`dtvencimento` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_receber_pendentes`
--

/*!50001 DROP TABLE IF EXISTS `vw_receber_pendentes`*/;
/*!50001 DROP VIEW IF EXISTS `vw_receber_pendentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`suporte`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_receber_pendentes` AS select `r`.`dtvencimento` AS `dtvencimento`,`r`.`id_receber` AS `id_receber`,`r`.`descricao` AS `descricao_receber`,`r`.`valor` AS `valor`,`r`.`situacao` AS `situacao`,`r`.`dtrecebimento` AS `dtrecebimento`,`r`.`valorrecebido` AS `valorrecebido`,`r`.`entidade` AS `entidade`,`e`.`nome` AS `nome`,`r`.`codconta` AS `codconta`,`c`.`descricao` AS `descricao_conta` from ((`receber` `r` left join `entidades` `e` on((`e`.`id_entidade` = `r`.`entidade`))) left join `contas` `c` on((`c`.`id_conta` = `r`.`codconta`))) where (`r`.`situacao` = 'P') order by `r`.`dtvencimento` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-10  8:34:57
