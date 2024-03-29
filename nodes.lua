----------------------
-- Cave Decorations --
----------------------

-- Mushrooms and Speleothems
--  These are instantiated by voxel.lua since the decoration manager
--   only works at the surface of the world.

local light_max = 12

minetest.register_node("fun_caves:huge_mushroom_cap", {
	description = "Huge Mushroom Cap",
	tiles = {"vmg_mushroom_giant_cap.png", "vmg_mushroom_giant_under.png", "vmg_mushroom_giant_cap.png"},
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = { type = "fixed", 
		fixed = {
			{-0.5, -0.5, -0.33, 0.5, -0.33, 0.33}, 
			{-0.33, -0.5, 0.33, 0.33, -0.33, 0.5}, 
			{-0.33, -0.5, -0.33, 0.33, -0.33, -0.5}, 
			{-0.33, -0.33, -0.33, 0.33, -0.17, 0.33}, 
		} },
	light_source = 10,
	groups = {fleshy=1, dig_immediate=3, flammable=2, plant=1, leafdecay=1},
})

minetest.register_node("fun_caves:giant_mushroom_cap", {
	description = "Giant Mushroom Cap",
	tiles = {"vmg_mushroom_giant_cap.png", "vmg_mushroom_giant_under.png", "vmg_mushroom_giant_cap.png"},
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = { type = "fixed", 
		fixed = {
			{-0.4, -0.5, -0.4, 0.4, 0.0, 0.4},
			{-0.75, -0.5, -0.4, -0.4, -0.25, 0.4},
			{0.4, -0.5, -0.4, 0.75, -0.25, 0.4},
			{-0.4, -0.5, -0.75, 0.4, -0.25, -0.4},
			{-0.4, -0.5, 0.4, 0.4, -0.25, 0.75},
		} },
	light_source = 10,
	groups = {fleshy=1, dig_immediate=3, flammable=2, plant=1, leafdecay=1},
})

minetest.register_node("fun_caves:giant_mushroom_stem", {
	description = "Giant Mushroom Stem",
	tiles = {"vmg_mushroom_giant_stem.png", "vmg_mushroom_giant_stem.png", "vmg_mushroom_giant_stem.png"},
	is_ground_content = false,
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2, plant=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	drawtype = "nodebox",
	node_box = { type = "fixed", fixed = { {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}, }},
})

-- Mushroom stems can be used as wood, ala Journey to the Center of the Earth.
minetest.register_craft({
	output = "default:wood",
	recipe = {
		{"fun_caves:giant_mushroom_stem"}
	}
})

minetest.register_craft({
	output = "mobs:leather",
	recipe = {
		{"fun_caves:giant_mushroom_cap"}
	}
})

minetest.register_craft({
	output = "dye:red",
	recipe = {
		{"flowers:mushroom_red"}
	}
})

--minetest.register_craft({
--	output = "dye:yellow",
--	recipe = {
--		{"flowers:mushroom_brown"}
--	}
--})

-- Caps can be cooked and eaten.
minetest.register_node("fun_caves:mushroom_steak", {
	description = "Mushroom Steak",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"vmg_mushroom_steak.png"},
	inventory_image = "vmg_mushroom_steak.png",
	on_use = minetest.item_eat(4),
	groups = {dig_immediate = 3, attached_node = 1},
})

minetest.register_craft({
	type = "cooking",
	output = "fun_caves:mushroom_steak",
	recipe = "fun_caves:huge_mushroom_cap",
	cooktime = 2,
})

minetest.register_craft({
	type = "cooking",
	output = "fun_caves:mushroom_steak 2",
	recipe = "fun_caves:giant_mushroom_cap",
	cooktime = 2,
})

-- Glowing fungal stone provides an eerie light.
minetest.register_node("fun_caves:glowing_fungal_stone", {
	description = "Glowing Fungal Stone",
	tiles = {"default_stone.png^vmg_glowing_fungal.png",},
	is_ground_content = true,
	light_source = 12,
	groups = {cracky=3, stone=1},
	drop = {items={ {items={"default:cobble"},}, {items={"fun_caves:glowing_fungus",},},},},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fun_caves:glowing_fungus", {
	description = "Glowing Fungus",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"vmg_glowing_fungus.png"},
	inventory_image = "vmg_glowing_fungus.png",
	groups = {dig_immediate = 3, attached_node = 1},
})

-- The fungus can be made into juice and then into glowing glass.
minetest.register_node("fun_caves:moon_juice", {
	description = "Moon Juice",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"vmg_moon_juice.png"},
	inventory_image = "vmg_moon_juice.png",
	groups = {dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("fun_caves:moon_glass", {
	description = "Moon Glass",
	drawtype = "glasslike",
	tiles = {"default_glass.png",},
	inventory_image = minetest.inventorycube("default_glass.png"),
	is_ground_content = true,
	light_source = default.LIGHT_MAX,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "fun_caves:moon_juice",
	recipe = {
		{"fun_caves:glowing_fungus", "fun_caves:glowing_fungus", "fun_caves:glowing_fungus"},
		{"fun_caves:glowing_fungus", "fun_caves:glowing_fungus", "fun_caves:glowing_fungus"},
		{"fun_caves:glowing_fungus", "vessels:glass_bottle", "fun_caves:glowing_fungus"},
	},
})

minetest.register_craft({
	output = "fun_caves:moon_glass",
	type = "shapeless",
	recipe = {
		"fun_caves:moon_juice",
		"fun_caves:moon_juice",
		"default:glass",
	},
})

-- What's a cave without speleothems?
local spel = {
	{type1="stalactite", type2="stalagmite", tile="default_stone.png"},
	{type1="stalactite_slimy", type2="stalagmite_slimy", tile="default_stone.png^fun_caves_algae.png"},
	{type1="stalactite_mossy", type2="stalagmite_mossy", tile="default_stone.png^fun_caves_moss.png"},
	{type1="icicle_down", type2="icicle_up", desc="Icicle", tile="caverealms_thin_ice.png", drop="default:ice"},
}

for _, desc in pairs(spel) do
	minetest.register_node("fun_caves:"..desc.type1, {
		description = (desc.desc or "Stalactite"),
		tiles = {desc.tile},
		is_ground_content = true,
		walkable = false,
		paramtype = "light",
		--light_source = 14,
		drop = (desc.drop or "fun_caves:stalactite"),
		drawtype = "nodebox",
		node_box = { type = "fixed", 
			fixed = {
				{-0.07, 0.0, -0.07, 0.07, 0.5, 0.07}, 
				{-0.04, -0.25, -0.04, 0.04, 0.0, 0.04}, 
				{-0.02, -0.5, -0.02, 0.02, 0.25, 0.02}, 
			} },
		groups = {rock=1, cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node("fun_caves:"..desc.type2, {
		description = (desc.desc or "Stalagmite"),
		tiles = {desc.tile},
		is_ground_content = true,
		walkable = false,
		paramtype = "light",
		--light_source = 14,
		drop = "fun_caves:stalagmite",
		drawtype = "nodebox",
		node_box = { type = "fixed", 
			fixed = {
				{-0.07, -0.5, -0.07, 0.07, 0.0, 0.07}, 
				{-0.04, 0.0, -0.04, 0.04, 0.25, 0.04}, 
				{-0.02, 0.25, -0.02, 0.02, 0.5, 0.02}, 
			} },
		groups = {rock=1, cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

-- They can be made into cobblestone, to get them out of inventory.
minetest.register_craft({
	output = "default:cobble",
	recipe = {
		{"", "", ""},
		{"fun_caves:stalactite", "fun_caves:stalactite", ""},
		{"fun_caves:stalactite", "fun_caves:stalactite", ""},
	},
})

minetest.register_craft({
	output = "default:cobble",
	recipe = {
		{"", "", ""},
		{"fun_caves:stalagmite", "fun_caves:stalagmite", ""},
		{"fun_caves:stalagmite", "fun_caves:stalagmite", ""},
	},
})

minetest.register_node("fun_caves:glowing_dirt", {
	description = "Glowing Dirt",
	tiles = {"default_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	light_source = default.LIGHT_MAX,
	sounds = default.node_sound_dirt_defaults(),
	soil = {
		base = "fun_caves:glowing_dirt",
		dry = "fun_caves:glowing_soil",
		wet = "fun_caves:glowing_soil_wet"
	},
})

minetest.register_node("fun_caves:glowing_soil", {
	description = "Glowing Soil",
	tiles = {"default_dirt.png^farming_soil.png", "default_dirt.png"},
	drop = "fun_caves:glowing_dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=2, grassland = 1, field = 1},
	sounds = default.node_sound_dirt_defaults(),
	light_source = default.LIGHT_MAX,
	soil = {
		base = "fun_caves:glowing_dirt",
		dry = "fun_caves:glowing_soil",
		wet = "fun_caves:glowing_soil_wet"
	},
})

minetest.register_node("fun_caves:glowing_soil_wet", {
	description = "Wet Glowing Soil",
	tiles = {"default_dirt.png^farming_soil_wet.png", "default_dirt.png^farming_soil_wet_side.png"},
	drop = "fun_caves:glowing_dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=3, wet = 1, grassland = 1, field = 1},
	sounds = default.node_sound_dirt_defaults(),
	light_source = default.LIGHT_MAX,
	soil = {
		base = "fun_caves:glowing_dirt",
		dry = "fun_caves:glowing_soil",
		wet = "fun_caves:glowing_soil_wet"
	},
})

minetest.register_craft({
	output = "fun_caves:glowing_dirt",
	type = "shapeless",
	recipe = {
		"fun_caves:moon_juice",
		"default:dirt",
	},
})

--thin (transparent) ice
minetest.register_node("fun_caves:thin_ice", {
	description = "Thin Ice",
	tiles = {"caverealms_thin_ice.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	use_texture_alpha = true,
	light_source = 1,
	drawtype = "glasslike",
	sunlight_propagates = true,
	freezemelt = "default:water_source",
	paramtype = "light",
})

minetest.register_node("fun_caves:stone_with_moss", {
	description = "Cave Stone with Moss",
	tiles = {"default_stone.png^fun_caves_moss.png"},
	is_ground_content = true,
	light_source = 10,
	groups = {stone=1, crumbly=3},
	drop = 'default:cobble',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("fun_caves:stone_with_lichen", {
	description = "Cave Stone with Lichen",
	tiles = {"default_stone.png^fun_caves_lichen.png"},
	is_ground_content = true,
	light_source = 10,
	groups = {stone=1, crumbly=3},
	drop = 'default:cobble',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("fun_caves:stone_with_algae", {
	description = "Cave Stone with Algae",
	tiles = {"default_stone.png^fun_caves_algae.png"},
	is_ground_content = true,
	light_source = 10,
	groups = {stone=1, crumbly=3},
	drop = 'default:cobble',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("fun_caves:stone_with_salt", {
	description = "Cave Stone with Salt",
	tiles = {"caverealms_salty2.png"},--{"caverealms_salty2.png^caverealms_salty.png", "caverealms_salty2.png", "caverealms_salty2.png^caverealms_salty_side.png"},
	light_source = 9,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {stone=1, crumbly=3},
	sounds = default.node_sound_glass_defaults(),
})

--Glow Obsidian
minetest.register_node("fun_caves:glow_obsidian", {
	description = "Glowing Obsidian",
	tiles = {"caverealms_glow_obsidian.png"},
	is_ground_content = true,
	groups = {stone=2, crumbly=1},
	light_source = 7,
	sounds = default.node_sound_stone_defaults({
		footstep = {name="default_stone_footstep", gain=0.25},
	}),
})

--Glow Obsidian 2 - has traces of lava
minetest.register_node("fun_caves:glow_obsidian_2", {
	description = "Hot Glow Obsidian",
	tiles = {"caverealms_glow_obsidian2.png"},
	is_ground_content = true,
	groups = {stone=2, crumbly=1, hot=1},
	damage_per_second = 1,
	light_source = 9,
	sounds = default.node_sound_stone_defaults({
		footstep = {name="default_stone_footstep", gain=0.25},
	}),
})


--minetest.register_node("fun_caves:bright_air", {
--	drawtype = "glasslike",
--	tiles = {"technic_light.png"},
--	paramtype = "light",
--	groups = {not_in_creative_inventory=1},
--	drop = "",
--	walkable = false,
--	buildable_to = true,
--	sunlight_propagates = true,
--	light_source = LIGHT_MAX,
--	pointable = false,
--})

--define special flame so that it does not expire
minetest.register_node("fun_caves:constant_flame", {
	description = "Fire",
	drawtype = "plantlike",
	tiles = {{
		name="fire_basic_flame_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
	}},
	inventory_image = "fire_basic_flame.png",
	light_source = 14,
	groups = {igniter=2,dig_immediate=3,hot=3, not_in_creative_inventory=1},
	drop = '',
	walkable = false,
	buildable_to = true,
	damage_per_second = 4,
})

--Hot Cobble - cobble with lava instead of mortar XD
minetest.register_node("fun_caves:hot_cobble", {
	description = "Hot Cobble",
	tiles = {"caverealms_hot_cobble.png"},
	is_ground_content = true,
	groups = {crumbly=2, hot=1},
	damage_per_second = 1,
	light_source = 6,
	sounds = default.node_sound_stone_defaults({
		footstep = {name="default_stone_footstep", gain=0.25},
	}),
})

minetest.register_abm({
	nodenames = {"group:hot"},
	interval = 2,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 0.95)) do
			if not minetest.registered_nodes[node.name] then
				return
			end
			local dps = minetest.registered_nodes[node.name]["damage_per_second"]
			if object.set_hp and object.get_hp and dps then
				--print("damage. "..object:get_hp().." hit points left")
				object:set_hp(object:get_hp() - dps)
			end
		end
	end})


-- mushroom growth
minetest.register_abm({
	nodenames = {"flowers:mushroom_brown", "flowers:mushroom_red"},
	interval = 50 * fun_caves.time_factor,
	chance = 100,
	action = function(pos, node)
		local pos_up = {x=pos.x,y=pos.y+1,z=pos.z}
		local node_up = minetest.get_node_or_nil(pos_up)
		if not node_up then
			return
		end
		if node_up.name ~= "air" then
			return
		end
		local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
		if not node_under then
			return
		end
		if minetest.get_item_group(node_under.name, "soil") ~= 0 and
				minetest.get_node_light(pos_up, nil) <= light_max then
			minetest.set_node(pos_up, {name = "fun_caves:huge_mushroom_cap"})
			minetest.set_node(pos, {name = "fun_caves:giant_mushroom_stem"})
		end
	end
})

-- mushroom growth
minetest.register_abm({
	nodenames = {"fun_caves:huge_mushroom_cap"},
	interval = 100 * fun_caves.time_factor,
	chance = 150,
	action = function(pos, node)
		if minetest.get_node_light(pos, nil) >= 14 then
			minetest.set_node(pos, {name = "air"})
			return
		end
		local pos_up = {x=pos.x,y=pos.y+1,z=pos.z}
		local node_up = minetest.get_node_or_nil(pos_up)
		if not node_up then
			return
		end
		if node_up.name ~= "air" then
			return
		end
		local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
		if not node_under or node_under.name ~= "fun_caves:giant_mushroom_stem" then
			return
		end
		node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 2, z = pos.z})
		if not node_under then
			return
		end
		if minetest.get_item_group(node_under.name, "soil") ~= 0 and
				minetest.get_node_light(pos_up, nil) <= light_max then
			minetest.set_node(pos_up, {name = "fun_caves:giant_mushroom_cap"})
			minetest.set_node(pos, {name = "fun_caves:giant_mushroom_stem"})
		end
	end
})

-- mushroom growth
minetest.register_abm({
	nodenames = {"fun_caves:giant_mushroom_stem"},
	interval = 5 * fun_caves.time_factor,
	chance = 5,
	action = function(pos, node)
		local pos_up = {x=pos.x,y=pos.y+1,z=pos.z}
		local node_up = minetest.get_node_or_nil(pos_up)
		if not node_up then
			return
		end
		if node_up.name ~= "air" then
			return
		end
		if minetest.get_node_light(pos_up, nil) <= light_max then
			minetest.set_node(pos_up, {name = "fun_caves:huge_mushroom_cap"})
		end
	end
})

-- mushroom spread
minetest.register_abm({
	nodenames = {"fun_caves:giant_mushroom_cap", "fun_caves:huge_mushroom_cap"},
	interval = 3 * fun_caves.time_factor,
	chance = 40,
	action = function(pos, node)
		if minetest.get_node_light(pos, nil) >= 14 then
			minetest.set_node(pos, {name = "air"})
			return
		end
		local pos_down = pos
		pos_down.y = pos_down.y - 1
		local pos1, count = minetest.find_nodes_in_area_under_air(vector.subtract(pos_down, 4), vector.add(pos_down, 4), {"group:soil"})
		if #pos1 < 1 then
			return
		end
		local random = pos1[math.random(1, #pos1)]
		random.y = random.y + 1
		local mushroom_type
		if math.random(1,2) == 1 then
			mushroom_type = "flowers:mushroom_red"
		else
			mushroom_type = "flowers:mushroom_brown"
		end
		if minetest.get_node_light(random, nil) <= light_max then
			minetest.set_node(random, {name = mushroom_type})
		end
	end
})

-- Mushroom spread and death
minetest.register_abm({
	nodenames = {"flowers:mushroom_brown", "flowers:mushroom_red"},
	interval = 3 * fun_caves.time_factor,
	chance = 50,
	action = function(pos, node)
		if minetest.get_node_light(pos, nil) == 15 then
			minetest.remove_node(pos)
			return
		end
		local random = {
			x = pos.x + math.random(-2, 2),
			y = pos.y + math.random(-1, 1),
			z = pos.z + math.random(-2, 2)
		}
		local random_node = minetest.get_node_or_nil(random)
		if not random_node or random_node.name ~= "air" then
			return
		end
		local node_under = minetest.get_node_or_nil({x = random.x,
			y = random.y - 1, z = random.z})
		if not node_under then
			return
		end

		if (minetest.get_item_group(node_under.name, "soil") ~= 0 or
				minetest.get_item_group(node_under.name, "tree") ~= 0) and
				minetest.get_node_light(pos, 0.5) <= light_max and
				minetest.get_node_light(random, 0.5) <= light_max then
			minetest.set_node(random, {name = node.name})
		end
	end
})

minetest.register_craft({
	output = 'default:paper 6',
	recipe = {
		{'fun_caves:giant_mushroom_stem', 'fun_caves:giant_mushroom_stem', 'fun_caves:giant_mushroom_stem'},
	}
})

