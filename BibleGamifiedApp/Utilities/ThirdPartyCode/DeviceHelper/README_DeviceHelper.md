## DeviceHelper.swift
## Capabilities

## Usage

Create a Global constant for your Device helper  and user that variable
```Swift
let device = Device()
```

How to use:

```Swift
print(device)     // prints, for example, "iPhone 6 Plus"
print(device.width) // prints device width
print(device.height) // prints device height
print(device.screenRatio) // prints device screen ratio in tuple (16, 9)
print(device.isZoomed) // prints true or false
```

Get the Device You're Running On

```Swift
if device == .iPhone6Plus {
// Do something
} else {
// Do something else
}

OR

switch device {
case .iPhone7:
// Do something
break
case .iPhone6Plus:
// Do something
break
default:
// Do something
break
}
```

Get the Device Family

```Swift
if device.isPod {
// iPods (real or simulator)
} else if device.isPhone {
// iPhone (real or simulator)
} else if device.isPad {
// iPad (real or simulator)
}
```

Check If Running on Simulator

```Swift
if device.isSimulator {
// Running on one of the simulators(iPod/iPhone/iPad)
// Skip doing something irrelevant for Simulator
}
```

Get the Simulator Device

```Swift
switch device {
case .simulator(.iPhone6s): break // You're running on the iPhone 6s simulator
case .simulator(.iPadAir2): break // You're running on the iPad Air 2 simulator
default: break
}
```

Make Sure the Device Is Contained in a Preconfigured Group
```Swift
let groupOfAllowedDevices: [Device] = [.iPhone6,
.iPhone6Plus,
.iPhone6s,
.iPhone6sPlus,
.simulator(.iPhone6),
.simulator(.iPhone6Plus),
.simulator(.iPhone6s),
.simulator(.iPhone6sPlus)]

if device.isOneOf(groupOfAllowedDevices) {
// Do your action
}
```

Get the Current Battery State

```Swift
if device.batteryState == .full || device.batteryState >= .charging(75) {
print("Your battery is happy! 😊")
}
```

Get the Current Battery Level

```Swift
if device.batteryLevel >= 50 {
// install_iOS()
} else {
// showError()
}
```


Get Low Power mode status

```Swift
if device.batteryState.lowPowerMode {
print("Low Power mode is enabled! 🔋")
} else {
print("Low Power mode is disabled! 😊")
}
```


Check if a Guided Access session is currently active

```Swift
if device.isGuidedAccessSessionActive {
print("Guided Access session is currently active")
} else {
print("No Guided Access session is currently active")
}
```


Get Screen Brightness

```Swift
if device.screenBrightness > 50 {
print("Take care of your eyes!")
}
```


Get Available Disk Space

```Swift
if Device.volumeAvailableCapacityForOpportunisticUsage ?? 0 > Int64(1_000_000) {
// download that nice-to-have huge file
}

if Device.volumeAvailableCapacityForImportantUsage ?? 0 > Int64(1_000) {
// download that file you really need
}
```


Get the underlying device

```Swift
let simulator = Device.simulator(.iPhone8Plus)
let realDevice = Device.iPhone8Plus
simulator.realDevice == realDevice // true
realDevice.realDevice == realDevice // true
```
