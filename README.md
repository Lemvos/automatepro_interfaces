# AutomatePro Interfaces

[![ROS 2 Humble](https://img.shields.io/badge/ROS2-Humble-blue.svg)](https://docs.ros.org/en/humble/)
[![CI](https://img.shields.io/github/actions/workflow/status/Lemvos/automatepro_interfaces/ros2-ci.yaml?branch=master)](https://github.com/Lemvos/automatepro_interfaces/actions)

ROS 2 message and service definitions for the AutomatePro IO controller and drivers.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Usage](#usage)
- [Interfaces](#interfaces)
- [Installation](#installation)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [Security](#security)
- [License](#license)

## Overview

`automatepro_interfaces` defines the types the AutomatePro nodes exchange: the IO controller's analog and digital inputs, its digital outputs, drives and warning systems, its E-Stop status and diagnostics, a CAN frame, and two IO controller services.
The package contains no nodes; the AutomatePro drivers and the [AutomatePro tutorials](https://github.com/Lemvos/automatepro_tutorials) depend on it.

## Prerequisites

- Ubuntu 22.04 and ROS 2 Humble.
- `colcon` (`python3-colcon-common-extensions`) and `rosdep`.

## Quick Start

Build the package in a colcon workspace:

```bash
mkdir -p ~/ros2_ws/src && cd ~/ros2_ws/src
git clone https://github.com/Lemvos/automatepro_interfaces.git
cd ~/ros2_ws
source /opt/ros/humble/setup.bash
rosdep update
rosdep install --from-paths src --ignore-src --rosdistro humble -y
colcon build --symlink-install --packages-select automatepro_interfaces
source install/setup.bash
```

On a machine where rosdep has never been used, run `sudo rosdep init` once before `rosdep update`.

`colcon test` runs the ament linters over the package:

```bash
colcon test --packages-select automatepro_interfaces --return-code-on-test-failure
colcon test-result --verbose
```

Show a type as the ROS graph sees it:

```bash
ros2 interface show automatepro_interfaces/msg/DigitalOut
```

## Usage

A package that uses these types declares the dependency in `package.xml`:

```xml
<depend>automatepro_interfaces</depend>
```

and, for C++, in `CMakeLists.txt`:

```cmake
find_package(automatepro_interfaces REQUIRED)
ament_target_dependencies(my_node rclcpp automatepro_interfaces)
```

The generated headers and modules follow the ROS 2 naming rules, for example `#include "automatepro_interfaces/msg/digital_out.hpp"` in C++ and `from automatepro_interfaces.msg import DigitalOut` in Python.

## Interfaces

### Messages

| Type | Purpose |
| --- | --- |
| [`msg/AnalogIn`](msg/AnalogIn.msg) | The IO controller's 14 analog inputs |
| [`msg/CAN`](msg/CAN.msg) | One CAN frame, to publish or receive on a CAN bus |
| [`msg/DigitalIn`](msg/DigitalIn.msg) | The IO controller's 10 digital inputs |
| [`msg/DigitalOut`](msg/DigitalOut.msg) | The desired state of one digital output |
| [`msg/DigitalDriveOut`](msg/DigitalDriveOut.msg) | The desired state of one digital drive |
| [`msg/WarningSystems`](msg/WarningSystems.msg) | The desired state of the buzzer or a warning light |
| [`msg/EStopStatus`](msg/EStopStatus.msg) | The E-Stop status |
| [`msg/IOControllerDiagnostic`](msg/IOControllerDiagnostic.msg) | Diagnostics of the IO controller hardware |
| [`msg/IOFirmwareDiagnostic`](msg/IOFirmwareDiagnostic.msg) | Diagnostics of the IO controller firmware |

#### `AnalogIn`

The analog input values received by the IO controller, sampled at 30 Hz.

| Field | Type | Unit | Description |
| --- | --- | --- | --- |
| `header` | `std_msgs/Header` | - | Timestamp |
| `ain_01` to `ain_14` | `int16` | mV | Analog inputs 1 to 14, from 0 to 10000 mV |

#### `CAN`

A CAN frame for publishing or receiving CAN bus messages.

| Field | Type | Description |
| --- | --- | --- |
| `id` | `uint32` | CAN identifier, an 11-bit standard or a 29-bit extended identifier |
| `is_extended` | `bool` | `true` for a 29-bit extended identifier, `false` for an 11-bit standard one |
| `is_rtr` | `bool` | `true` for a remote transmission request (RTR) frame |
| `dlc` | `uint8` | Data length, from 0 to 8 bytes |
| `data` | `uint8[8]` | Data payload; only the first `dlc` bytes are valid |

#### `DigitalIn`

The digital input values received by the IO controller.
It is published on a state change, or when requested through [`ReqDigitalIn`](#reqdigitalin); response rate 200 ms.

| Field | Type | Description |
| --- | --- | --- |
| `header` | `std_msgs/Header` | Timestamp |
| `din_01` to `din_10` | `bool` | Digital inputs 1 to 10 |

#### `DigitalOut`

The desired state of one of the 12 digital outputs, 6 high side and 6 low side; response rate 200 ms.

| Field | Type | Description |
| --- | --- | --- |
| `d_out_pin_id` | `uint8` | Output pin, one of the constants below |
| `duty_cycle_percent` | `uint8` | Duty cycle, from 0 to 100 % |

| Constants | Values | Outputs |
| --- | --- | --- |
| `DIGITAL_OUT_H_01` to `DIGITAL_OUT_H_06` | 1 to 6 | High side |
| `DIGITAL_OUT_L_01` to `DIGITAL_OUT_L_06` | 7 to 12 | Low side |

#### `DigitalDriveOut`

The desired state of one digital drive, configured as a full bridge, a half bridge or an individual low-side or high-side drive; response rate 200 ms.
The low-side and high-side drives require hardware changes: contact support to use them.

| Field | Type | Description |
| --- | --- | --- |
| `d_drive_pin_id` | `uint8` | Drive, one of the drive constants below |
| `direction` | `bool` | `FORWARD` (`true`) or `REVERSE` (`false`) |
| `duty_cycle_percent` | `uint8` | Duty cycle, from 0 to 100 % |

| Constants | Values | Drive |
| --- | --- | --- |
| `FULL_BRIDGE_DRIVE_01` to `FULL_BRIDGE_DRIVE_06` | 1 to 6 | Full bridge |
| `HALF_BRIDGE_DRIVE_01` to `HALF_BRIDGE_DRIVE_12` | 7 to 18 | Half bridge |
| `LOW_SIDE_DRIVE_01` to `LOW_SIDE_DRIVE_12` | 19 to 30 | Low side |
| `HIGH_SIDE_DRIVE_01` to `HIGH_SIDE_DRIVE_12` | 31 to 42 | High side |

#### `WarningSystems`

The desired state of one warning system; response rate 200 ms.

| Field | Type | Description |
| --- | --- | --- |
| `warning_system_id` | `uint8` | `WARNING_BUZZER` (1), `WARNING_LIGHT_01` (2) or `WARNING_LIGHT_02` (3) |
| `state` | `bool` | `ON` (`true`) or `OFF` (`false`) |

#### `EStopStatus`

The status of the E-Stop.

| Field | Type | Description |
| --- | --- | --- |
| `header` | `std_msgs/Header` | Timestamp |
| `is_engaged` | `bool` | `true` while the E-Stop is engaged |
| `fault_code` | `uint8` | Fault code of the E-Stop |

#### `IOControllerDiagnostic`

Diagnostics of the IO controller hardware.

| Field | Type | Unit | Description |
| --- | --- | --- | --- |
| `header` | `std_msgs/Header` | - | Timestamp |
| `vbatt_voltage_monitor` | `float32` | V | Battery voltage |
| `v12_io_smps_current_monitor` | `float32` | A | 12 V IO SMPS current |
| `v12_io_smps_voltage_monitor` | `float32` | V | 12 V IO SMPS voltage |
| `main_sbc_smps_current_monitor` | `float32` | A | 12 V or 5 V SBC SMPS current |
| `main_sbc_smps_voltage_monitor` | `float32` | V | 12 V or 5 V SBC SMPS voltage |
| `v5_io_smps_voltage_monitor` | `float32` | V | 5 V IO SMPS voltage |
| `v5_io_smps_current_monitor` | `float32` | A | 5 V IO SMPS current |
| `amp_total_power_monitor` | `float32` | W | Total power |
| `v12_io_power_good` | `bool` | - | 12 V IO power good |
| `v5_io_power_good` | `bool` | - | 5 V IO power good |
| `v3_3_io_power_good` | `bool` | - | 3.3 V IO power good |
| `main_sbc_power_good` | `bool` | - | 12 V or 5 V SBC power good |
| `v5_sbc_power_good` | `bool` | - | 5 V SBC power good |
| `v3_3_sbc_power_good` | `bool` | - | 3.3 V SBC power good |
| `v1_8_sbc_power_good` | `bool` | - | 1.8 V SBC power good |
| `digital_drive_fault_1` to `digital_drive_fault_4` | `bool` | - | Fault of drives 1 to 4 |
| `board_temp` | `int8` | °C | Board temperature |

#### `IOFirmwareDiagnostic`

Diagnostics of the IO controller firmware.

| Field | Type | Unit | Description |
| --- | --- | --- | --- |
| `header` | `std_msgs/Header` | - | Timestamp |
| `uptime` | `uint32` | s | Firmware uptime |
| `fault_code` | `uint8[10]` | - | Fault codes |

The message defines the error codes `NO_ERROR` (`0x00`) and `ERROR_INDEX_CAN` (`0x01`), and the bitmasks `MASK_CAN_RX_BUF_OVERFLOW` (`0x01`) and `MASK_CAN_TX_BUF_OVERFLOW` (`0x02`).

### Services

| Type | Purpose |
| --- | --- |
| [`srv/ReqDigitalIn`](srv/ReqDigitalIn.srv) | Makes the IO controller republish its digital inputs |
| [`srv/IOConfig`](srv/IOConfig.srv) | Reads or writes one IO controller configuration value |

#### `ReqDigitalIn`

Triggers the IO controller to republish the current digital input states on `/io/din`, as a [`DigitalIn`](#digitalin) message.
The request is empty; the response carries `success` (`bool`).

#### `IOConfig`

| Part | Field | Type | Description |
| --- | --- | --- | --- |
| Request | `flag` | `uint8` | `FLAG_READ` (0) or `FLAG_WRITE` (1) |
| Request | `key` | `uint16` | The configuration value addressed |
| Request | `val` | `float32` | The value to write |
| Response | `ret_code` | `uint16` | Return code |
| Response | `ret_val` | `float32` | Returned value |

## Installation

Build from source as in the [Quick Start](#quick-start); `ros2 interface package automatepro_interfaces` then lists the types.
Prebuilt arm64 and amd64 packages, `ros-humble-automatepro-interfaces`, are published to the AutomatePro package repository, which AutomatePro systems are configured to use.

## Documentation

- [Contributing](CONTRIBUTING.md): how to report a problem, and the tests and linters every change has to pass.
- [CI and Release](doc/ci-and-release.md): the workflows, the release flow and the repository settings.

## Contributing

Lemvos Robotics maintains these definitions: report a problem or a needed change in an issue.
Pull requests that change a message or service are not accepted; see [CONTRIBUTING.md](CONTRIBUTING.md).

## Security

Report a suspected vulnerability privately, as [SECURITY.md](SECURITY.md) describes.

## License

Licensed under the Apache License 2.0; see [LICENSE](LICENSE).
