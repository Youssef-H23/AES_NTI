# ==========================================
# AES CBC ENCRYPT WAVE SETUP
# ==========================================

vlib work

vlog +incdir+. *.v

vsim -voptargs=+acc work.AES_CBC_Encrypt_tb



# ==========================================
# INPUTS
# ==========================================

add wave -divider -color "cyan" "INPUTS"

add wave -color cyan sim:/AES_CBC_Encrypt_tb/key
add wave -color cyan sim:/AES_CBC_Encrypt_tb/iv
add wave -color cyan sim:/AES_CBC_Encrypt_tb/plaintext



# ==========================================
# OUTPUTS
# ==========================================

add wave -divider -color "green" "OUTPUTS"

add wave -color green sim:/AES_CBC_Encrypt_tb/ciphertext
add wave -color green sim:/AES_CBC_Encrypt_tb/expected_ciphertext



# ==========================================
# DUT INTERNAL SIGNALS
# ==========================================

add wave -divider -color "yellow" "CBC INTERNAL"


# Plaintext Blocks

add wave -color yellow sim:/AES_CBC_Encrypt_tb/dut/P0
add wave -color yellow sim:/AES_CBC_Encrypt_tb/dut/P1
add wave -color yellow sim:/AES_CBC_Encrypt_tb/dut/P2
add wave -color yellow sim:/AES_CBC_Encrypt_tb/dut/P3



# CBC XOR Inputs

add wave -color yellow sim:/AES_CBC_Encrypt_tb/dut/X0
add wave -color yellow sim:/AES_CBC_Encrypt_tb/dut/X1
add wave -color yellow sim:/AES_CBC_Encrypt_tb/dut/X2
add wave -color yellow sim:/AES_CBC_Encrypt_tb/dut/X3



# Ciphertext Blocks

add wave -color yellow sim:/AES_CBC_Encrypt_tb/dut/C0
add wave -color yellow sim:/AES_CBC_Encrypt_tb/dut/C1
add wave -color yellow sim:/AES_CBC_Encrypt_tb/dut/C2
add wave -color yellow sim:/AES_CBC_Encrypt_tb/dut/C3



# ==========================================
# ENCRYPT INTERNAL BLOCKS
# ==========================================

add wave -divider -color "orange" "AES BLOCK INTERNAL"


add wave -color orange sim:/AES_CBC_Encrypt_tb/dut/u_enc0/*
add wave -color orange sim:/AES_CBC_Encrypt_tb/dut/u_enc1/*
add wave -color orange sim:/AES_CBC_Encrypt_tb/dut/u_enc2/*
add wave -color orange sim:/AES_CBC_Encrypt_tb/dut/u_enc3/*



# ==========================================
# FORMAT
# ==========================================

configure wave -signalnamewidth 1

configure wave -timelineunits ns

configure wave -namecolwidth 200

configure wave -valuecolwidth 150



# ==========================================
# RUN
# ==========================================

run -all


# Fit waveform

wave zoom full