# IOFirmwareDiagnostic Message
# This message contains the diagnostic information of the io-controller firmware

std_msgs/Header header    # Header
uint32 uptime             # Uptime in seconds   
uint16 fault_code         # Fault code
uint8[4] reserved         # Reserved