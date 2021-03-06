-- -------------------------------------------------------------
--
-- Module: filter30
-- Generated by MATLAB(R) 8.6 and the Filter Design HDL Coder 2.10.
-- Generated on: 2021-03-17 14:33:42
-- -------------------------------------------------------------

-- -------------------------------------------------------------
-- HDL Code Generation Options:
--
-- TargetLanguage: VHDL
-- FoldingFactor: 6
-- OptimizeForHDL: on
-- TargetDirectory: -
-- AddPipelineRegisters: on
-- Name: filter30
-- TestBenchStimulus: step ramp chirp 

-- Filter Specifications:
--
-- Sample Rate   : N/A (normalized frequency)
-- Response      : Lowpass
-- Specification : N,F3dB
-- Filter Order  : 6
-- 3-dB Point    : 0.25
-- -------------------------------------------------------------

-- -------------------------------------------------------------
-- HDL Implementation    : Partly Serial
-- Multipliers           : 3
-- Folding Factor        : 6
-- -------------------------------------------------------------
-- Filter Settings:
--
-- Discrete-Time IIR Filter (real)
-- -------------------------------
-- Filter Structure    : Direct-Form II, Second-Order Sections
-- Number of Sections  : 3
-- Stable              : Yes
-- Linear Phase        : No
-- Arithmetic          : fixed
-- Numerator           : s32,29 -> [-4 4)
-- Denominator         : s32,30 -> [-2 2)
-- Scale Values        : s32,34 -> [-1.250000e-01 1.250000e-01)
-- Input               : s10,9 -> [-1 1)
-- Section Input       : s10,9 -> [-1 1)
-- Section Output      : s10,9 -> [-1 1)
-- Output              : s10,9 -> [-1 1)
-- State               : s10,9 -> [-1 1)
-- Numerator Prod      : s42,38 -> [-8 8)
-- Denominator Prod    : s42,39 -> [-4 4)
-- Numerator Accum     : s32,31 -> [-1 1)
-- Denominator Accum   : s32,31 -> [-1 1)
-- Round Mode          : convergent
-- Overflow Mode       : saturate
-- Cast Before Sum     : true
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

ENTITY filter30 IS
   PORT( clk                             :   IN    std_logic; 
         clk_enable                      :   IN    std_logic; 
         reset                           :   IN    std_logic; 
         filter_in                       :   IN    std_logic_vector(9 DOWNTO 0); -- sfix10_En9
         filter_out                      :   OUT   std_logic_vector(9 DOWNTO 0)  -- sfix10_En9
         );

END filter30;


----------------------------------------------------------------
--Module Architecture: filter30
----------------------------------------------------------------
ARCHITECTURE rtl OF filter30 IS
  -- Local Functions
  -- Type Definitions
  TYPE delay_pipeline_type IS ARRAY (NATURAL range <>) OF signed(9 DOWNTO 0); -- sfix10_En9
  -- Constants
  CONSTANT scaleconst1                    : signed(40 DOWNTO 0) := to_signed(2126717311, 41); -- sfix41_En34
  CONSTANT coeff_b1_section1              : signed(40 DOWNTO 0) := (34 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT coeff_b2_section1              : signed(40 DOWNTO 0) := (35 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT coeff_b3_section1              : signed(40 DOWNTO 0) := (34 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT coeff_a2_section1              : signed(40 DOWNTO 0) := (40 DOWNTO 35 => '1', 33 DOWNTO 32 => '1', 29 DOWNTO 28 => '1', 26 DOWNTO 21 => '1', 13 => '1', 11 => '1', 7 DOWNTO 6 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT coeff_a3_section1              : signed(40 DOWNTO 0) := (33 => '1', 31 DOWNTO 30 => '1', 25 DOWNTO 24 => '1', 21 => '1', 19 DOWNTO 18 => '1', 14 => '1', 12 DOWNTO 10 => '1', 8 => '1', 5 DOWNTO 4 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT scaleconst2                    : signed(40 DOWNTO 0) := to_signed(1677289061, 41); -- sfix41_En34
  CONSTANT coeff_b1_section2              : signed(40 DOWNTO 0) := (34 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT coeff_b2_section2              : signed(40 DOWNTO 0) := (35 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT coeff_b3_section2              : signed(40 DOWNTO 0) := (34 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT coeff_a2_section2              : signed(40 DOWNTO 0) := (40 DOWNTO 34 => '1', 29 DOWNTO 27 => '1', 25 => '1', 23 => '1', 20 => '1', 14 => '1', 10 => '1', 6 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT coeff_a3_section2              : signed(40 DOWNTO 0) := (32 => '1', 30 => '1', 28 => '1', 26 => '1', 24 => '1', 22 => '1', 20 => '1', 18 => '1', 16 => '1', 14 => '1', 12 => '1', 10 => '1', 8 => '1', 6 => '1', 4 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT scaleconst3                    : signed(40 DOWNTO 0) := to_signed(1494898755, 41); -- sfix41_En34
  CONSTANT coeff_b1_section3              : signed(40 DOWNTO 0) := (34 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT coeff_b2_section3              : signed(40 DOWNTO 0) := (35 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT coeff_b3_section3              : signed(40 DOWNTO 0) := (34 => '1',  OTHERS => '0'); -- sfix41_En34
  CONSTANT coeff_a2_section3              : signed(40 DOWNTO 0) := (33 DOWNTO 32 => '0', 30 => '0', 28 DOWNTO 26 => '0', 22 DOWNTO 20 => '0', 18 => '0', 13 => '0', 11 DOWNTO 10 => '0', 7 => '0', 5 DOWNTO 0 => '0',  OTHERS => '1'); -- sfix41_En34
  CONSTANT coeff_a3_section3              : signed(40 DOWNTO 0) := (31 DOWNTO 30 => '1', 23 DOWNTO 22 => '1', 20 DOWNTO 18 => '1', 16 DOWNTO 15 => '1', 11 DOWNTO 10 => '1', 8 DOWNTO 6 => '1', 4 => '1',  OTHERS => '0'); -- sfix41_En34
  -- Signals
  SIGNAL input_register                   : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL cur_count                        : unsigned(2 DOWNTO 0); -- ufix3
  SIGNAL phase_0                          : std_logic; -- boolean
  SIGNAL phase_1                          : std_logic; -- boolean
  SIGNAL phase_2                          : std_logic; -- boolean
  SIGNAL phase_3                          : std_logic; -- boolean
  SIGNAL phase_4                          : std_logic; -- boolean
  SIGNAL phase_5                          : std_logic; -- boolean
  SIGNAL storagetypeconvert               : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL prev_stg_op1                     : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL prev_stg_op2                     : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL storage_state_in1                : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL delay_section1                   : delay_pipeline_type(0 TO 1); -- sfix10_En9
  SIGNAL storage_state_in2                : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL delay_section2                   : delay_pipeline_type(0 TO 1); -- sfix10_En9
  SIGNAL storage_state_in3                : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL delay_section3                   : delay_pipeline_type(0 TO 1); -- sfix10_En9
  SIGNAL input_section1_cast              : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL storage_in_section1_cast         : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL delay_section11_cast             : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL delay_section12_cast             : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL input_section2_cast              : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL storage_in_section2_cast         : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL delay_section21_cast             : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL delay_section22_cast             : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL input_section3_cast              : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL storage_in_section3_cast         : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL delay_section31_cast             : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL delay_section32_cast             : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL inputmux_section_1               : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL inputmux_section_2               : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL inputmux_section_3               : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL coeffmux_section_1               : signed(40 DOWNTO 0); -- sfix41_En34
  SIGNAL coeffmux_section_2               : signed(40 DOWNTO 0); -- sfix41_En34
  SIGNAL coeffmux_section_3               : signed(40 DOWNTO 0); -- sfix41_En34
  SIGNAL prod1                            : signed(50 DOWNTO 0); -- sfix51_En43
  SIGNAL prod2                            : signed(50 DOWNTO 0); -- sfix51_En43
  SIGNAL prod3                            : signed(50 DOWNTO 0); -- sfix51_En43
  SIGNAL prod1_num                        : signed(41 DOWNTO 0); -- sfix42_En38
  SIGNAL prod1_num_cast                   : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL prod1_den                        : signed(41 DOWNTO 0); -- sfix42_En39
  SIGNAL prod1_den_cast                   : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL prod1_den_cast_neg               : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL unaryminus_temp                  : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL prod2_num                        : signed(41 DOWNTO 0); -- sfix42_En38
  SIGNAL prod2_num_cast                   : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL prod2_den                        : signed(41 DOWNTO 0); -- sfix42_En39
  SIGNAL prod2_den_cast                   : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL prod2_den_cast_neg               : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL unaryminus_temp_1                : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL prod3_num                        : signed(41 DOWNTO 0); -- sfix42_En38
  SIGNAL prod3_num_cast                   : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL prod3_den                        : signed(41 DOWNTO 0); -- sfix42_En39
  SIGNAL prod3_den_cast                   : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL prod3_den_cast_neg               : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL unaryminus_temp_2                : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL prod2_mux                        : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL prod3_mux                        : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL section_phase                    : std_logic; -- boolean
  SIGNAL sectionipconvert                 : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL sectionipconvert_cast            : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL sectionipconvert_mux             : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL sum_prod_12                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL add_cast                         : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL add_cast_1                       : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL add_temp                         : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL sum_prod_123                     : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL add_cast_2                       : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL add_cast_3                       : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL add_temp_1                       : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL accum_mux_out                    : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL accum                            : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL accum_reg                        : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL sectionopconvert                 : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL output_typeconvert               : signed(9 DOWNTO 0); -- sfix10_En9
  SIGNAL output_register                  : signed(9 DOWNTO 0); -- sfix10_En9


BEGIN

  -- Block Statements
  input_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_register <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        input_register <= signed(filter_in);
      END IF;
    END IF; 
  END PROCESS input_reg_process;

  Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cur_count <= to_unsigned(0, 3);
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        IF cur_count = to_unsigned(5, 3) THEN
          cur_count <= to_unsigned(0, 3);
        ELSE
          cur_count <= cur_count + 1;
        END IF;
      END IF;
    END IF; 
  END PROCESS Counter_process;

  phase_0 <= '1' WHEN cur_count = to_unsigned(0, 3) AND clk_enable = '1' ELSE '0';

  phase_1 <= '1' WHEN cur_count = to_unsigned(1, 3) AND clk_enable = '1' ELSE '0';

  phase_2 <= '1' WHEN cur_count = to_unsigned(2, 3) AND clk_enable = '1' ELSE '0';

  phase_3 <= '1' WHEN cur_count = to_unsigned(3, 3) AND clk_enable = '1' ELSE '0';

  phase_4 <= '1' WHEN cur_count = to_unsigned(4, 3) AND clk_enable = '1' ELSE '0';

  phase_5 <= '1' WHEN cur_count = to_unsigned(5, 3) AND clk_enable = '1' ELSE '0';


  -- Next stage input = Previous stage output. Storing Previous stage output
  prev_stg_op1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      prev_stg_op1 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        prev_stg_op1 <= sectionopconvert;
      END IF;
    END IF; 
  END PROCESS prev_stg_op1_process;

  prev_stg_op2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      prev_stg_op2 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_3 = '1' THEN
        prev_stg_op2 <= sectionopconvert;
      END IF;
    END IF; 
  END PROCESS prev_stg_op2_process;

  delay_process_section1 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delay_section1 <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        delay_section1(1) <= delay_section1(0);
        delay_section1(0) <= storage_state_in1;
      END IF;
    END IF;
  END PROCESS delay_process_section1;

  delay_process_section2 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delay_section2 <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_3 = '1' THEN
        delay_section2(1) <= delay_section2(0);
        delay_section2(0) <= storage_state_in2;
      END IF;
    END IF;
  END PROCESS delay_process_section2;

  delay_process_section3 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delay_section3 <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_5 = '1' THEN
        delay_section3(1) <= delay_section3(0);
        delay_section3(0) <= storage_state_in3;
      END IF;
    END IF;
  END PROCESS delay_process_section3;

  -- Making common precision for input and state
  input_section1_cast <= input_register;

  delay_section11_cast <= delay_section1(0);

  delay_section12_cast <= delay_section1(1);

  storage_in_section1_cast <= storage_state_in1;

  delay_section11_cast <= delay_section1(0);

  delay_section12_cast <= delay_section1(1);

  input_section2_cast <= prev_stg_op1;

  delay_section21_cast <= delay_section2(0);

  delay_section22_cast <= delay_section2(1);

  storage_in_section2_cast <= storage_state_in2;

  delay_section21_cast <= delay_section2(0);

  delay_section22_cast <= delay_section2(1);

  input_section3_cast <= prev_stg_op2;

  delay_section31_cast <= delay_section3(0);

  delay_section32_cast <= delay_section3(1);

  storage_in_section3_cast <= storage_state_in3;

  delay_section31_cast <= delay_section3(0);

  delay_section32_cast <= delay_section3(1);

  inputmux_section_1 <= input_section1_cast WHEN ( cur_count = to_unsigned(0, 3) ) ELSE
                             storage_in_section1_cast WHEN ( cur_count = to_unsigned(1, 3) ) ELSE
                             input_section2_cast WHEN ( cur_count = to_unsigned(2, 3) ) ELSE
                             storage_in_section2_cast WHEN ( cur_count = to_unsigned(3, 3) ) ELSE
                             input_section3_cast WHEN ( cur_count = to_unsigned(4, 3) ) ELSE
                             storage_in_section3_cast;

  inputmux_section_2 <= delay_section11_cast WHEN ( cur_count = to_unsigned(0, 3) ) ELSE
                             delay_section11_cast WHEN ( cur_count = to_unsigned(1, 3) ) ELSE
                             delay_section21_cast WHEN ( cur_count = to_unsigned(2, 3) ) ELSE
                             delay_section21_cast WHEN ( cur_count = to_unsigned(3, 3) ) ELSE
                             delay_section31_cast WHEN ( cur_count = to_unsigned(4, 3) ) ELSE
                             delay_section31_cast;

  inputmux_section_3 <= delay_section12_cast WHEN ( cur_count = to_unsigned(0, 3) ) ELSE
                             delay_section12_cast WHEN ( cur_count = to_unsigned(1, 3) ) ELSE
                             delay_section22_cast WHEN ( cur_count = to_unsigned(2, 3) ) ELSE
                             delay_section22_cast WHEN ( cur_count = to_unsigned(3, 3) ) ELSE
                             delay_section32_cast WHEN ( cur_count = to_unsigned(4, 3) ) ELSE
                             delay_section32_cast;

  coeffmux_section_1 <= scaleconst1 WHEN ( cur_count = to_unsigned(0, 3) ) ELSE
                             coeff_b1_section1 WHEN ( cur_count = to_unsigned(1, 3) ) ELSE
                             scaleconst2 WHEN ( cur_count = to_unsigned(2, 3) ) ELSE
                             coeff_b1_section2 WHEN ( cur_count = to_unsigned(3, 3) ) ELSE
                             scaleconst3 WHEN ( cur_count = to_unsigned(4, 3) ) ELSE
                             coeff_b1_section3;

  coeffmux_section_2 <= coeff_a2_section1 WHEN ( cur_count = to_unsigned(0, 3) ) ELSE
                             coeff_b2_section1 WHEN ( cur_count = to_unsigned(1, 3) ) ELSE
                             coeff_a2_section2 WHEN ( cur_count = to_unsigned(2, 3) ) ELSE
                             coeff_b2_section2 WHEN ( cur_count = to_unsigned(3, 3) ) ELSE
                             coeff_a2_section3 WHEN ( cur_count = to_unsigned(4, 3) ) ELSE
                             coeff_b2_section3;

  coeffmux_section_3 <= coeff_a3_section1 WHEN ( cur_count = to_unsigned(0, 3) ) ELSE
                             coeff_b3_section1 WHEN ( cur_count = to_unsigned(1, 3) ) ELSE
                             coeff_a3_section2 WHEN ( cur_count = to_unsigned(2, 3) ) ELSE
                             coeff_b3_section2 WHEN ( cur_count = to_unsigned(3, 3) ) ELSE
                             coeff_a3_section3 WHEN ( cur_count = to_unsigned(4, 3) ) ELSE
                             coeff_b3_section3;
  prod1 <= inputmux_section_1 * coeffmux_section_1;

  prod2 <= inputmux_section_2 * coeffmux_section_2;

  prod3 <= inputmux_section_3 * coeffmux_section_3;

  prod1_num <= (41 => '0', OTHERS => '1') WHEN (prod1(50) = '0' AND prod1(49 DOWNTO 46) /= "0000") OR (prod1(50) = '0' AND prod1(46 DOWNTO 5) = "011111111111111111111111111111111111111111") -- special case0
      ELSE (41 => '1', OTHERS => '0') WHEN prod1(50) = '1' AND prod1(49 DOWNTO 46) /= "1111"
      ELSE (resize(shift_right(prod1(46 DOWNTO 0) + ( "0" & (prod1(5) & NOT prod1(5) & NOT prod1(5) & NOT prod1(5) & NOT prod1(5))), 5), 42));

  prod1_num_cast <= (31 => '0', OTHERS => '1') WHEN (prod1_num(41) = '0' AND prod1_num(40 DOWNTO 38) /= "000") OR (prod1_num(41) = '0' AND prod1_num(38 DOWNTO 7) = "01111111111111111111111111111111") -- special case0
      ELSE (31 => '1', OTHERS => '0') WHEN prod1_num(41) = '1' AND prod1_num(40 DOWNTO 38) /= "111"
      ELSE (resize(shift_right(prod1_num(38 DOWNTO 0) + ( "0" & (prod1_num(7) & NOT prod1_num(7) & NOT prod1_num(7) & NOT prod1_num(7) & NOT prod1_num(7) & NOT prod1_num(7) & NOT prod1_num(7))), 7), 32));

  prod1_den <= (41 => '0', OTHERS => '1') WHEN (prod1(50) = '0' AND prod1(49 DOWNTO 45) /= "00000") OR (prod1(50) = '0' AND prod1(45 DOWNTO 4) = "011111111111111111111111111111111111111111") -- special case0
      ELSE (41 => '1', OTHERS => '0') WHEN prod1(50) = '1' AND prod1(49 DOWNTO 45) /= "11111"
      ELSE (resize(shift_right(prod1(45 DOWNTO 0) + ( "0" & (prod1(4) & NOT prod1(4) & NOT prod1(4) & NOT prod1(4))), 4), 42));

  prod1_den_cast <= (31 => '0', OTHERS => '1') WHEN (prod1_den(41) = '0' AND prod1_den(40 DOWNTO 39) /= "00") OR (prod1_den(41) = '0' AND prod1_den(39 DOWNTO 8) = "01111111111111111111111111111111") -- special case0
      ELSE (31 => '1', OTHERS => '0') WHEN prod1_den(41) = '1' AND prod1_den(40 DOWNTO 39) /= "11"
      ELSE (resize(shift_right(prod1_den(39 DOWNTO 0) + ( "0" & (prod1_den(8) & NOT prod1_den(8) & NOT prod1_den(8) & NOT prod1_den(8) & NOT prod1_den(8) & NOT prod1_den(8) & NOT prod1_den(8) & NOT prod1_den(8))), 8), 32));

  unaryminus_temp <= ('0' & prod1_den_cast) WHEN prod1_den_cast = "10000000000000000000000000000000"
      ELSE -resize(prod1_den_cast,33);
  prod1_den_cast_neg <= (31 => '0', OTHERS => '1') WHEN (unaryminus_temp(32) = '0' AND unaryminus_temp(31) /= '0') OR (unaryminus_temp(32) = '0' AND unaryminus_temp(31 DOWNTO 0) = "01111111111111111111111111111111") -- special case0
      ELSE (31 => '1', OTHERS => '0') WHEN unaryminus_temp(32) = '1' AND unaryminus_temp(31) /= '1'
      ELSE (unaryminus_temp(31 DOWNTO 0));

  prod2_num <= (41 => '0', OTHERS => '1') WHEN (prod2(50) = '0' AND prod2(49 DOWNTO 46) /= "0000") OR (prod2(50) = '0' AND prod2(46 DOWNTO 5) = "011111111111111111111111111111111111111111") -- special case0
      ELSE (41 => '1', OTHERS => '0') WHEN prod2(50) = '1' AND prod2(49 DOWNTO 46) /= "1111"
      ELSE (resize(shift_right(prod2(46 DOWNTO 0) + ( "0" & (prod2(5) & NOT prod2(5) & NOT prod2(5) & NOT prod2(5) & NOT prod2(5))), 5), 42));

  prod2_num_cast <= (31 => '0', OTHERS => '1') WHEN (prod2_num(41) = '0' AND prod2_num(40 DOWNTO 38) /= "000") OR (prod2_num(41) = '0' AND prod2_num(38 DOWNTO 7) = "01111111111111111111111111111111") -- special case0
      ELSE (31 => '1', OTHERS => '0') WHEN prod2_num(41) = '1' AND prod2_num(40 DOWNTO 38) /= "111"
      ELSE (resize(shift_right(prod2_num(38 DOWNTO 0) + ( "0" & (prod2_num(7) & NOT prod2_num(7) & NOT prod2_num(7) & NOT prod2_num(7) & NOT prod2_num(7) & NOT prod2_num(7) & NOT prod2_num(7))), 7), 32));

  prod2_den <= (41 => '0', OTHERS => '1') WHEN (prod2(50) = '0' AND prod2(49 DOWNTO 45) /= "00000") OR (prod2(50) = '0' AND prod2(45 DOWNTO 4) = "011111111111111111111111111111111111111111") -- special case0
      ELSE (41 => '1', OTHERS => '0') WHEN prod2(50) = '1' AND prod2(49 DOWNTO 45) /= "11111"
      ELSE (resize(shift_right(prod2(45 DOWNTO 0) + ( "0" & (prod2(4) & NOT prod2(4) & NOT prod2(4) & NOT prod2(4))), 4), 42));

  prod2_den_cast <= (31 => '0', OTHERS => '1') WHEN (prod2_den(41) = '0' AND prod2_den(40 DOWNTO 39) /= "00") OR (prod2_den(41) = '0' AND prod2_den(39 DOWNTO 8) = "01111111111111111111111111111111") -- special case0
      ELSE (31 => '1', OTHERS => '0') WHEN prod2_den(41) = '1' AND prod2_den(40 DOWNTO 39) /= "11"
      ELSE (resize(shift_right(prod2_den(39 DOWNTO 0) + ( "0" & (prod2_den(8) & NOT prod2_den(8) & NOT prod2_den(8) & NOT prod2_den(8) & NOT prod2_den(8) & NOT prod2_den(8) & NOT prod2_den(8) & NOT prod2_den(8))), 8), 32));

  unaryminus_temp_1 <= ('0' & prod2_den_cast) WHEN prod2_den_cast = "10000000000000000000000000000000"
      ELSE -resize(prod2_den_cast,33);
  prod2_den_cast_neg <= (31 => '0', OTHERS => '1') WHEN (unaryminus_temp_1(32) = '0' AND unaryminus_temp_1(31) /= '0') OR (unaryminus_temp_1(32) = '0' AND unaryminus_temp_1(31 DOWNTO 0) = "01111111111111111111111111111111") -- special case0
      ELSE (31 => '1', OTHERS => '0') WHEN unaryminus_temp_1(32) = '1' AND unaryminus_temp_1(31) /= '1'
      ELSE (unaryminus_temp_1(31 DOWNTO 0));

  prod3_num <= (41 => '0', OTHERS => '1') WHEN (prod3(50) = '0' AND prod3(49 DOWNTO 46) /= "0000") OR (prod3(50) = '0' AND prod3(46 DOWNTO 5) = "011111111111111111111111111111111111111111") -- special case0
      ELSE (41 => '1', OTHERS => '0') WHEN prod3(50) = '1' AND prod3(49 DOWNTO 46) /= "1111"
      ELSE (resize(shift_right(prod3(46 DOWNTO 0) + ( "0" & (prod3(5) & NOT prod3(5) & NOT prod3(5) & NOT prod3(5) & NOT prod3(5))), 5), 42));

  prod3_num_cast <= (31 => '0', OTHERS => '1') WHEN (prod3_num(41) = '0' AND prod3_num(40 DOWNTO 38) /= "000") OR (prod3_num(41) = '0' AND prod3_num(38 DOWNTO 7) = "01111111111111111111111111111111") -- special case0
      ELSE (31 => '1', OTHERS => '0') WHEN prod3_num(41) = '1' AND prod3_num(40 DOWNTO 38) /= "111"
      ELSE (resize(shift_right(prod3_num(38 DOWNTO 0) + ( "0" & (prod3_num(7) & NOT prod3_num(7) & NOT prod3_num(7) & NOT prod3_num(7) & NOT prod3_num(7) & NOT prod3_num(7) & NOT prod3_num(7))), 7), 32));

  prod3_den <= (41 => '0', OTHERS => '1') WHEN (prod3(50) = '0' AND prod3(49 DOWNTO 45) /= "00000") OR (prod3(50) = '0' AND prod3(45 DOWNTO 4) = "011111111111111111111111111111111111111111") -- special case0
      ELSE (41 => '1', OTHERS => '0') WHEN prod3(50) = '1' AND prod3(49 DOWNTO 45) /= "11111"
      ELSE (resize(shift_right(prod3(45 DOWNTO 0) + ( "0" & (prod3(4) & NOT prod3(4) & NOT prod3(4) & NOT prod3(4))), 4), 42));

  prod3_den_cast <= (31 => '0', OTHERS => '1') WHEN (prod3_den(41) = '0' AND prod3_den(40 DOWNTO 39) /= "00") OR (prod3_den(41) = '0' AND prod3_den(39 DOWNTO 8) = "01111111111111111111111111111111") -- special case0
      ELSE (31 => '1', OTHERS => '0') WHEN prod3_den(41) = '1' AND prod3_den(40 DOWNTO 39) /= "11"
      ELSE (resize(shift_right(prod3_den(39 DOWNTO 0) + ( "0" & (prod3_den(8) & NOT prod3_den(8) & NOT prod3_den(8) & NOT prod3_den(8) & NOT prod3_den(8) & NOT prod3_den(8) & NOT prod3_den(8) & NOT prod3_den(8))), 8), 32));

  unaryminus_temp_2 <= ('0' & prod3_den_cast) WHEN prod3_den_cast = "10000000000000000000000000000000"
      ELSE -resize(prod3_den_cast,33);
  prod3_den_cast_neg <= (31 => '0', OTHERS => '1') WHEN (unaryminus_temp_2(32) = '0' AND unaryminus_temp_2(31) /= '0') OR (unaryminus_temp_2(32) = '0' AND unaryminus_temp_2(31 DOWNTO 0) = "01111111111111111111111111111111") -- special case0
      ELSE (31 => '1', OTHERS => '0') WHEN unaryminus_temp_2(32) = '1' AND unaryminus_temp_2(31) /= '1'
      ELSE (unaryminus_temp_2(31 DOWNTO 0));

  prod2_mux <= prod2_den_cast_neg WHEN ( cur_count = to_unsigned(0, 3) ) ELSE
                    prod2_num_cast WHEN ( cur_count = to_unsigned(1, 3) ) ELSE
                    prod2_den_cast_neg WHEN ( cur_count = to_unsigned(2, 3) ) ELSE
                    prod2_num_cast WHEN ( cur_count = to_unsigned(3, 3) ) ELSE
                    prod2_den_cast_neg WHEN ( cur_count = to_unsigned(4, 3) ) ELSE
                    prod2_num_cast;
  prod3_mux <= prod3_den_cast_neg WHEN ( cur_count = to_unsigned(0, 3) ) ELSE
                    prod3_num_cast WHEN ( cur_count = to_unsigned(1, 3) ) ELSE
                    prod3_den_cast_neg WHEN ( cur_count = to_unsigned(2, 3) ) ELSE
                    prod3_num_cast WHEN ( cur_count = to_unsigned(3, 3) ) ELSE
                    prod3_den_cast_neg WHEN ( cur_count = to_unsigned(4, 3) ) ELSE
                    prod3_num_cast;
  section_phase <=  phase_0 OR phase_2 OR phase_4;

  sectionipconvert <= (9 => '0', OTHERS => '1') WHEN (prod1(50) = '0' AND prod1(49 DOWNTO 43) /= "0000000") OR (prod1(50) = '0' AND prod1(43 DOWNTO 34) = "0111111111") -- special case0
      ELSE (9 => '1', OTHERS => '0') WHEN prod1(50) = '1' AND prod1(49 DOWNTO 43) /= "1111111"
      ELSE (resize(shift_right(prod1(43 DOWNTO 0) + ( "0" & (prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34) & NOT prod1(34))), 34), 10));

  sectionipconvert_cast <= resize(sectionipconvert & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 32);

  sectionipconvert_mux <= sectionipconvert_cast WHEN ( section_phase = '1' ) ELSE
                               prod1_num_cast;
  add_cast <= sectionipconvert_mux;
  add_cast_1 <= prod2_mux;
  add_temp <= resize(add_cast, 33) + resize(add_cast_1, 33);
  sum_prod_12 <= (31 => '0', OTHERS => '1') WHEN (add_temp(32) = '0' AND add_temp(31) /= '0') OR (add_temp(32) = '0' AND add_temp(31 DOWNTO 0) = "01111111111111111111111111111111") -- special case0
      ELSE (31 => '1', OTHERS => '0') WHEN add_temp(32) = '1' AND add_temp(31) /= '1'
      ELSE (add_temp(31 DOWNTO 0));

  add_cast_2 <= sum_prod_12;
  add_cast_3 <= prod3_mux;
  add_temp_1 <= resize(add_cast_2, 33) + resize(add_cast_3, 33);
  sum_prod_123 <= (31 => '0', OTHERS => '1') WHEN (add_temp_1(32) = '0' AND add_temp_1(31) /= '0') OR (add_temp_1(32) = '0' AND add_temp_1(31 DOWNTO 0) = "01111111111111111111111111111111") -- special case0
      ELSE (31 => '1', OTHERS => '0') WHEN add_temp_1(32) = '1' AND add_temp_1(31) /= '1'
      ELSE (add_temp_1(31 DOWNTO 0));

  accum_mux_out <= sum_prod_123;

  accumulator_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      accum_reg <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        accum_reg <= accum_mux_out;
      END IF;
    END IF; 
  END PROCESS accumulator_reg_process;

  storagetypeconvert <= (9 => '0', OTHERS => '1') WHEN accum_mux_out(31) = '0' AND accum_mux_out(30 DOWNTO 21) = "1111111111"
      ELSE resize(shift_right(accum_mux_out(31 DOWNTO 0) + ( "0" & (accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22))), 22), 10);

  sectionopconvert <= (9 => '0', OTHERS => '1') WHEN accum_mux_out(31) = '0' AND accum_mux_out(30 DOWNTO 21) = "1111111111"
      ELSE resize(shift_right(accum_mux_out(31 DOWNTO 0) + ( "0" & (accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22))), 22), 10);

  output_typeconvert <= (9 => '0', OTHERS => '1') WHEN accum_mux_out(31) = '0' AND accum_mux_out(30 DOWNTO 21) = "1111111111"
      ELSE resize(shift_right(accum_mux_out(31 DOWNTO 0) + ( "0" & (accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22) & NOT accum_mux_out(22))), 22), 10);

  storage_reg1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      storage_state_in1 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_0 = '1' THEN
        storage_state_in1 <= storagetypeconvert;
      END IF;
    END IF; 
  END PROCESS storage_reg1_process;

  storage_reg2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      storage_state_in2 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_2 = '1' THEN
        storage_state_in2 <= storagetypeconvert;
      END IF;
    END IF; 
  END PROCESS storage_reg2_process;

  storage_reg3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      storage_state_in3 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_4 = '1' THEN
        storage_state_in3 <= storagetypeconvert;
      END IF;
    END IF; 
  END PROCESS storage_reg3_process;

  Output_Register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      output_register <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_5 = '1' THEN
        output_register <= output_typeconvert;
      END IF;
    END IF; 
  END PROCESS Output_Register_process;

  -- Assignment Statements
  filter_out <= std_logic_vector(output_register);
END rtl;
