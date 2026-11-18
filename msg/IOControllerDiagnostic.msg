# Diagnostics of the IO controller hardware.

std_msgs/Header header
float32 vbatt_voltage_monitor          # Battery voltage, in V
float32 v12_io_smps_current_monitor    # 12 V IO SMPS current, in A
float32 v12_io_smps_voltage_monitor    # 12 V IO SMPS voltage, in V
float32 main_sbc_smps_current_monitor  # 12 V or 5 V SBC SMPS current, in A
float32 main_sbc_smps_voltage_monitor  # 12 V or 5 V SBC SMPS voltage, in V
float32 v5_io_smps_voltage_monitor     # 5 V IO SMPS voltage, in V
float32 v5_io_smps_current_monitor     # 5 V IO SMPS current, in A
float32 amp_total_power_monitor        # Total power, in W
bool v12_io_power_good                 # 12 V IO power good
bool v5_io_power_good                  # 5 V IO power good
bool v3_3_io_power_good                # 3.3 V IO power good
bool main_sbc_power_good               # 12 V or 5 V SBC power good
bool v5_sbc_power_good                 # 5 V SBC power good
bool v3_3_sbc_power_good               # 3.3 V SBC power good
bool v1_8_sbc_power_good               # 1.8 V SBC power good
bool digital_drive_fault_1             # Drive 1 fault
bool digital_drive_fault_2             # Drive 2 fault
bool digital_drive_fault_3             # Drive 3 fault
bool digital_drive_fault_4             # Drive 4 fault
int8 board_temp                        # Board temperature, in degrees Celsius
