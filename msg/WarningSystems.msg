# WarningSystems Message
# This message is used to send desired warning system states to the io-controller

uint8 WARNING_BUZZER=1
uint8 WARNING_LIGHT_01=2
uint8 WARNING_LIGHT_02=3

bool ON=true
bool OFF=false

std_msgs/Header header      # Header
uint8 warning_system_id     # Warning system id
bool state                  # State of the warning system