---------------------------------------------
--
-- musee_labo_2_tb
--
-- v. 1.0 2020-09-22 Pierre Langlois *** Cette version est incomplète ***
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
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.all;

entity musee_labo_2_tb is
	generic (
		N_tb : positive := 15
	);
end entity;

architecture arch of musee_labo_2_tb is
	
type mode_alarme_type is (normal, patrouille);
   
signal detecteurs_mouvement_tb : std_logic_vector(N_tb - 1 downto 0) ;
signal mode_tb : std_logic ; -- '0' pour mode normal et '1' pour mode patrouille
signal alarme_intrus_tb : std_logic;
signal alarme_gardien_tb : std_logic;
signal code_salle_tb : unsigned(integer(ceil(log2(real(N_tb)))) - 1 downto 0);

-- vos définitions de fonctions ici

function verif_alarme_intrus(lesdetecteurs : std_logic_vector; lemode : mode_alarme_type) return boolean is
-- votre code ici
begin
-- votre code ici
    return false;
end;
    
function verif_alarme_gardien(lesdetecteurs : std_logic_vector; lemode : mode_alarme_type) return boolean is
-- votre code ici
begin
-- votre code ici
    return false;
end;
    
begin

	-- instanciation du module à vérifier UUT (Unit Under Test)
    -- ne modifiez pas ce code
	UUT : entity musee_labo_2(arch)
        generic map (N => N_tb)
        port map (
            detecteurs_mouvement => detecteurs_mouvement_tb,
            mode => mode_tb,
            alarme_intrus => alarme_intrus_tb,
            alarme_gardien => alarme_gardien_tb,
            code_salle => code_salle_tb
            );
	
    -- Ne vous fiez au code qui suit, il est complètement bidon. On demande de faire un test exhaustif. Suivez plutôt un exemple donné dans les notes de cours.
    mode_tb <= '0' after 0 ns, '1' after 100 ns;
    detecteurs_mouvement_tb <=
        "000000000000000" after 0 ns, "000000000000001" after 10 ns, "000000000000010" after 20 ns, "000000000000011" after 30 ns, "000000000000100" after 40 ns,
        "000000000000000" after 100 ns, "000000000000001" after 110 ns, "000000000000010" after 120 ns, "000000000000011" after 130 ns, "000000000000100" after 140 ns;

end arch;