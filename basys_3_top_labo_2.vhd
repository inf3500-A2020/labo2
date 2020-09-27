---------------------------------------------------------------------------------------------------
-- 
-- basys_3_top_labo_2.vhd
--
-- Pierre Langlois
-- v. 2.0, 2020/09/27 pour le laboratoire #2, le problème du musée
--
-- Digilent Basys 3 Artix-7 FPGA Trainer Board 
--
---------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;  
use work.inf3500_utilitaires_pkg.all;
use work.all;


entity basys_3_top_labo_2 is
    port(
        clk : in std_logic; -- l'horloge de la carte à 100 MHz
        sw : in std_logic_vector(15 downto 0); -- les 16 commutateurs
        led : out std_logic_vector(15 downto 0); -- les 16 LED
        seg : out std_logic_vector(7 downto 0); -- les cathodes partagées des quatre symboles à 7 segments + point
        an : out std_logic_vector(3 downto 0) -- les anodes des quatre symboles à 7 segments + point
    );
end;

architecture arch of basys_3_top_labo_2 is

signal lecode : unsigned(3 downto 0);
signal lecode_BCD3 : BCD3;

signal symboles : quatre_symboles;

begin

	UUT : entity musee_labo_2(arch)
        generic map (N => 15)
        port map (
            detecteurs_mouvement => sw(14 downto 0),
            mode => sw(15),
            alarme_intrus => led(0),
            alarme_gardien => led(1),
            code_salle => lecode
            );
            
    lecode_BCD3 <= unsigned_2_BCD(resize(lecode, 10));
    symboles <= (hex_2_7seg(to_unsigned(0, 4)), hex_2_7seg(to_unsigned(0, 4)), hex_2_7seg(lecode_BCD3(7 downto 4)), hex_2_7seg(lecode_BCD3(3 downto 0)));
        
   -- Circuit pour sérialiser l'accès aux quatre symboles à 7 segments.
   -- L'affichage contient quatre symboles chacun composé de sept segments et d'un point.
    process(all)
	variable clkCount : unsigned(19 downto 0) := (others => '0');
	begin
        if (clk'event and clk = '1') then
			clkCount := clkCount + 1;		   
		end if;
		case clkCount(clkCount'left downto clkCount'left - 1) is 	-- L'horloge de 100 MHz est ramenée à environ 100 Hz en la divisant par 2^19
			when "00" => an <= "1110"; seg <= symboles(0);
			when "01" => an <= "1101"; seg <= symboles(1);
			when "10" => an <= "1011"; seg <= symboles(2);
			when others => an <= "0111"; seg <= symboles(3);
		end case;
    end process;
        
end arch;