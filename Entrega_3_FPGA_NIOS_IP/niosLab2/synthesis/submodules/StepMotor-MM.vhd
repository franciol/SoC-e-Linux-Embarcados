library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.all;

entity StepMotorMM is
    generic (
        LEN  : natural := 4
    );
    port (
        -- Gloabals
        clk                : in  std_logic                     := '0';             
        reset              : in  std_logic                     := '0';             

        -- I/Os
        stepM               : out std_logic_vector(LEN - 1 downto 0) := (others => '0');

        -- Avalion Memmory Mapped Slave
        avs_address     : in  std_logic_vector(3 downto 0)  := (others => '0'); 
        avs_read        : in  std_logic                     := '0';             
        avs_readdata    : out std_logic_vector(31 downto 0) := (others => '0'); 
        avs_write       : in  std_logic                     := '0';             
        avs_writedata   : in  std_logic_vector(31 downto 0) := (others => '0')
    );
end entity StepMotorMM;

architecture rtl of StepMotorMM is
signal dir, en: std_logic := '0';
signal spd : std_logic_vector(31 downto 0); 
signal cur : std_logic_vector(3 downto 0) := (others => '0');
signal timer : integer := 0;
begin
	
  process(clk)
  begin
    if (reset = '1') then
      stepM <= (others => '0');
    elsif(rising_edge(clk)) then
		if(avs_write = '1') then
			-- 0001:en  0002:dir 0003:spd  
			case avs_address is
			when "0001" => en <= avs_writedata(0);
			when "0010" => dir <= avs_writedata(0);
			when "0011" => spd <= avs_writedata;
			when others => null;
				
			end case;
		end if;
		
		if(en = '1') then
			timer <= timer + 1;
			if ( timer > (conv_integer(spd))) then
				timer <= 0;
				
				if(avs_read = '1') then
					avs_readdata <= std_logic_vector(to_unsigned(0, 32));
				end if;
				
				if(dir = '0') then
					case cur is
					when "0000" => cur <= "0001";
					when "0001" => cur <= "0010";
					when "0010" => cur <= "0100";
					when "0100" => cur <= "1000";
					when "1000" => cur <= "0001";
					when others => cur <= "0000";
					end case;
				else
					case cur is
					when "0000" => cur <= "1000";
					when "0001" => cur <= "1000";
					when "0010" => cur <= "0001";
					when "0100" => cur <= "0010";
					when "1000" => cur <= "0100";
					when others => cur <= "0000";
					end case;
				end if;
				stepM <= cur;
			end if;
		end if;
	end if;
	end process;

end rtl;