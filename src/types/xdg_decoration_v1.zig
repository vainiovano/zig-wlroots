const wlr = @import("../wlroots.zig");

const wayland = @import("wayland");
const wl = wayland.server.wl;

pub const XdgDecorationManagerV1 = extern struct {
    global: *wl.Global,
    /// XdgToplevelDecorationV1.link
    decorations: wl.List,

    server_destroy: wl.Listener(*wl.Server),

    events: extern struct {
        new_toplevel_decoration: wl.Signal(*XdgToplevelDecorationV1),
        destroy: wl.Signal(*XdgDecorationManagerV1),
    },

    data: usize,

    extern fn wlr_xdg_decoration_manager_v1_create(server: *wl.Server) ?*XdgDecorationManagerV1;
    pub const create = wlr_xdg_decoration_manager_v1_create;
};

pub const XdgToplevelDecorationV1 = extern struct {
    pub const Mode = extern enum {
        none = 0,
        client_side = 1,
        server_side = 2,
    };

    pub const Configure = extern struct {
        /// XdgToplevelDecorationV1.configure_list
        link: wl.List,
        surface_configure: *wlr.XdgSurface.Configure,
        mode: Mode,
    };

    resource: *wl.Resource,
    surface: *wlr.XdgSurface,
    manager: *XdgDecorationManagerV1,
    /// XdgDecorationManagerV1.decorations
    link: wl.List,

    added: bool,
    current_mode: Mode,
    client_pending_mode: Mode,
    server_pending_mode: Mode,

    /// Configure.link
    configure_list: wl.List,

    events: extern struct {
        destroy: wl.Signal(*XdgToplevelDecorationV1),
        request_mode: wl.Signal(*XdgToplevelDecorationV1),
    },

    surface_destroy: wl.Listener(*wlr.XdgSurface),
    surface_configure: wl.Listener(*wlr.XdgSurface.Configure),
    surface_ack_configure: wl.Listener(*wlr.XdgSurface.Configure),
    surface_commit: wl.Listener(*wlr.Surface),

    data: usize,

    extern fn wlr_xdg_toplevel_decoration_v1_set_mode(decoration: *XdgToplevelDecorationV1, mode: Mode) u32;
    pub const setMode = wlr_xdg_toplevel_decoration_v1_set_mode;
};
