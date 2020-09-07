--
-- Rafael C.
-- ref:
--   - https://www.intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjects/hdl/vhdl/vhdl_pro_state_machines.htm
--   - https://www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl/
--   - https://www.digikey.com/eewiki/pages/viewpage.action?pageId=4096117

library IEEE;
use IEEE.std_logic_1164.all;

entity stepmotor is
    port (
        -- Gloabals
        clk   : in  std_logic;

        -- controls
        en      : in std_logic;                     -- 1 on/ 0 of
        dir     : in std_logic;                     -- 1 clock wise
        vel     : in std_logic_vector(1 downto 0);  -- 00: low / 11: fast

        -- I/Os
        phases  : out std_logic_vector(3 downto 0)
  );
end entity stepmotor;

architecture rtl of stepmotor is

   TYPE STATE_TYPE IS (s0, s1, s2, s3);
   SIGNAL state  : STATE_TYPE := s0;
   signal enable : std_logic  := '0';
   signal topCounter : integer range 0 to 50000000;
	signal movableCounter : integer range 0 to 50000000 := 50000000;
	signal moveTo : integer range 0 to 8000 := 0;
  
begin

  process(clk)
  begin
	  if(en = '0') then
	  
		 if (rising_edge(clk)) then
			CASE dir IS
			
			WHEN '0'=> 
				CASE state IS
				WHEN s0=>
				  if (enable = '1') then
					 state <= s1;
				  end if;
				WHEN s1=>
				  if (enable = '1') then
					 state <= s2;
				  end if;
				WHEN s2=>
				  if (enable = '1') then
					 state <= s3;
				  end if;
				WHEN s3=>
				  if (enable = '1') then
					 state <= s0;
				  end if;
				when others=>
				  state <= s0;
				END CASE;
				
			WHEN '1'=>
				CASE state IS
				WHEN s0=>
				  if (enable = '1') then
					 state <= s3;
				  end if;
				WHEN s1=>
				  if (enable = '1') then
					 state <= s0;
				  end if;
				WHEN s2=>
				  if (enable = '1') then
					 state <= s1;
				  end if;
				WHEN s3=>
				  if (enable = '1') then
					 state <= s2;
				  end if;
				when others=>
				  state <= s0;
				END CASE;
			END CASE;
		 
		 end if;
		 
		 
			
		 
		end if;
		
  end process;

  PROCESS (state)
   BEGIN
      CASE state IS
        WHEN s0 =>
          phases <= "0001";
        WHEN s1 =>
          phases <= "0010";
        WHEN s2 =>
          phases <= "0100";
        when s3 =>
          phases <= "1000";
        when others =>
          phases <= "0000";
      END CASE;
   END PROCESS;

  topCounter <= 10000000 when vel = "00" else
					5000000 when vel = "01" else
					1000000 when vel = "10" else
                  100000;

  process(clk)
    variable counter : integer range 0 to 50000000 := 0;
  begin
  
    if (rising_edge(clk)) then
      
		if (counter < movableCounter) then
        counter := counter + 1;
        enable  <= '0';
      else
		  if(movableCounter < topCounter) then
				movableCounter <= movableCounter + ((topCounter-movableCounter)/4);
			elsif (movableCounter > topCounter) then
				movableCounter <= movableCounter + ((topCounter-movableCounter)/4);
			end if;
        counter := 0;
		  CASE dir IS
		  WHEN '0'=>
			if(moveTo<3600) then
				enable  <= '1';
				moveTo <= 1+moveTo;
			end if;
			WHEN '1'=>
				if(moveTo>0) then
				
				enable  <= '1';
				moveTo <= moveTo-1;
			end if;
			end CASE;
			
		end if;
		
	 end if;
  end process;

end rtl;
