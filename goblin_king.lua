

mobs:register_mob("fun_caves:goblin_king", {
	description = "Goblin King",
	type = "monster",
	passive = false,
	damage = 4,
	attack_type = "dogfight",
	attacks_monsters = false,
	hp_min = 20,
	hp_max = 40,
	armor = 100,
	collisionbox = {-0.35,-1,-0.35, 0.35,-.1,0.35},
	visual = "mesh",
	mesh = "goblins_goblin.b3d",
	drawtype = "front",
		textures = {
			{"goblins_goblin_king.png"},
		},
	makes_footstep_sound = true,
	sounds = {
		random = "goblins_goblin_ambient",
		warcry = "goblins_goblin_attack",
		attack = "goblins_goblin_attack",
		damage = "goblins_goblin_damage",
		death = "goblins_goblin_death",
		distance = 15,
	},
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	drops = {
		{name = "default:pick_mese",
		chance = 2, min = 1, max = 1},
		{name = "default:sword_mese",
		chance = 4, min = 1, max = 1},
		{name = "fun_caves:mushroom_steak",
		chance = 2, min = 1, max = 2},
		{name = "default:mese_crystal",
		chance = 5, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	follow = "default:diamond",
	view_range = 10,
	owner = "",
	order = "follow",
	animation = {
		speed_normal = 30,
		speed_run = 30,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 200,
		punch_end = 219,
	},
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		local name = clicker:get_player_name()

		-- feed to heal goblin
		if item:get_name() == "default:apple"
		or item:get_name() == "farming:bread" then

			local hp = self.object:get_hp()
			-- return if full health
			if hp >= self.hp_max then
				minetest.chat_send_player(name, "goblin at full health.")
				return
			end
			hp = hp + 4
			if hp > self.hp_max then hp = self.hp_max end
			self.object:set_hp(hp)
			-- take item
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end

		-- right clicking with gold lump drops random item from fun_caves.goblin_drops
		elseif item:get_name() == "default:gold_lump" then
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			local pos = self.object:getpos()
			pos.y = pos.y + 0.5
			minetest.add_item(pos, {name = fun_caves.goblin_drops[math.random(1, #fun_caves.goblin_drops)]})

		else
			-- if owner switch between follow and stand
			if self.owner and self.owner == clicker:get_player_name() then
				if self.order == "follow" then
					self.order = "stand"
				else
					self.order = "follow"
				end
--			else
--				self.owner = clicker:get_player_name()
			end
		end

		mobs:capture_mob(self, clicker, 0, 5, 80, false, nil)
	end,

	do_custom = function(self)
		fun_caves.search_replace(self.object:getpos(), 2, {"default:torch"}, "air")
		fun_caves.search_replace(self.object:getpos(), 20, {"default:stone"}, "default:mossycobble")
		fun_caves.search_replace(self.object:getpos(), 50, {"default:mossycobble"}, "fun_caves:mossycobble_trap")
		fun_caves.search_replace(self.object:getpos(), 50, {"group:stone"}, "fun_caves:stone_with_coal_trap")
		fun_caves.search_replace(self.object:getpos(), 50, 5, {"group:stone"}, "fun_caves:stone_with_copper_trap")
		fun_caves.search_replace(self.object:getpos(), 50, 5, {"group:stone"}, "fun_caves:stone_with_gold_trap")
		fun_caves.search_replace(self.object:getpos(), 50, 5, {"group:stone"}, "fun_caves:stone_with_iron_trap")
	end,
})
mobs:register_egg("fun_caves:goblin_king", "Goblin King Egg", "default_mossycobble.png", 1)
mobs:register_spawn("fun_caves:goblin_king", {"default:stone_with_mese"}, 100, 0, 1 * fun_caves.goblin_spawn_frequency, 1, 31000)
mobs:register_spawn("fun_caves:goblin_king", {"default:mossycobble"}, 100, 0, 3 * fun_caves.goblin_spawn_frequency, 3, 31000)

