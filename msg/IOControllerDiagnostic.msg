# IOControllerDiagnostic Message
# This message contains the diagnostic information of the io-controller

std_msgs/Header header                  # Header
float32 vbatt_voltage_monitor           # Battery voltage monitor in V
float32 v12_io_smps_current_monitor     # 12V IO SMPS current monitor in A
float32 v12_io_smps_voltage_monitor     # 12V IO SMPS voltage monitor in V
float32 v12_sbc_smps_current_monitor    # 12V SBC SMPS current monitor in A
float32 v12_sbc_smps_voltage_monitor    # 12V SBC SMPS voltage monitor in V
float32 v5_io_smps_voltage_monitor      # 5V IO SMPS voltage monitor in V
float32 total_power_monitor             # Total power monitor in W
bool v12_io_power_good                  # 12V IO power status
bool v5_io_power_good                   # 5V IO power status
bool v3_3_io_power_good                 # 3.3V IO power status  
bool v12_sbc_power_good                 # 12V SBC power status 
bool v5_sbc_power_good                  # 5V SBC power status
bool v3_3_sbc_power_good                # 3.3V SBC power status
bool v1_8_sbc_power_good                # 1.8V SBC power status
bool motor_drive_fault_1                # Motor drive fault 1 status
bool motor_drive_fault_2                # Motor drive fault 2 status
bool motor_drive_fault_3                # Motor drive fault 3 status
bool motor_drive_fault_4                # Motor drive fault 4 status
int8 board_temp                         # Board temperature in degree Celsius