	component system is
		port (
			clk_clk                          : in  std_logic                    := 'X'; -- clk
			hex_0_external_connection_export : out std_logic_vector(7 downto 0);        -- export
			hex_1_external_connection_export : out std_logic_vector(7 downto 0);        -- export
			hex_2_external_connection_export : out std_logic_vector(7 downto 0);        -- export
			hex_3_external_connection_export : out std_logic_vector(7 downto 0);        -- export
			hex_4_external_connection_export : out std_logic_vector(7 downto 0);        -- export
			hex_5_external_connection_export : out std_logic_vector(7 downto 0)         -- export
		);
	end component system;

	u0 : component system
		port map (
			clk_clk                          => CONNECTED_TO_clk_clk,                          --                       clk.clk
			hex_0_external_connection_export => CONNECTED_TO_hex_0_external_connection_export, -- hex_0_external_connection.export
			hex_1_external_connection_export => CONNECTED_TO_hex_1_external_connection_export, -- hex_1_external_connection.export
			hex_2_external_connection_export => CONNECTED_TO_hex_2_external_connection_export, -- hex_2_external_connection.export
			hex_3_external_connection_export => CONNECTED_TO_hex_3_external_connection_export, -- hex_3_external_connection.export
			hex_4_external_connection_export => CONNECTED_TO_hex_4_external_connection_export, -- hex_4_external_connection.export
			hex_5_external_connection_export => CONNECTED_TO_hex_5_external_connection_export  -- hex_5_external_connection.export
		);

