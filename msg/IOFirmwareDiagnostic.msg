# Diagnostics of the IO controller firmware.

# Error codes
uint8 NO_ERROR=0x00
uint8 ERROR_INDEX_CAN=0x01

# Bitmasks
uint8 MASK_CAN_RX_BUF_OVERFLOW=0x01
uint8 MASK_CAN_TX_BUF_OVERFLOW=0x02

std_msgs/Header header
uint32 uptime         # Uptime, in s
uint8[10] fault_code  # Fault codes
