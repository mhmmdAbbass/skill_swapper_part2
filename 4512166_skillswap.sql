-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: fdb1030.awardspace.net
-- Generation Time: Aug 03, 2024 at 04:58 PM
-- Server version: 8.0.32
-- PHP Version: 8.1.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `4512166_skillswap`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `birthday` date NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `birthday`, `phone_number`, `email`, `password`) VALUES
(1, 'mhmd abbass', '0000-00-00', '76764263', 'mohammadabbass123@gmail.com', '$2y$10$hjFA6faPixc7v0meaGHjjO2OL6wPopB5s7MfTV4KrYPPVFl12Js1m'),
(10, 'mhmmd', '0000-00-00', '76764263', 'mohammadbazzi109@gmail.com', '$2y$10$V/KCqaKpW.QjUEfMGc3xPuFfB8ngS/jw6X0ovm8AzFIcgML67AWoe'),
(20, 'mhmd', '0000-00-00', '76764263', 'mohammad123@gmail.com', '$2y$10$XxOTPoAcvRC8d1RP77qEkux4visUo/zmAXK8tGpFkYaBBcS.QRheO'),
(22, 'mhmd', '2004-08-02', '76764263', 'mohammad321@gmail.com', '$2y$10$pIXSaaEEz5i/IUWpVWaWfOidMp.YL5uX8fNGiW8t6y2BGpgLVFC5e'),
(23, 'mhmd', '2005-08-02', '76764263', 'mohammad12345@gmail.com', '$2y$10$NUdG9ZWepmaMEx66adSMRuRSOVcBXsy5vdkFBbHJUi.xx2pNXuGHe'),
(24, 'mhmd', '2000-08-02', '78945612', 'ali123@gmail.com', '$2y$10$1uQ4ixpVfmLsM/AIBURdUuGG2jo5Q/vt6TtdJ0oYJpA8ZjaqarjNe'),
(25, 'qwerty', '2008-08-02', '76764263', 'ali1234@gmail.com', '$2y$10$KHudoasZzgI3dIy5lorIg.hTmXMo1aPObaXa/D2vc4j85nU8TAg4a'),
(30, 'qwert', '2024-08-02', '76764263', 'ali12345#gmail.com', '$2y$10$n9S.PGtHagghlIg7MSXcCuEnXj8xXMIMKXkGgGEUMHtg6Y0SnCSgK'),
(32, 'mhmmd', '2024-08-02', '76764263', 'mohammadbazzi19@gmail.com', '$2y$10$3pKE09s.z5Un3uDMDUb7kOa3r.hNPB6XHfxfx9QyQbPmu38SOjpOu'),
(36, 'mhmmd', '2024-08-02', '76764263', 'mohammd098@gmail.com', '$2y$10$PBg9Vvuu2z2ipsNEv9Zf5eD7ztDB92LFjSwy9mY2bl.IS7yP9BJW.'),
(37, 'ali', '2008-08-03', '7891562', 'ali1234@gmail,com', '$2y$10$SoK7FAdxl/87OUvDuziJdORm/zQkUV5c77vR5N95eRIxlwtJ2EjV6'),
(38, 'mhmmd', '2000-08-03', '789456', 'mhmmd12345@gmail.com', '$2y$10$pnf.VckkAgfnu0BX1qLNuuqL8SXeV3ZSw4IvyE7skFJ4NJyon.UKC');

-- --------------------------------------------------------

--
-- Table structure for table `user_skills`
--

CREATE TABLE `user_skills` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `skill` varchar(255) NOT NULL,
  `bio` text,
  `needed_skill` varchar(255) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `is_paid` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_skills`
--

INSERT INTO `user_skills` (`id`, `user_id`, `skill`, `bio`, `needed_skill`, `cost`, `is_paid`) VALUES
(1, 10, 'cooking', 'i learned cooking in italy', '', 50.00, 1),
(2, 10, 'dancing', 'i love dancing', '', 15.00, 1),
(3, 10, 'skiing', 'no bio', '', 50.00, 1),
(4, 10, 'football', 'i like football', '', 50.00, 1),
(5, 10, 'none', 'none', '', 50.00, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_skills`
--
ALTER TABLE `user_skills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `user_skills`
--
ALTER TABLE `user_skills`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user_skills`
--
ALTER TABLE `user_skills`
  ADD CONSTRAINT `user_skills_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
