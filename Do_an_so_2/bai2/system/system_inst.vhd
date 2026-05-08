	component system is
		port (
			clk_clk         : in  std_logic                     := 'X';             -- clk
			hex_hex0        : out std_logic_vector(13 downto 0);                    -- hex0
			hex_hex1        : out std_logic_vector(13 downto 0);                    -- hex1
			hex_hex2        : out std_logic_vector(13 downto 0);                    -- hex2
			reset_reset_n   : in  std_logic                     := 'X';             -- reset_n
			switches_export : in  std_logic_vector(31 downto 0) := (others => 'X')  -- export
		);
	end component system;

	u0 : component system
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --      clk.clk
			hex_hex0        => CONNECTED_TO_hex_hex0,        --      hex.hex0
			hex_hex1        => CONNECTED_TO_hex_hex1,        --         .hex1
			hex_hex2        => CONNECTED_TO_hex_hex2,        --         .hex2
			reset_reset_n   => CONNECTED_TO_reset_reset_n,   --    reset.reset_n
			switches_export => CONNECTED_TO_switches_export  -- switches.export
		);

