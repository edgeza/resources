---Job names must be lower case (top level table key)
---@type table<string, Job>
return {
    ['unemployed'] = {
        label = 'Civilian',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Freelancer',
                payment = 500
            },
        },
    },
    ['bus'] = {
        label = 'Bus',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Driver',
                payment = 50
            },
        },
    },
    ['reporter'] = {
        label = 'Reporter',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Journalist',
                payment = 50
            },
        },
    },
    ['trucker'] = {
        label = 'Trucker',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Driver',
                payment = 50
            },
        },
    },
    ['tow'] = {
        label = 'Towing',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Driver',
                payment = 50
            },
        },
    },
    ['garbage'] = {
        label = 'Garbage',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Collector',
                payment = 50
            },
        },
    },
    ['vineyard'] = {
        label = 'Vineyard',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Picker',
                payment = 50
            },
        },
    },
    ['hotdog'] = {
        label = 'Hotdog',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Sales',
                payment = 50
            },
        },
    },
    ['events'] = {
        label = 'Events',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Participant',
                payment = 50
            },
            [1] = {
                name = 'Organizer',
                payment = 8000
            },
        },
    },
    ['police'] = {
        label = 'Law Enforcement',
        type = 'leo',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Cadet',
                payment = 2000
            },
            [1] = {
                name = 'Officer / Trooper',
                payment = 2500
            },
            [2] = {
                name = 'Snr Officer / Trooper',
                payment = 3000
            },
            [3] = {
                name = 'Corporal / Ranger',
                payment = 3500
            },
            [4] = {
                name = 'Interceptor Jnr',
                payment = 3500
            },
            [5] = {
                name = 'Interceptor Snr',
                payment = 3500
            },
            [6] = {
                name = 'Sergeant',
                payment = 4000
            },
            [7] = {
                name = 'Lieutenant',
                payment = 4500
            },
            [8] = {
                name = 'Captain / Major',
                payment = 5000
            },
            [9] = {
                name = 'Assistant Chief / Sheriff',
                isboss = true,
                payment = 6000
            },
            [10] = {
                name = 'Deputy Chief / Sheriff',
                isboss = true,
                payment = 6500
            },
            [11] = {
                name = 'Sheriff',
                isboss = true,
                payment = 7500
            },
            [12] = {
                name = 'Chief Of Police',
                isboss = true,
                payment = 8000
            },
        },
    },
    ['ambulance'] = {
        label = 'EMS',
        type = 'ems',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Probationary',
                payment = 2500
            },
            [1] = {
                name = 'Trainee',
                payment = 3500
            },
            [2] = {
                name = 'Junior Paramedic',
                payment = 4000
            },
            [3] = {
                name = 'Senior Paramedic',
                payment = 4500
            },
            [4] = {
                name = 'Search and Rescue',
                payment = 5000
            },
            [5] = {
                name = 'Doctor',
                payment = 5500
            },
            [6] = {
                name = 'Surgeon',
                payment = 6000
            },
            [7] = {
                name = 'Supervisor',
                payment = 6500
            },
            [8] = {
                name = 'Assistent Chief',
                isboss = true,
                payment = 7000
            },
            [9] = {
                name = 'Deputy Chief',
                isboss = true,
                payment = 7500
            },
            [10] = {
                name = 'Chief',
                isboss = true,
                payment = 8000
            },
        },
    },
    ['dynasty'] = {
        label = 'OneLife Real Estate',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Intern',
                payment = 2000
            },
            [1] = {
                name = 'Realtor',
                payment = 2500
            },
            [2] = {
                name = 'Designer',
                payment = 3000
            },
            [3] = {
                name = 'Co-Owner',
                payment = 4500
            },
            [4] = {
                name = 'Owner',
                isboss = true,
                payment = 5500,
                bankAuth = true
            },
        },
    },
    ['towing'] = {
        label = 'Towing',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Driver',
                payment = 1000
            },
            [1] = {
                name = 'Manager',
                payment = 2500
            },
            [2] = {
                name = 'Owner',
                isboss = true,
                payment = 4000,
                bankAuth = true
            },
        },
    },
    ['palmcoast'] = {
        label = 'Palm Coast',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 1000
            },
            [1] = {
                name = 'Novice',
                payment = 1500
            },
            [2] = {
                name = 'Experienced',
                payment = 2000
            },
            [3] = {
                name = 'Manager',
                payment = 2500
            },
            [4] = {
                name = 'Owner',
                isboss = true,
                payment = 3500,
                bankAuth = true
            },
        },
    },
    ['bennies'] = {
        label = 'Bennys Auto',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 1000
            },
            [1] = {
                name = 'Novice',
                payment = 1500
            },
            [2] = {
                name = 'Experienced',
                payment = 2000
            },
            [3] = {
                name = 'Manager',
                payment = 2500
            },
            [4] = {
                name = 'Owner',
                isboss = true,
                payment = 3500,
                bankAuth = true
            },
        },
    },
    ['6str'] = {
        label = '6Street Tuner Shop',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 1000
            },
            [1] = {
                name = 'Novice',
                payment = 1500
            },
            [2] = {
                name = 'Experienced',
                payment = 2000
            },
            [3] = {
                name = 'Manager',
                payment = 2500
            },
            [4] = {
                name = 'Owner',
                isboss = true,
                payment = 3500,
                bankAuth = true
            },
        },
    },
    ['olrpmechanic'] = {
        label = 'OneLife Mechanics',
        defaultDuty = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 1000
            },
            [1] = {
                name = 'Novice',
                payment = 1500
            },
            [2] = {
                name = 'Experienced',
                payment = 2000
            },
            [3] = {
                name = 'Manager',
                payment = 2500
            },
            [4] = {
                name = 'Owner',
                isboss = true,
                bankAuth = true,
                payment = 3500
            },
        },
    },
    ['catcafe'] = {
        label = 'Cat Cafe',
        defaultDuty = true,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 1000
            },
            [1] = {
                name = 'Novice',
                payment = 1500
            },
            [2] = {
                name = 'Experienced',
                payment = 2000
            },
            [3] = {
                name = 'Advanced',
                payment = 2500
            },
            [4] = {
                name = 'Manager',
                payment = 3000
            },
            [5] = {
                name = 'Co-Owner',
                isboss = true,
                bankAuth = true,
                payment = 3500
            },
            [6] = {
                name = 'Owner',
                isboss = true,
                bankAuth = true,
                payment = 3500
            },
        },
    },
	['koi'] = {
    	label = 'Koi',
    	defaultDuty = true,
    	grades = {
            [0] = {
                name = 'Cashier',
                payment = 1500
            },
            [1] = {
                name = 'Cook',
                payment = 2000
            },
            [2] = {
                name = 'Shift Manager',
                payment = 2500
            },
            [3] = {
                name = 'Manager',
                payment = 3500,
            },
            [4] = {
                name = 'Owner',
                payment = 4000,
                isboss = true,
            },
        },
    },
    ['skybar'] = {
        label = 'Sky Bar',
        defaultDuty = false,
        grades = {
            [0] = {
                name = 'Recruit',
                payment = 1000
            },
            [1] = {
                name = 'Novice',
                payment = 1500
            },
            [2] = {
                name = 'Experienced',
                payment = 2000
            },
            [3] = {
                name = 'Manager',
                payment = 2500
            },
            [4] = {
                name = 'Owner',
                isboss = true,
                bankAuth = true,
                payment = 3500
            },
        },
    },
    ['highnotes'] = {
        label = 'High Notes',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Cashier',
                payment = 1500
            },
            [1] = {
                name = 'Budtender',
                payment = 2000
            },
            [2] = {
                name = 'Shift Manager',
                payment = 2500
            },
            [3] = {
                name = 'Manager',
                payment = 3500
            },
            [4] = {
                name = 'Owner',
                isboss = true,
                bankAuth = true,
                payment = 4000
            },
        },
    },
    ['doj'] = {
        label = 'DOJ',
        type = 'doj',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'SIU',
                payment = 3500
            },
            [1] = {
                name = 'Civil Lawyer',
                payment = 4000
            },
            [2] = {
                name = 'Criminal Lawyer',
                payment = 4000
            },
            [3] = {
                name = 'Prosecutor',
                payment = 5000
            },
            [4] = {
                name = 'Lead Prosecutor',
                payment = 5500
            },
            [5] = {
                name = 'Chief Justice',
                payment = 6000
            },
            [6] = {
                name = 'Attorney General',
                payment = 6500
            },
        },
    },
}
