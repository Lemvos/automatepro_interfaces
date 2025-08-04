# IOFirmwareDiagnostic Message
# This message contains the diagnostic information of the io-controller firmware

uint8 NO_ERROR = 0x00
uint8 ERROR_INDEX_CAN = 0x01

uint8 MASK_CAN_RX_BUF_OVERFLOW = 0x01
uint8 MASK_CAN_TX_BUF_OVERFLOW = 0x02

std_msgs/Header header    # Header
uint32 uptime             # Uptime in seconds   
uint8[10] fault_code      # Fault code