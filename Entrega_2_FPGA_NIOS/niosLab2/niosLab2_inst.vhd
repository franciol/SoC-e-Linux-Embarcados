	component niosLab2 is
		port (
			clk_clk       : in  std_logic                    := 'X';             -- clk
			stepm_export  : out std_logic_vector(3 downto 0);                    -- export
			reset_reset_n : in  std_logic                    := 'X';             -- reset_n
			swx_export    : in  std_logic_vector(3 downto 0) := (others => 'X')  -- export
		);
	end component niosLab2;

	u0 : component niosLab2
		port map (
			clk_clk       => CONNECTED_TO_clk_clk,       --   clk.clk
			stepm_export  => CONNECTED_TO_stepm_export,  -- stepm.export
			reset_reset_n => CONNECTED_TO_reset_reset_n, -- reset.reset_n
			swx_export    => CONNECTED_TO_swx_export     --   swx.export
		);

