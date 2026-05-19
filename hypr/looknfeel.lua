hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 1,
	},

	decoration = {
		rounding = 10,
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
		},
	},

	animations = {
		enabled = true,
	},
})

hl.curve("flow", { type = "bezier", points = { { 0.10, 0.90 }, { 0.20, 1.00 } } })
hl.curve("flow_out", { type = "bezier", points = { { 0.12, 0.95 }, { 0.22, 1.00 } } })
hl.curve("linear", { type = "bezier", points = { { 1.00, 1.00 }, { 1.00, 1.00 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "flow", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "flow", style = "slidefade 5%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "flow_out", style = "slidefade 5%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 6, bezier = "flow", style = "slidefade 5%" })

hl.animation({ leaf = "layers", enabled = true, speed = 6, bezier = "flow", style = "slide" })

hl.animation({ leaf = "fadeIn", enabled = true, speed = 6, bezier = "flow" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 6, bezier = "flow_out" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 6, bezier = "flow" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 6, bezier = "flow" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 6, bezier = "flow" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 6, bezier = "flow" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "flow", style = "slide" })

hl.animation({ leaf = "border", enabled = true, speed = 2, bezier = "linear" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "linear", style = "loop" })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
-- hl.config({
--   layout = {
--     -- Avoid overly wide single-window layouts on wide screens.
--     single_window_aspect_ratio = { 1, 1 },
--   },
-- })

-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
-- hl.config({
--   scrolling = {
--     -- See only one column per screen instead of two.
--     column_width = 0.97,
--   },
-- })
