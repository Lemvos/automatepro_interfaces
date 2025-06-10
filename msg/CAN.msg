uint32 id           # Identifier: 11-bit (standard) or 29-bit (extended)
bool is_extended    # True if using extended 29-bit identifier, false for standard 11-bit
bool is_rtr         # True if this is a remote transmission request (RTR) frame
uint8 dlc           # Actual data length (0 to 8 bytes)
uint8[8] data       # Data payload (valid bytes: 0 to 8)