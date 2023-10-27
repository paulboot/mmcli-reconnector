import dbus

def list_network_interfaces():
    bus = dbus.SystemBus()
    nm = bus.get_object('org.freedesktop.NetworkManager', '/org/freedesktop/NetworkManager')
    nm_iface = dbus.Interface(nm, 'org.freedesktop.NetworkManager')

    # Get all devices
    devices = nm_iface.GetDevices()

    for dev_path in devices:
        dev_obj = bus.get_object('org.freedesktop.NetworkManager', dev_path)
        dev_props = dbus.Interface(dev_obj, 'org.freedesktop.DBus.Properties')
        dev_interface = dev_props.Get('org.freedesktop.NetworkManager.Device', 'Interface')
        print(f'Interface Path: {dev_path}, Interface Name: {dev_interface}')

if __name__ == '__main__':
    list_network_interfaces()

