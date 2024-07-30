# EStopStatus Message
# This message is used to publish the status of the E-Stop

std_msgs/Header header  # Header of the message
bool is_engaged         # Indicates whether the E-Stop is engaged or not
uint8 fault_code        # Indicates the fault code of the E-Stop
