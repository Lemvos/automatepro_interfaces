# Desired state of one digital output of the IO controller.

# High-side outputs
uint8 DIGITAL_OUT_H_01=1
uint8 DIGITAL_OUT_H_02=2
uint8 DIGITAL_OUT_H_03=3
uint8 DIGITAL_OUT_H_04=4
uint8 DIGITAL_OUT_H_05=5
uint8 DIGITAL_OUT_H_06=6

# Low-side outputs
uint8 DIGITAL_OUT_L_01=7
uint8 DIGITAL_OUT_L_02=8
uint8 DIGITAL_OUT_L_03=9
uint8 DIGITAL_OUT_L_04=10
uint8 DIGITAL_OUT_L_05=11
uint8 DIGITAL_OUT_L_06=12

uint8 d_out_pin_id        # Output, one of the DIGITAL_OUT_* constants above
uint8 duty_cycle_percent  # Duty cycle, 0 to 100 %
