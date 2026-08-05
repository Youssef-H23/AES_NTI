# ==========================================
# AES CBC DECRYPT WAVE SETUP
# ==========================================

vlib work

vlog +incdir+. *.v

vsim -voptargs=+acc work.AES_CBC_Decrypt_tb


# ==========================================
# INPUTS
# ==========================================

add wave -divider -color "cyan" "INPUTS"

add wave -color cyan sim:/AES_CBC_Decrypt_tb/key
add wave -color cyan sim:/AES_CBC_Decrypt_tb/iv
add wave -color cyan sim:/AES_CBC_Decrypt_tb/ciphertext


# ==========================================
# OUTPUTS
# ==========================================

add wave -divider -color "green" "OUTPUTS"

add wave -color green sim:/AES_CBC_Decrypt_tb/plaintext
add wave -color green sim:/AES_CBC_Decrypt_tb/expected_plaintext


# ==========================================
# DUT INTERNAL SIGNALS
# ==========================================

add wave -divider -color "yellow" "CBC INTERNAL"

add wave -color yellow sim:/AES_CBC_Decrypt_tb/dut/C0
add wave -color yellow sim:/AES_CBC_Decrypt_tb/dut/C1
add wave -color yellow sim:/AES_CBC_Decrypt_tb/dut/C2
add wave -color yellow sim:/AES_CBC_Decrypt_tb/dut/C3

add wave -color yellow sim:/AES_CBC_Decrypt_tb/dut/D0
add wave -color yellow sim:/AES_CBC_Decrypt_tb/dut/D1
add wave -color yellow sim:/AES_CBC_Decrypt_tb/dut/D2
add wave -color yellow sim:/AES_CBC_Decrypt_tb/dut/D3


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