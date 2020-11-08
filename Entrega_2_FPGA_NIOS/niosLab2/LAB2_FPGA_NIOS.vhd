library IEEE;
use IEEE.std_logic_1164.all;

entity LAB2_FPGA_NIOS is
    port (
        -- Gloabals
        fpga_clk_50        : in  std_logic;             -- clock.clk

        -- I/Os
        fpga_led_pio       : out std_logic_vector(5 downto 0);
        stepm_en  : in  std_logic;
        stepm_dir : in  std_logic;
		  stepm_vel : in  std_logic_vector(1 downto 0);
        stepm_pio : out std_logic_vector(3 downto 0)
  );
end entity LAB2_FPGA_NIOS;

architecture rtl of LAB2_FPGA_NIOS is

    component niosLab2 is
        port (
            clk_clk       : in  std_logic;             -- clk
            reset_reset_n : in  std_logic;             -- reset_n
            swx_export : in  std_logic_vector(3 downto 0);  -- export
				stepm_export  : out std_logic_vector(3 downto 0)
        );
    end component niosLab2;

begin

u0 : component niosLab2 port map (
  clk_clk       => fpga_clk_50,    --  clk.clk
  reset_reset_n => '1',            --  reset.reset_n999999999999999
  swx_export(0) => stepm_en,  -- switch.export
  swx_export(1) => stepm_dir,
  swx_export(3 downto 2) => stepm_vel,
  stepm_export  => stepm_pio   --  motor.export
);

end rtl;
