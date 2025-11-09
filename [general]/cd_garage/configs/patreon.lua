-- Patreon tiers configuration (shared)

Config.PatreonTiers = {
	ENABLE = true,
	DEBUG = false, -- Turned off for production performance

	-- How to resolve a player's tier for testing/production.
	-- 'metadata': reads QBCore PlayerData.metadata[metadata_key]
	-- 'job': maps job name to tier via job_to_tier
	-- 'group': maps permission group to tier via group_to_tier
	-- Change to what you prefer in live usage.
	lookup_mode = 'metadata',
	metadata_key = 'patreon_tier',
	job_to_tier = { tier1 = 1, tier2 = 2, tier3 = 3 },
	group_to_tier = { vip1 = 1, vip2 = 2, vip3 = 3 },
	default_tier = 0,
	inherit = true, -- if true, tier N also includes tiers < N

	-- Define gated vehicles per tier by SPAWNCODE (case-insensitive)
	-- Vehicles are now categorized by type for proper garage storage
	tiers = {
		[1] = { 
			cars = { 
				'sc_dominatorwb', 'vacca2', 'clubta', 'furiawb', 'sentinel_rts', 
				'h4rxwindsorcus', 'gstzr3503', 'schwarzer2', 'gp1wb', 'r300w', 
				'cypherct', 'contenderc', 
				'coquettewb', 'Hoonie', 'jestgpr', 'komodafr', 'zentornoc', 
				'mk2vigerozx', 'z190wb', 'cometrr', 'boorbc', 
				'sultanrsv8', 'saseverowb', 'gstarg2'
			},
			boats = {},
			air = {}
		},
		[2] = { 
			cars = { 
				'turismorr', 'playboy', 'domttc', 'italigts', 'jesterwb', 
				'vigerozxwbc', 'hrgt6r', 'yosemite6str', 
				'fcomneisgt25', 'sddriftvet', 'remuswb', 'elytron', 'hotkniferod', 
				'vacca3', 'gstghell1', 'jester4wb', 'rt3000wb', 'sdmonsterslayer', 
				'audace', 'gstjc2', 'turismo2lm', 'zentorno2', 'ziongtc', 'vertice'
			},
			boats = {},
			air = {}
		},
		[3] = { 
			cars = { 
				'vd_tenfrally', 'vanz23m2wb', 'uniobepdb', 'thraxs', 'sunrise1', 
				'bansheeas', 'jester3c', 'gstnio2', 'sentineldm', 'schlagenstr', 
				'italigtoc', 'sagauntletstreet', 'scdtm', 'draftgpr', 'rh82', 
				'SCSugoi', 'hycrh7', 'tyrusgtr', 'tempesta2', 
				'tempestaes', 'reagpr', 'gst10f1', 'coquette4c', 
				'rapidgte', 'kurumata', 'hycsun'
			},
			boats = {},
			air = {}
		},
	},
}

