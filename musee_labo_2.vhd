-------------------------------------------------------------------------------
--
-- musee_labo_2.vhd
--
-- v. 1.0 2020-09-22 Pierre Langlois -- ** CETTE VERSION COMPORTE DES ERREURS **
--
-- Indiquez ici vos différentes versions, selon le cas, mais ne remettez qu'un seul fichier.
--
-- Collaborez avec les autres autant que possible et exploitez toutes les ressources en ligne.
-- Le cas échéant, indiquez clairement vos sources si vous réutilisez du code ou vous inspirez du code ou des idées de quelqu'un d'autre.
-- Si vous réutilisez un bloc de code, spécifiez-le en plus directement dans votre code à l'aide d'un commentaire.
--
-- Ne modifiez pas les noms des fichiers, les noms des entités, les listes des generics, les listes des ports ou les noms des architectures.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity musee_labo_2 is
	generic (
		N : positive := 15
	);
	port (
    detecteurs_mouvement : in std_logic_vector(N - 1 downto 0) ;
    mode : in std_logic ; -- '0' pour mode normal et '1' pour mode patrouille
	alarme_intrus : out std_logic;
	alarme_gardien : out std_logic;
    code_salle : out unsigned(integer(ceil(log2(real(N)))) - 1 downto 0)
	);
end;

architecture arch of musee_labo_2 is

-- votre code ici si nécessaire

begin

-- votre code ici, corrigez l'architecture pour rencontrer les spécifications

    assert N = 15 report "Cette version (1.0) ne fonctionne que pour N = 15" severity failure;

--    -- ne modifiez cette ligne que si vous faites la partie 4
    code_salle <= to_unsigned(N, code_salle'length);
    
--    -- cette ligne ne fonctionne pas correctement
    alarme_intrus <= or(detecteurs_mouvement);
    
--    -- ne vous fiez pas à ce code, il est complètement bidon !
    alarme_gardien <=
        (or(detecteurs_mouvement(3 downto 0) and detecteurs_mouvement(14)))
        or (and(detecteurs_mouvement(7 downto 4) and detecteurs_mouvement(13)))
        or (xor(detecteurs_mouvement(11 downto 8) and detecteurs_mouvement(12)))
        or (nor(detecteurs_mouvement(14 downto 12) and detecteurs_mouvement(11)));

end;

