# A CAN frame.

uint32 id         # Identifier: 11-bit standard or 29-bit extended
bool is_extended  # True for a 29-bit extended identifier, false for an 11-bit standard one
bool is_rtr       # True for a remote transmission request (RTR) frame
uint8 dlc         # Data length, 0 to 8 bytes
uint8[8] data     # Payload; only the first dlc bytes are valid
