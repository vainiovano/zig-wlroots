const wlr = @import("../wlroots.zig");

const wayland = @import("wayland");
const wl = wayland.server.wl;

pub const PrimarySelectionDeviceManagerV1 = extern struct {
    global: *wl.Global,
    /// PrimarySelectionV1Device.link
    devices: wl.List,

    server_destroy: wl.Listener(*wl.Server),

    events: extern struct {
        destroy: wl.Signal(*PrimarySelectionDeviceManagerV1),
    },

    data: usize,

    extern fn wlr_primary_selection_v1_device_manager_create(server: *wl.Server) ?*PrimarySelectionDeviceManagerV1;
    pub const create = wlr_primary_selection_v1_device_manager_create;
};

pub const PrimarySelectionDeviceV1 = extern struct {
    manager: *PrimarySelectionDeviceManagerV1,
    seat: *wlr.Seat,
    /// PrimarySelectionDeviceManagerV1.devices
    link: wl.List,
    /// wl.Resource.getLink()
    resources: wl.List,

    /// wl.Resource.getLink()
    offers: wl.List,

    seat_destroy: wl.Listener(*wlr.Seat),
    seat_focus_change: wl.Listener(*wlr.Seat.event.KeyboardFocusChange),
    seat_set_primary_selection: wl.Listener(*wlr.Seat.event.RequestSetPrimarySelection),

    data: usize,
};
