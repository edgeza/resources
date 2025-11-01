const guidebookConfig = {
    defaultCategory: 'gettingStarted.newPlayer', // Default open category
    defaultFont: 'Inter', // Default font

    texts: {
        sidebarHeader: 'OneLife Guide',
        searchPlaceholder: 'Search guide...',
        uiSettings: 'Settings',
        uiSettingsDescription: 'Customize your guidebook experience.',
        changeTextSize: 'Text Size:',
        searchBar: 'Search Bar:',
        selectFont: 'Font:',
        availableFonts: [
            'Inter', 'Roboto', 'Arial', 'Lato', 'Montserrat', 'Open Sans', 'Raleway', 'Poppins', 'Ubuntu', 'JetBrains Mono'
        ]
    },

    categories: {
        gettingStarted: { // always unique
            title: '🚀 Getting Started',
            icon: 'fas fa-rocket',
            subcategories: {
                newPlayer: { // always unique
                    title: '🆕 New Player Guide',
                    icon: 'fas fa-user-plus',
                    content: `
                        <h3>🆕 Welcome to OneLife RP!</h3>
                        <p>Starting fresh in the city can feel overwhelming, but we're here to help! This guide will get you started on the right path.</p>

                        <div style="background: var(--gradient-primary); padding: 20px; border-radius: var(--radius-lg); margin: 20px 0; text-align: center;">
                            <h4>🎯 Quick Start Checklist</h4>
                            <ol style="text-align: left; display: inline-block; margin: 10px 0;">
                                <li>Read the basic rules below</li>
                                <li>Learn how to make money</li>
                                <li>Find important locations</li>
                                <li>Get your first license</li>
                                <li>Start roleplaying!</li>
                            </ol>
                        </div>

                        <h3>💰 How to Make Money as a New Player</h3>
                        <p>There are countless opportunities to earn cash:</p>
                        <ul>
                            <li><strong>📦 Box Delivery:</strong> Pick up boxes at postal 810 (city) or 041 (Paleto)</li>
                            <li><strong>🎣 Fishing:</strong> Head to postal 688 for fishing gear and start earning</li>
                            <li><strong>🏹 Hunting:</strong> Visit postal 049 to start hunting for hides and meat</li>
                            <li><strong>🚛 Trucking:</strong> Deliver goods across the city for steady income</li>
                            <li><strong>🚔 Join LSPD/EMS:</strong> Apply for whitelisted jobs for regular paychecks</li>
                        </ul>

                        <h3>📍 Essential Locations</h3>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin: 20px 0;">
                            <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red);">
                                <h4>🏪 Services</h4>
                                <ul>
                                    <li><strong>DMV:</strong> Postal 889-906 (licenses)</li>
                                    <li><strong>Mechanic:</strong> Look for wrench icons</li>
                                    <li><strong>Hospital:</strong> Medical emergencies</li>
                                </ul>
                            </div>
                            <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red);">
                                <h4>💼 Jobs</h4>
                                <ul>
                                    <li><strong>Fishing:</strong> Postal 688</li>
                                    <li><strong>Hunting:</strong> Postal 049</li>
                                    <li><strong>Boxes:</strong> Postal 810/041</li>
                                </ul>
                            </div>
                        </div>

                        <h3>📜 Get Your First License</h3>
                        <p>Visit the DMV (postal 889-906) to get your driver's license. Each license requires both a written and practical test.</p>

                        <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red); margin: 20px 0;">
                            <h4>💡 Pro Tip for New Players</h4>
                            <p>Start with box delivery or fishing - they're simple, reliable ways to earn money while you learn the city!</p>
                        </div>
                    `
                },
                basicRules: { // always unique
                    title: '📋 Basic Rules',
                    icon: 'fas fa-gavel',
                    content: `
                        <h3>📋 Essential Rules Every Player Must Know</h3>
                        <p>These are the most important rules to get you started safely in OneLife RP.</p>

                        <h3>🚫 What NOT to Do</h3>
                        <ul>
                            <li>❌ <strong>No RDM/VDM:</strong> Don't kill or run over players without roleplay reason</li>
                            <li>❌ <strong>No Metagaming:</strong> Don't use out-of-character knowledge in-game</li>
                            <li>❌ <strong>No Powergaming:</strong> Don't force actions on other players</li>
                            <li>❌ <strong>No Corruption:</strong> LSPD/EMS can't be corrupt or break character</li>
                            <li>❌ <strong>No AFK:</strong> Don't stay away for more than 15 minutes</li>
                        </ul>

                        <h3>✅ What TO Do</h3>
                        <ul>
                            <li>✅ <strong>Stay in Character:</strong> Always roleplay your character consistently</li>
                            <li>✅ <strong>Fear for Your Life:</strong> React realistically to dangerous situations</li>
                            <li>✅ <strong>Respect Others:</strong> Be respectful and create good RP for everyone</li>
                            <li>✅ <strong>Follow Fear RP:</strong> If someone has a gun on you, comply with demands</li>
                            <li>✅ <strong>Report Issues:</strong> Use proper channels for problems</li>
                        </ul>

                        <h3>🛡️ Safe Zones</h3>
                        <p>These areas are completely safe - no crime allowed:</p>
                        <ul>
                            <li>🏢 Police Department</li>
                            <li>🏥 Hospital</li>
                            <li>🏛️ City Hall</li>
                            <li>🚗 All Dealerships</li>
                            <li>🛠️ All Mechanic Shops</li>
                            <li>🏦 All Player Businesses</li>
                        </ul>

                        <div style="background: var(--gradient-primary); padding: 20px; border-radius: var(--radius-lg); margin: 20px 0; text-align: center;">
                            <h4>📖 Need More Details?</h4>
                            <p>Check out the complete <strong>Server Rules</strong> section for comprehensive information!</p>
                        </div>
                    `
                },
                aboutUs: { // always unique
                    title: 'About OneLife',
                    icon: 'fas fa-info-circle',
                    content: `
                        <h3>Welcome to OneLife RP 🎮</h3>
                        <p>Welcome to OneLife Roleplay! Experience the ultimate FiveM roleplay server where every decision matters and every life counts. This guide will help you navigate our immersive world.</p>
                        <h3>About OneLife</h3>
                        <p>OneLife RP offers a unique, realistic roleplay experience where every choice has consequences. Our server focuses on quality roleplay, community engagement, and creating memorable stories that last.</p>
                        <h3>Getting Started</h3>
                        <p>This guidebook contains everything you need to know about OneLife RP. From server rules to tutorials, we've got you covered for your journey ahead.</p>
                        <h3>Connect With Us</h3>
                        <p><a href="javascript:openExternalLink('https://discord.gg/onelife')">💬 Discord Server</a></p>
                        <p><a href="javascript:openExternalLink('https://onelife-rp.com')">🌐 Website</a></p>
                        <p><strong>Server IP:</strong> connect onelife-rp.com</p>
                        <img src="imgs/Onelife_transparent.png" alt="OneLife Logo" style="width:100%; height:auto; max-width: 300px; margin: 20px auto; display: block;"/>
                    `
                },
                rules: { // always unique
                    title: 'Server Rules',
                    icon: 'fas fa-gavel',
                    content: `
                        <h3>OneLife RP Server Rules 📜</h3>
                        <p>Welcome to OneLife Roleplay! Please take a moment to read through our comprehensive rules to ensure everyone has a safe and enjoyable experience.</p>
                        
                        <h3>🧠 Mental Health and Well-being</h3>
                        <ul>
                            <li>Roleplay can be intense. Remember to take care of your mental health.</li>
                            <li>If you feel overwhelmed, it's okay to take a break.</li>
                            <li>Our community is here to support you, and we encourage open discussions about well-being.</li>
                        </ul>

                        <h3>🆕 New Player Orientation</h3>
                        <ul>
                            <li>New to OneLife Roleplay? Welcome! We offer an orientation session or mentor system to help you get started.</li>
                            <li>Feel free to reach out to the Staff Team for more information.</li>
                        </ul>

                        <h3>🔔 Important Information</h3>
                        <ul>
                            <li>🚫 Please don't DM any Admin or Owner on Discord unless they ask you to. If you need to contact them, create a support ticket instead.</li>
                            <li>🎮 Do NOT approach or call any Owner, Admin, or Developer in the city about ticket progress, development queries, or out-of-city information. They are there to roleplay (RP) and should be treated like any other player.</li>
                            <li>⚠️ Not following these rules will have consequences.</li>
                        </ul>

                        <h3>🕒 Server Restarts</h3>
                        <ul>
                            <li>Log out safely before scheduled maintenance to avoid losing progress or items.</li>
                        </ul>

                        <h3>🌐 Conduct Outside the Server</h3>
                        <ul>
                            <li>How you behave in community spaces like Discord and social media reflects on our server.</li>
                            <li>Be respectful and supportive of each other.</li>
                            <li>Avoid toxic behavior, harassment, or spreading drama outside the game.</li>
                        </ul>

                        <h3>🔐 Your Account</h3>
                        <ul>
                            <li>🔒 It's your responsibility to keep your account details secure. OneLife Roleplay isn't responsible for hacked accounts.</li>
                            <li>⚠️ FiveM/CFX name should always be same as your character name and discord name - timeout will be given for non compliance.</li>
                        </ul>

                        <h3>👶 IRL Player Age</h3>
                        <ul>
                            <li>🎂 Our Roleplay community is for players aged 18 and above to maintain a mature environment for storytelling and character interactions.</li>
                        </ul>

                        <h3>🎙 Microphone/Audio</h3>
                        <ul>
                            <li>🎧 Your microphone and audio must always work for seamless communication.</li>
                            <li>🎤 Use "Push-To-Talk" as the default setting to keep the atmosphere respectful.</li>
                            <li>🎤 Voice changers should be avoided, especially if disturbing other members.</li>
                        </ul>
                    `
                },
                behavior: { // always unique
                    title: 'Behavior & Roleplay',
                    icon: 'fas fa-users',
                    content: `
                        <h3>🚸 Behavior Rules</h3>
                        <ul>
                            <li>💼 <strong>Server Staff Restrictions:</strong> Admins and staff from other servers need permission to join our server. Likewise, our admins and staff need approval to be on other servers.</li>
                            <li>❌ <strong>Harassment:</strong> Harassment or attacks towards another player will result in a ban.</li>
                            <li>💢 <strong>No Toxicity:</strong> We do NOT tolerate toxicity, including excessive foul language, racism, sexism, or inappropriate roleplay (e.g., using bodily fluids). This includes emotes and /me commands.</li>
                        </ul>

                        <h3>🚫 AFK Rules</h3>
                        <ul>
                            <li>Don't stay AFK (Away From Keyboard) for more than 15 minutes.</li>
                            <li>Log out if you need to step away longer, so others can join.</li>
                            <li>Items lost due to being afk is your own responsibility.</li>
                            <li>Once taken hostage in a non safe zone stating being afk won't be valid.</li>
                        </ul>

                        <h3>🛑 Respect for Personal Boundaries</h3>
                        <ul>
                            <li>Roleplay is encouraged, but respect others' boundaries.</li>
                            <li>If someone is uncomfortable with a certain roleplay (e.g., violent scenarios), respect their wishes and adjust accordingly.</li>
                        </ul>

                        <h3>🤝 Handling Personal Conflicts</h3>
                        <ul>
                            <li>Handle personal conflicts through support tickets. Keep respect and don't let personal issues affect roleplay.</li>
                        </ul>

                        <h3>🚷 Poaching</h3>
                        <ul>
                            <li>👥 Poaching is not allowed. If you're not actively participating in our city's RP and are just recruiting players for another server, you'll be banned.</li>
                        </ul>

                        <h3>🛡️ OneLife Roleplay Safe Zones</h3>
                        <p>Safe Zones are areas where all forms of criminal activity (e.g., hostage-taking, shooting, drug deals, stealing vehicles, robbing) are strictly prohibited. Doing anything illegal in these areas is a breach of server rules and will result in a warning or ban. Safe Zones can't be used to hide or escape an RP scene.</p>
                        <ul>
                            <li>🏢 Police Department</li>
                            <li>🏥 Hospital</li>
                            <li>🏛️ City Hall</li>
                            <li>⛏ Mining Foundry</li>
                            <li>♻️ Recycling (Both in-city and Paleto)</li>
                            <li>🚗 All Dealerships</li>
                            <li>🛠️ All Mechshops</li>
                            <li>🏦 All other Player owned Businesses</li>
                            <li>🕹️ Life Invader</li>
                            <li>🏛️ Government Entities</li>
                        </ul>
                    `
                },
                roleplay: { // always unique
                    title: 'Roleplay Guidelines',
                    icon: 'fas fa-theater-masks',
                    content: `
                        <h3>🚫 Prohibited Roleplay</h3>
                        <p>OneLife Roleplay has a strict policy against certain types of roleplay to ensure a safe environment for everyone. The following actions are prohibited:</p>
                        <ul>
                            <li>❌ <strong>Suicidal Roleplay:</strong> No roleplay involving suicide.</li>
                            <li>❌ <strong>Sexual Assault:</strong> No non-consensual sexual roleplay.</li>
                            <li>❌ <strong>Corrupt Law Enforcement:</strong> LSPD officers must uphold the law at all times, even off-duty.</li>
                            <li>❌ <strong>Erotic Roleplay (Sexual RP):</strong> Sexual roleplay is not allowed under any circumstances.</li>
                            <li>❌ <strong>Planned RP:</strong> Scenarios must develop naturally. Pre-arranging outcomes (e.g., deciding who wins a shootout beforehand) is prohibited. All roleplay should be spontaneous and driven by in-game situations.</li>
                        </ul>

                        <h3>🗣️ In-City Words</h3>
                        <p>Use these words in the city when referring to out-of-city concepts:</p>
                        <ul>
                            <li>🧠 <strong>In head</strong> - Not by PC</li>
                            <li>🧠 <strong>Brain</strong> - Your PC</li>
                            <li>👀 <strong>Eyes</strong> - Your Screen</li>
                            <li>🎙️ <strong>Voicebox</strong> - Your Microphone</li>
                            <li>🎧 <strong>Ears</strong> - Your Headset</li>
                            <li>👽 <strong>Alien</strong> - Real Life</li>
                            <li>👤 <strong>Person In Alien</strong> - Person In Real Life</li>
                            <li>🏛️ <strong>Government</strong> - Admin Team</li>
                            <li>👑 <strong>President</strong> - An Owner</li>
                            <li>🚧 <strong>Construction Workers</strong> - Development Team</li>
                            <li>📧 <strong>Email</strong> - Discord</li>
                            <li>💡 <strong>Brainshedding</strong> - Loadshedding</li>
                        </ul>

                        <h3>🚗 Realistic Driving</h3>
                        <ul>
                            <li>🛑 Don't use your vehicle unrealistically. For example, taking a supercar off-road, taking major jumps is Fail RP since it's not realistic.</li>
                            <li>🚓 PD ramming is prohibited. However, if you brake-check them and they ram you, it's your fault.</li>
                        </ul>

                        <h3>👤 Your Character</h3>
                        <ul>
                            <li>🎭 <strong>NEVER BREAK CHARACTER.</strong> Always stay consistent with your character's persona, including accents, behavior, and personality.</li>
                            <li>🧍 Your character defines you as a role-player. Never ignore or avoid roleplay.</li>
                            <li>🎭 <strong>Character Development:</strong> Invest time in developing your character's backstory, motivations, and evolution. Engaging in long-term storylines will enrich your roleplay experience and others'.</li>
                        </ul>

                        <h3>💥 RDM and VDM</h3>
                        <ul>
                            <li>🔫 <strong>Random Death Match (RDM):</strong> Intentionally killing or attacking another player's character without a valid in-character reason or roleplay interaction.</li>
                            <li>🚗 <strong>Vehicle Death Match (VDM):</strong> Using a vehicle to intentionally harm or kill other players' characters without a valid in-character reason or proper roleplay context</li>
                        </ul>

                        <h3>🎭 Character Continuity</h3>
                        <ul>
                            <li>Avoid frequent character swapping during the same session. Maintain continuity to ensure consistent and believable storylines.</li>
                        </ul>

                        <h3>🚨 Rulesplaining</h3>
                        <ul>
                            <li>🛑 Don't explain city rules during roleplay or talk about rule-breaking in RP interactions.</li>
                        </ul>

                        <h3>📹 Body Cam/Footage</h3>
                        <ul>
                            <li>📹 It's recommended to always have your body cam running. "Body Cam" refers to using Medal or Overwolf to record your gameplay. This is essential for player reports, proving innocence, or guilt.</li>
                        </ul>

                        <h3>💻 Hacking, Bugs, and Glitches</h3>
                        <ul>
                            <li>🚫 Using hacks, bugs, or glitches to gain an unfair advantage or disrupt roleplay is strictly prohibited. Offenders will face disciplinary action, including possible bans.</li>
                            <li>🐞 Report any glitches or bugs immediately.</li>
                        </ul>

                        <h3>📵 Metagaming</h3>
                        <ul>
                            <li>🚷 Using out-of-character (OOC) knowledge to influence in-character (IC) actions is prohibited. Examples include Stream Sniping and Discord Voice Chats.</li>
                        </ul>

                        <h3>⚔️ Powergaming</h3>
                        <ul>
                            <li>🚫 Powergaming means forcing your character's actions on others without allowing for fair and realistic responses.</li>
                            <li>🛠️ This includes using third-party mechanics like hacks or cheats to benefit your character in the city.</li>
                        </ul>

                        <h3>💰 Pocket Wiping</h3>
                        <ul>
                            <li>💼 Items taken during robberies should make sense for the character taking them. You can't remove all items from a player. Leave things like consumables (food and water). Only take illegal items.</li>
                            <li>💰 Cash can be robbed.</li>
                        </ul>

                        <h3>📹 Streaming and Content Creation</h3>
                        <ul>
                            <li>You're welcome to stream or create content from your gameplay. But be mindful of others' privacy and experiences.</li>
                            <li>Don't reveal sensitive in-game information that could spoil roleplay scenarios.</li>
                            <li>Always ask for consent before featuring other players prominently in your content.</li>
                        </ul>

                        <h3>🚫 Additional Prohibited Actions</h3>
                        <ul>
                            <li>🚫 <strong>Loot Boxing:</strong> Looting players without substantial roleplay context is prohibited.</li>
                            <li>🚔 <strong>Corruption:</strong> Emergency Workers can't be corrupt.</li>
                            <li>🛑 <strong>No "Golden Ticket" Roleplay:</strong> Avoid portraying your character as invincible or overly powerful. All characters should be fallible and subject to the same risks.</li>
                            <li>🩹 <strong>Roleplay Injuries:</strong> If injured during roleplay (e.g., shot, stabbed, car crash), you must roleplay the consequences, including seeking medical attention.</li>
                        </ul>
                    `
                },
                alienTranslation: { // always unique
                    title: '👽 Alien Translation',
                    icon: false,
                    content: `
                        <h3>👽 Alien Translation Guide</h3>
                        <p>Use these translations when referring to out-of-character concepts in the city. This helps maintain immersion and roleplay quality.</p>
                        
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin: 20px 0;">
                            <div>
                                <h4>🎮 Controls & Hardware</h4>
                                <ul>
                                    <li><strong>Press Button</strong> = Flex Muscle</li>
                                    <li><strong>Keyboard Button "X"</strong> = "X" Muscle</li>
                                    <li><strong>Screen</strong> = Eyes</li>
                                    <li><strong>Headset</strong> = Ears</li>
                                    <li><strong>Game/PC</strong> = Brain</li>
                                    <li><strong>Microphone</strong> = Voice Box</li>
                                </ul>
                            </div>
                            
                            <div>
                                <h4>🌐 Server & Community</h4>
                                <ul>
                                    <li><strong>Server</strong> = City</li>
                                    <li><strong>Online</strong> = In City</li>
                                    <li><strong>Logging Off</strong> = Flying Out</li>
                                    <li><strong>An Owner</strong> = President</li>
                                    <li><strong>Server Staff</strong> = Government</li>
                                    <li><strong>Development Team</strong> = Construction Workers</li>
                                </ul>
                            </div>
                            
                            <div>
                                <h4>👥 People & Communication</h4>
                                <ul>
                                    <li><strong>Players</strong> = Citizens</li>
                                    <li><strong>NPCs</strong> = Locals</li>
                                    <li><strong>Email</strong> = Discord</li>
                                </ul>
                            </div>
                            
                            <div>
                                <h4>⚖️ Rules & Events</h4>
                                <ul>
                                    <li><strong>Server Rules</strong> = Constitutional Law</li>
                                    <li><strong>Ban</strong> = Deport from City</li>
                                    <li><strong>Server Restart</strong> = Tsunami/Storm</li>
                                    <li><strong>Loadshedding</strong> = Brainshedding</li>
                                </ul>
                            </div>
                        </div>
                        
                        <div style="background: var(--dark-surface-2); padding: 20px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red); margin: 20px 0;">
                            <h4>💡 Usage Tips</h4>
                            <ul>
                                <li>Always use these terms when speaking in-character</li>
                                <li>This helps maintain the roleplay atmosphere</li>
                                <li>Other players will understand these terms</li>
                                <li>Using OOC terms breaks immersion</li>
                            </ul>
                        </div>
                    `
                },
                keybinds: { // always unique
                    title: '⌨️ Essential Commands',
                    icon: 'fas fa-keyboard',
                    content: `
                        <h3>⌨️ Essential Commands & Shortcuts</h3>
                        <p>Here are the main keybinds and commands you will need in OneLife RP:</p>
                        
                        <h4>📱 Basic Commands</h4>
                        <ul>
                            <li><strong>/welcome:</strong> Open this guidebook</li>
                            <li><strong>/phonebook:</strong> Open the Phonebook</li>
                            <li><strong>/medic:</strong> Call a medic if EMS is not on duty</li>
                        </ul>

                        <h4>🚨 Emergency Services</h4>
                        <ul>
                            <li><strong>/911ems:</strong> Call EMS in city</li>
                            <li><strong>/911:</strong> Call Police</li>
                        </ul>

                        <h4>⌨️ Keyboard Shortcuts</h4>
                        <ul>
                            <li><strong>TAB:</strong> Inventory</li>
                            <li><strong>F2:</strong> Open inventory (alternative)</li>
                            <li><strong>F3:</strong> Use action button</li>
                            <li><strong>F5:</strong> Open phone</li>
                        </ul>

                        <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red); margin: 20px 0;">
                            <h4>💡 Pro Tips</h4>
                            <ul>
                                <li>Use <strong>/phonebook</strong> to find other players' numbers</li>
                                <li>Call <strong>/911ems</strong> for medical emergencies when EMS is available</li>
                                <li>Use <strong>/medic</strong> as a backup when EMS is offline</li>
                                <li>Press <strong>TAB</strong> for quick inventory access</li>
                            </ul>
                        </div>
                    `
                },
                vote: { // always unique
                    title: '🗳️ Vote for Server',
                    icon: false,
                    content: `
                        <h3>🗳️ Vote for OneLife RP</h3>
                        <p>Don't forget to vote for the Server. After you've voted do <strong>/checkvote</strong> in City to claim your reward!</p>
                        
                        <div style="background: var(--gradient-primary); padding: 25px; border-radius: var(--radius-lg); text-align: center; margin: 20px 0;">
                            <h4>🎁 Get Rewards for Voting!</h4>
                            <p style="margin: 15px 0;">Help us grow by voting for OneLife RP on TrackyServer</p>
                            <a href="javascript:openExternalLink('https://www.trackyserver.com/server/onelife-roleplay-2363246')" class="special" style="background: rgba(255,255,255,0.2); color: white; padding: 12px 24px; border-radius: var(--radius-md); text-decoration: none; font-weight: bold; display: inline-block; margin: 10px 0;">
                                🗳️ VOTE NOW
                            </a>
                        </div>

                        <h4>📋 How to Vote & Claim Rewards</h4>
                        <ol>
                            <li>Click the "VOTE NOW" button above</li>
                            <li>Complete the voting process on TrackyServer</li>
                            <li>Return to the city and type <strong>/checkvote</strong></li>
                            <li>Claim your voting rewards!</li>
                        </ol>

                        <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red); margin: 20px 0;">
                            <h4>💡 Pro Tip</h4>
                            <p>Voting helps our server grow and get more visibility. The more players we have, the better the roleplay experience for everyone!</p>
                        </div>
                    `
                },
            }
        },
        jobsMoney: { // always unique
            title: '💼 Jobs & Money',
            icon: 'fas fa-briefcase',
            subcategories: {
                legalJobs: { // always unique
                    title: '💼 Legal Jobs',
                    icon: 'fas fa-handshake',
                    content: `
                        <h3>💼 Legal Jobs in OneLife</h3>
                        <p>Looking for steady, legal work? The city has plenty of options to keep you busy and earning money.</p>

                        <h3>🏢 Main Jobs</h3>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin: 20px 0;">
                            <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red);">
                                <h4>🚛 Trucking</h4>
                                <p>Deliver goods across the city and Paleto. Pay depends on distance and cargo.</p>
                                <p><strong>Location:</strong> Various depots around the city</p>
                            </div>
                            <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red);">
                                <h4>⛏️ Mining</h4>
                                <p>Gather ore and refine it into valuable materials.</p>
                                <p><strong>Location:</strong> Mining areas around the map</p>
                            </div>
                            <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red);">
                                <h4>🎣 Fishing</h4>
                                <p>Simple but reliable income at postal 688.</p>
                                <p><strong>Location:</strong> Postal 688 (Pier)</p>
                            </div>
                            <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red);">
                                <h4>🏹 Hunting</h4>
                                <p>Collect hides and meat at postal 049.</p>
                                <p><strong>Location:</strong> Postal 049</p>
                            </div>
                        </div>

                        <h3>💡 Side Hustles</h3>
                        <ul>
                            <li><strong>🚕 Taxi Driving:</strong> Offer rides to citizens for cash</li>
                            <li><strong>📦 Box Delivery:</strong> Quick way to earn by helping locals</li>
                            <li><strong>🎉 Event Work:</strong> Join races, community events, or RP gigs for extra pay</li>
                        </ul>

                        <h3>💰 How Payouts Work</h3>
                        <ul>
                            <li>Jobs usually pay based on time and effort - the more runs you do, the more you'll make</li>
                            <li>Some jobs (like trucking and mining) reward patience with higher payouts over time</li>
                            <li>Side hustles depend heavily on player interaction - the better you RP, the more you can earn</li>
                        </ul>

                        <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red); margin: 20px 0;">
                            <h4>💡 Pro Tip</h4>
                            <p>Stack different jobs and hustles until you find what fits your playstyle best!</p>
                        </div>
                    `
                },
                whitelistedJobs: { // always unique
                    title: '👮‍♂️ Whitelisted Jobs',
                    icon: 'fas fa-shield-alt',
                    content: `
                        <h3>👮‍♂️ Whitelisted Jobs</h3>
                        <p>These are special jobs that require application and approval. They offer unique experiences and responsibilities.</p>

                        <h3>🚔 Los Santos Police Department (LSPD)</h3>
                        <ul>
                            <li><strong>Requirements:</strong> Application, interview, and training</li>
                            <li><strong>Duties:</strong> Law enforcement, traffic control, investigations</li>
                            <li><strong>Restrictions:</strong> Cannot be in gangs or own businesses</li>
                            <li><strong>How to Apply:</strong> Visit the police station and speak with recruitment</li>
                        </ul>

                        <h3>🚑 Emergency Medical Services (EMS)</h3>
                        <ul>
                            <li><strong>Requirements:</strong> Medical knowledge and training</li>
                            <li><strong>Duties:</strong> Medical emergencies, patient transport, crime scene assistance</li>
                            <li><strong>Restrictions:</strong> Cannot be in gangs or own businesses</li>
                            <li><strong>How to Apply:</strong> Check Discord job announcements</li>
                        </ul>

                        <h3>🏛️ City Hall & Legal</h3>
                        <ul>
                            <li><strong>Requirements:</strong> Legal knowledge and application</li>
                            <li><strong>Duties:</strong> Court cases, legal advice, government services</li>
                            <li><strong>How to Apply:</strong> Contact City Hall or check announcements</li>
                        </ul>

                        <div style="background: var(--gradient-primary); padding: 20px; border-radius: var(--radius-lg); margin: 20px 0; text-align: center;">
                            <h4>📋 Application Process</h4>
                            <p>Check the <strong>Job Announcements</strong> channel in Discord for current openings and application instructions.</p>
                        </div>
                    `
                },
                businessOwnership: { // always unique
                    title: '🏢 Business Ownership',
                    icon: 'fas fa-building',
                    content: `
                        <h3>🏢 Owning a Business</h3>
                        <p>Dream of running your own business? Keep an eye on announcements for when applications open.</p>

                        <h3>📋 What You Can Apply For</h3>
                        <ul>
                            <li><strong>Restaurants & Cafes:</strong> Food service businesses</li>
                            <li><strong>Shops & Stores:</strong> Retail and specialty stores</li>
                            <li><strong>Services:</strong> Repair shops, salons, etc.</li>
                            <li><strong>Gangs:</strong> If you want to build your own crew</li>
                        </ul>

                        <h3>📝 Application Process</h3>
                        <ul>
                            <li>Applications don't have a strict format - make it unique!</li>
                            <li>Write it out, make a video, or pitch your idea however you like</li>
                            <li>If you have a concept for a business that doesn't exist, open a ticket and tell us</li>
                            <li>We'll work with you to bring your idea to life</li>
                        </ul>

                        <h3>💰 Business Rules</h3>
                        <ul>
                            <li>Business owners can only own one business at a time</li>
                            <li>Must be active in the city and host events bi-weekly</li>
                            <li>Maximum of 15 employees including the owner</li>
                            <li>Citizens must remove masks when entering businesses</li>
                        </ul>

                        <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red); margin: 20px 0;">
                            <h4>💡 Pro Tip</h4>
                            <p>Be creative with your business idea! The more unique and engaging, the better your chances of approval.</p>
                        </div>
                    `
                },
            }
        },
        criminal: { // always unique
            title: 'Criminal Activity',
            icon: 'fas fa-skull',
            subcategories: {
                fearRP: { // always unique
                    title: 'Fear RP & Safety',
                    icon: 'fas fa-exclamation-triangle',
                    content: `
                        <h3>⚠️ Fear RP Requirements</h3>
                        <ul>
                            <li>If your life is in direct danger you must RP adequate fear and comply with demands given to you, if you are able to provide appropriate character development for your actions, for example: giving your loved one up to be killed, taking a bullet for another gang member etc.</li>
                            <li>Direct danger could mean, for example, a solo officer responding to shots fired, a 2 pd vs 4 crim scene, a gun aimed at your head, at you from close vicinity, by any player, or your character on their knees.</li>
                            <li>You are not showing proper fear if you run while on foot or in a vehicle and a weapon is aimed at you at close range, or if you drive into an active shootout more than once without the intent of providing cover or fleeing with it.</li>
                            <li>You always have the option to react, but this does NOT mean you can just say "I play my character as fearless" and run into whatever situation you'd like.</li>
                        </ul>

                        <h3>👑 Passive Winning Mentality</h3>
                        <ul>
                            <li>Whether you're PD, EMS, civilian, or gang member, roleplay with the mentality that your character's life is at risk. There's no "winning" in roleplay; focus on realistic reactions to danger and risk.</li>
                            <li>Once you lose a scene proceed with RP same applies once being arrested or taken hostage this is part of RP make the best of it.</li>
                        </ul>

                        <h3>🛻 Rules Regarding Trailers & Tow Trucks</h3>
                        <ul>
                            <li>‼️ Trailers & Tow Trucks are intended for Role-Playing purposes & should not be misused for Powergaming Criminal Boosting activities. They are meant to enhance actual RP scenes.</li>
                        </ul>
                    `
                },
                gangRules: { // always unique
                    title: 'Gang Rules',
                    icon: 'fas fa-users-cog',
                    content: `
                        <h3>🕵️‍♂️ Criminal Activity Rules</h3>
                        <ul>
                            <li>🕒 <strong>Crime-free period:</strong> A crime-free period is enforced 30 minutes before and 15 minutes after the scheduled server restart. Not following this rule will result in a warning.</li>
                            <li>🚫 <strong>No chain robberies:</strong> Chain robberies are not allowed.</li>
                            <li>🔫 <strong>Shootout cooldown:</strong> After a shootout between gangs, there's a 60-minute cooldown before another can begin.</li>
                            <li>🚑 <strong>EMS response:</strong> Once crims won a shootout they have 5 min to leave before ems starts helping LSPD, crims are not allowed to move law enforcement body's.</li>
                            <li>👥 <strong>Gang size limit:</strong> Gangs can have a maximum of 15 members, including the Gang Boss.</li>
                            <li>👕 <strong>Gang clothing:</strong> Gang members must wear their gang clothing during activities.</li>
                            <li>🚗 <strong>Gang vehicles:</strong> Gang vehicles must be in their gang colors.</li>
                            <li>🤝 <strong>No alliances:</strong> Friendly interactions and business arrangements are allowed, but alliances between gangs are prohibited.</li>
                            <li>🚔 <strong>Territory taking:</strong> Territory taking is only allowed when there is sufficient LSPD on duty.</li>
                            <li>⚠️ <strong>Strikes:</strong> Gangs breaking rules will receive a Strike.</li>
                        </ul>

                        <h3>🕵️‍♀️ Gang Rules</h3>
                        <ul>
                            <li>🌍 <strong>Gang wars:</strong> Gang wars away from gang compounds or premises won't be treated as a gang raid.</li>
                            <li>🗣️ <strong>LSPD intervention:</strong> LSPD can only intervene after 45 min of official gang raids unless dispatch was sent to request involvement. Attackers should be seen as suspects & defenders as Victims.</li>
                            <li>🚔 <strong>Fear RP:</strong> All players, including gangs, must realistically fear for their lives. Gangs must comply if outnumbered or outgunned.</li>
                            <li>⚠️ <strong>Strikes:</strong> Gangs breaking rules will receive a Strike. All server rules apply to gangs. Admin discretion to disband.</li>
                            <li>🚫 <strong>Street Gangs:</strong> Street gangs can't grow beyond five members and can't disrupt official gangs' balance. They'll be disbanded if found causing excessive disruption.</li>
                            <li>🤝 <strong>Small Groups vs. Gangs:</strong> Small groups (non-gang members) can engage in hostile actions like robbery or taking a gang member hostage if there's a clear in-character reason. But they must realistically overpower the gang members in numbers or tactics.</li>
                            <li>🔫 <strong>Overpowering a Gang:</strong> Small groups robbing or taking a gang member hostage must demonstrate a clear tactical advantage, like superior numbers, better positioning, or more effective weapons. Gangs aren't invincible and must respond realistically.</li>
                            <li>🚓 <strong>LSPD Involvement:</strong> If a small group overpowers a gang, LSPD may get involved to maintain order.</li>
                            <li>📊 <strong>Gang Activity:</strong> Gangs must be active participants in the city. Inactive gangs for more than two weeks without RP activity may be disbanded or reassigned. The Admin team will monitor inactivity and issue warnings before action.</li>
                        </ul>

                        <h3>❌ No Alliances Between Gangs</h3>
                        <ul>
                            <li>Gangs must operate independently. Alliances disrupt the balance of power. Any gang forming alliances will face disciplinary action.</li>
                            <li>💢 <strong>Gang Wars and Harassment:</strong> Gang wars shouldn't be taken personally. Continuous harassment after a gang war is over won't be tolerated.</li>
                        </ul>
                    `
                },
                heistRules: { // always unique
                    title: 'Heist Rules',
                    icon: 'fas fa-bank',
                    content: `
                        <h3>🚨 LSPD Heist Rules</h3>
                        <ul>
                            <li>🚔 <strong>PD Response:</strong> PD is allowed to have plus two in all heists.</li>
                            <li>🚗 <strong>Chases:</strong> 1 criminal vehicle = 3 PD vehicles, 1 x helicopter.</li>
                            <li>👮‍♂️ <strong>Officer as hostage:</strong> No limit to PD responding.</li>
                            <li>🕒 <strong>Response time:</strong> Crims need to wait 20min for PD to respond before leaving.</li>
                        </ul>

                        <h3>🕒 Tier 1 (30 min Cooldown)</h3>
                        <ul>
                            <li>🏠 House robbery (1-3 max crims)</li>
                            <li>🏪 Store robbery (1-4 max crims)</li>
                        </ul>

                        <h3>🕒 Tier 2 (45 min Cooldown)</h3>
                        <ul>
                            <li>🏦 Fleeca Bank (3-6 max crims)</li>
                            <li>💰 Cash Ex (3-6 x Suspects)</li>
                            <li>👕 Laundry (3-6 x Suspects)</li>
                            <li>💎 Vangelico (4-8 x Suspects)</li>
                        </ul>

                        <h3>🕒 Tier 3 (60 min Cooldown)</h3>
                        <ul>
                            <li>🏦 Paleto Bank (4-8 x Suspects)</li>
                            <li>🏦 Maze Bank (4-8 x Suspects)</li>
                            <li>⛴️ Yacht Heist (4-8 x Suspects)</li>
                            <li>🏦 Union Heist(6-10 x Suspects)</li>
                            <li>🏦 Humane Labs (6-10 x Suspects)</li>
                            <li>🐱‍👤 Bobcat (4-8 x Suspects)</li>
                            <li>🏦 Main Bank (6-12 x Suspects)</li>
                            <li>🛢️ Oil Rig (6-15 x Suspects)</li>
                            <li>🏢 Casino (8-15 x Suspects)</li>
                        </ul>

                        <h3>🕒 Tier X (30 min Cooldown)</h3>
                        <ul>
                            <li>⚖️ Prison Break</li>
                            <li>🚗 Boosting</li>
                            <li>💉 Drug Dealings</li>
                            <li>🏧 Atm Robbery</li>
                        </ul>

                        <p><strong>On Tier X Crimes</strong> - Interactions needs to take place before LSPD adhere to +2 Rule & Match vehicles if available.</p>

                        <h3>👮 Officer Response to Overlimit Suspects</h3>
                        <ul>
                            <li>If the number of suspects exceeds the limit during a heist, LSPD will respond with +4 Officers instead of +2 to indicate the situation without breaking RP by asking suspects to break off.</li>
                            <li>If the number of suspects does not meet the minimum limit during a heist, LSPD will respond with +4 Officers instead of +2 to indicate the situation without breaking RP by asking suspects to break off.</li>
                            <li>Requesting/Forcing a Shootout including no interaction + 4 officers allowed</li>
                        </ul>

                        <h3>🚁 Air - 1 Thermals</h3>
                        <ul>
                            <li>🌙 Only allowed to be used on open scene's once inline with SOP's.</li>
                            <li>👮‍♂️ Authorization needs to be requested before use on close or open scene's.</li>
                            <li>🌊 Can always be used when suspects is fleeing into the ocean.</li>
                        </ul>

                        <h3>🚓 Prisoner Transports</h3>
                        <ul>
                            <li>👮‍♂️ Escorts will be arranged only if Officers is available.</li>
                            <li>🚓 Prisoner transports is allowed to be intercepted by crims whilst abiding by the rules. at Own Risk.</li>
                        </ul>
                    `
                },
            }
        },
        patreon: { // always unique
            title: 'Patreon',
            icon: 'fas fa-crown',
            subcategories: {
                howToJoin: { // always unique
                    title: '💎 How to Join Patreon',
                    icon: false,
                    content: `
                        <h3>Patreon Membership Guide</h3>
                        <p>To join our Patreon community, follow these steps:</p>
                        <ol>
                            <li>Visit our Patreon: <a href="javascript:openExternalLink('https://www.patreon.com/OneLifeRPSA')">🌐 OneLife Patreon</a></li>
                            <li>Choose your desired membership tier.</li>
                            <li>Complete the payment process.</li>
                            <li>After payment, your Patreon benefits will be activated automatically.</li>
                            <li>Join our Discord to access exclusive channels and content.</li>
                        </ol>
                    `
                },
                patreonTiers: { // always unique
                    title: '✨ Patreon Tiers',
                    icon: false,
                    content: `
                        <h3>OneLife RP Patreon Tiers</h3>
                        
                        <h3>🎭 Gangs - $5/month</h3>
                        <ul>
                            <li>✅ Discord Donator role</li>
                            <li>✅ Sneak Peaks of what devs are busy with</li>
                            <li>✅ Exclusive access to OneLife Donators channel</li>
                            <li>✅ Exclusive Gang Vehicles Pack</li>
                            <li>✅ Discord access</li>
                        </ul>

                        <h3>🏆 Tier 1 - $10/month (Most Popular)</h3>
                        <ul>
                            <li>✅ Discord Donator role</li>
                            <li>✅ Custom Number Plates</li>
                            <li>✅ Exclusive access to OneLife Donators channel</li>
                            <li>✅ Sneak Peaks of what devs are busy with</li>
                            <li>✅ Storage (150 Slots, 50,000 kg)</li>
                            <li>✅ 25+ Custom Cars</li>
                            <li>✅ Discord access</li>
                        </ul>

                        <h3>🥇 Tier 2 - $15/month</h3>
                        <ul>
                            <li>✅ Custom Number Plates</li>
                            <li>✅ Exclusive access to OneLife Donators channel</li>
                            <li>✅ Sneak Peaks of what devs are busy with</li>
                            <li>✅ Discord Donator role</li>
                            <li>✅ Storage (300 Slots, 100,000 kg)</li>
                            <li>✅ 50+ Custom Cars</li>
                            <li>✅ Discord access</li>
                        </ul>

                        <h3>👑 Tier 3 - $20/month (Limited - 6 remaining)</h3>
                        <ul>
                            <li>✅ Custom Number Plates</li>
                            <li>✅ Exclusive access to OneLife Donators channel</li>
                            <li>✅ Sneak Peaks of what devs are busy with</li>
                            <li>✅ Discord Donator role</li>
                            <li>✅ Storage (500 Slots, 200,000 KG)</li>
                            <li>✅ 75+ Custom Cars</li>
                            <li>✅ Discord access</li>
                        </ul>

                        <p><a href="javascript:openExternalLink('https://www.patreon.com/OneLifeRPSA')" class="special">🌐 Join OneLife Patreon Now</a></p>
                    `
                },
            }
        },
        business: { // always unique
            title: 'Business & Property',
            icon: 'fas fa-building',
            subcategories: {
                businessRules: { // always unique
                    title: '🏢 Business Rules',
                    icon: false,
                    content: `
                        <h3>🏢 Business Regulations</h3>
                        <ul>
                            <li>🚫 <strong>One Business Limit:</strong> Business owners can only own one business at a time.</li>
                            <li>💰 <strong>Purchase & Sale:</strong> Businesses are bought from the government at a set price and must be sold back to the government by the original purchaser.</li>
                            <li>🏢 <strong>Co-Ownership:</strong> A business owner can have a business partner (co-owner). If the original purchaser sells the business, all rights of the co-owners are relinquished.</li>
                            <li>🎭 <strong>Mask Removal:</strong> Citizens must remove their masks when entering a business.</li>
                            <li>📨 <strong>Always Online:</strong> Owners must shoot the ninja turtle brah at all times.</li>
                            <li>👥 <strong>Employee Management:</strong> Business Owners are responsible for Role Requests and Removals of their employees.</li>
                            <li>⚠️ <strong>Activity Requirement:</strong> Business owners must be active in the city and are expected to host events. If inactive, the business will be repossessed with no refund.</li>
                            <li>👥 <strong>Employee Limit:</strong> Each business can only have fifteen employees, including the Owner.</li>
                            <li>🗓️ <strong>Event Requirement:</strong> Business owners must host events at least bi-weekly. Failure to do so may result in the business being repossessed with no refund.</li>
                        </ul>

                        <h3>👮 Whitelisted Jobs</h3>
                        <ul>
                            <li>🎓 <strong>Job Limit:</strong> Citizens can have a maximum of one whitelisted jobs.</li>
                            <li>🚓 <strong>Restrictions:</strong> Business owners, LSPD, and EMS can't have any other whitelisted job.</li>
                            <li>💼 <strong>Gang Boss/Underboss:</strong> Can be employed at a Whitelisted Job, Can't Be Owner or Co-Owner excluding PD & EMS.</li>
                            <li>💰 <strong>Business Owner/Co-Owner:</strong> Can be part of gang - Can't be Boss or Underboss.</li>
                            <li>🚫 <strong>Gang Member Limit:</strong> Max limit of 5 associated gang members per Whitelisted Business.</li>
                            <li>🎭 <strong>No Gang Clothes:</strong> No gang clothes when on duty.</li>
                        </ul>
                    `
                },
                propertyRules: { // always unique
                    title: '🏠 Property Rules',
                    icon: false,
                    content: `
                        <h3>🏢 Property Regulations</h3>
                        <h4>Real Estate Ownership</h4>
                        <ul>
                            <li>🏡 <strong>Property Limit:</strong> You can own a maximum of one house in the city. This prevents property hoarding and ensures fair access.</li>
                            <li>🔄 <strong>Ownership Transfer:</strong> You can sell or transfer property ownership to others. All transactions must be documented and approved by City Hall to prevent exploitation.</li>
                            <li>🚫 <strong>Prohibited Uses:</strong> Don't use properties to exploit game mechanics, like storing excessive illegal items or bypassing cooldowns. Offenders may lose property ownership.</li>
                            <li>📜 <strong>Inactive Properties:</strong> If you're inactive for an extended period (e.g., 60 days for owned properties, 30 days for rentals), your property may be repossessed by the real estate department and made available to others. Warnings will be issued first.</li>
                        </ul>

                        <h3>🏦 Roles</h3>
                        <ul>
                            <li>🚓 <strong>LSPD:</strong> The Los Santos Police Department handles law enforcement and public safety.</li>
                            <li>🚑 <strong>EMS:</strong> Emergency Medical Services provide medical assistance and care.</li>
                            <li>🏛️ <strong>City Hall (Department of Justice):</strong> Manages legal matters, including court cases and disputes. Lawyers and legal professionals in the city operate under this department.</li>
                            <li>🧍 <strong>Hostages:</strong> Being taken hostage is part of RP, many doors open with this role in a scene, fear your life and respect your hostages as well as your hostage takers. Hostages must be independent to the crims, taking friends, fellow employees & own gang members hostage is low quality RP.</li>
                        </ul>
                    `
                },
            }
        },
        lifestyle: { // always unique
            title: '🏠 Lifestyle & Community',
            icon: 'fas fa-heart',
            subcategories: {
                property: { // always unique
                    title: '🏡 Property & Housing',
                    icon: 'fas fa-home',
                    content: `
                        <h3>🏡 Owning Property</h3>
                        <p>Want your own place to call home? Our property system allows you to buy and fully customize almost any house in the city.</p>

                        <h3>💰 Property Prices</h3>
                        <ul>
                            <li>Prices range from R500k to R10+ million</li>
                            <li>Depends on location and size</li>
                            <li>Work with a real estate agent to find the perfect spot</li>
                        </ul>

                        <h3>🎨 Customization</h3>
                        <ul>
                            <li>Interiors and design are completely up to your creativity</li>
                            <li>Make it your own unique space</li>
                            <li>Host events and gatherings</li>
                        </ul>

                        <h3>📜 Property Rules</h3>
                        <ul>
                            <li>You can own a maximum of one house in the city</li>
                            <li>You can sell or transfer ownership to others</li>
                            <li>Don't use properties to exploit game mechanics</li>
                            <li>Inactive properties may be repossessed after warnings</li>
                        </ul>

                        <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red); margin: 20px 0;">
                            <h4>💡 Pro Tip</h4>
                            <p>Start saving early! Property ownership opens up many roleplay opportunities and gives you a place to call your own.</p>
                        </div>
                    `
                },
                carCustomization: { // always unique
                    title: '🚗 Car Customization',
                    icon: 'fas fa-car',
                    content: `
                        <h3>🚗 Car Customization</h3>
                        <p>Hate how your car looks, sounds, or drives? Stop by any mechanic shop in the city and get it fixed up.</p>

                        <h3>🔧 What You Can Customize</h3>
                        <ul>
                            <li><strong>🎵 Sound Systems:</strong> Over 100+ car sounds to choose from</li>
                            <li><strong>⚡ Performance:</strong> Upgrades to make your ride faster and smoother</li>
                            <li><strong>🎨 Visual:</strong> Paint, wheels, body kits, and more</li>
                            <li><strong>🔧 Mechanical:</strong> Engine, transmission, and suspension upgrades</li>
                        </ul>

                        <h3>📍 Where to Go</h3>
                        <ul>
                            <li>Look for mechanic shops around the map</li>
                            <li>They're marked with a spanner and wrench icon</li>
                            <li>Each shop may have different services and prices</li>
                        </ul>

                        <h3>💰 Customization Costs</h3>
                        <ul>
                            <li>Prices vary depending on the modifications</li>
                            <li>More expensive upgrades provide better performance</li>
                            <li>Visual modifications are usually cheaper than performance</li>
                        </ul>

                        <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red); margin: 20px 0;">
                            <h4>💡 Pro Tip</h4>
                            <p>Start with basic modifications and work your way up. A well-tuned car can make all the difference in chases and races!</p>
                        </div>
                    `
                },
                racingEvents: { // always unique
                    title: '🏁 Racing & Events',
                    icon: 'fas fa-flag-checkered',
                    content: `
                        <h3>🏁 Racing & Events</h3>
                        <p>OneLife isn't just about jobs and crime - it's also about fun, creativity, and community. If you've got an idea for an event, we want to hear it!</p>

                        <h3>🎉 City Events</h3>
                        <p>In OneLife, events don't only come from staff - you can create them too. Simply open an event ticket, share your idea, and we'll help make it possible.</p>
                        
                        <h4>Popular Event Types</h4>
                        <ul>
                            <li>Drag races</li>
                            <li>Drift competitions</li>
                            <li>F1 races</li>
                            <li>Hide & Seek</li>
                            <li>And many more…</li>
                        </ul>

                        <h3>🏎️ F1 Racing</h3>
                        <p>Love racing? So do we. OneLife has a massive F1 island where you can test your driving skills:</p>
                        <ul>
                            <li>Host official F1 races</li>
                            <li>Practice with dedicated F1 cars or even your personal vehicles</li>
                            <li>Use the racing tablet to design your own tracks</li>
                            <li>Race on community-made tracks</li>
                        </ul>

                        <h3>🏃‍♂️ Street Racing & Clubs</h3>
                        <p>Create your own street races around the city, map out custom routes, and even start your own street racing club. There are no limits - racing is part of the RP, and how far you take it is up to you.</p>

                        <div style="background: var(--gradient-primary); padding: 20px; border-radius: var(--radius-lg); margin: 20px 0; text-align: center;">
                            <h4>🎯 Want to Host an Event?</h4>
                            <p>Open a ticket with your event idea and we'll help make it happen!</p>
                        </div>
                    `
                },
                criminalLife: { // always unique
                    title: '🔫 Criminal Life',
                    icon: 'fas fa-mask',
                    content: `
                        <h3>🔫 Criminal Life in OneLife</h3>
                        <p>The streets of OneLife offer more than legal work - there's an entire underworld waiting for those bold enough to step into it.</p>

                        <h3>👥 Joining a Gang</h3>
                        <ul>
                            <li>Every gang has its own way of recruiting</li>
                            <li>Some look for loyalty, others test your skills</li>
                            <li>Many use unique clothing or car colors for identification</li>
                            <li>You can still hold a whitelisted job (like EMS) while being in a gang</li>
                            <li>The only off-limits job is LSPD</li>
                        </ul>

                        <h3>🏦 Heists & Robberies</h3>
                        <p>Heists in OneLife start small and grow bigger as you climb the ladder. Each one can be done either loud or silent, and each offers unique loot.</p>
                        
                        <h4>Heist Progression</h4>
                        <p>ATM → House → Store → Fleeca → Yacht → Paleto → Bobcat → Humane → Vangelico → Union → Main Bank → Oil Rig → Casino → more…</p>

                        <h3>🛒 Illegal Trades</h3>
                        <ul>
                            <li>Crafting and selling weapons, ammo, and hacking tools</li>
                            <li>Trading heist cards with other gangs or civilians for profit</li>
                            <li>Running drugs and fighting over territories</li>
                        </ul>

                        <div style="background: var(--dark-surface-2); padding: 15px; border-radius: var(--radius-md); border-left: 4px solid var(--primary-red); margin: 20px 0;">
                            <h4>⚠️ Warning</h4>
                            <p>Life in crime is dangerous but rewarding - every choice has consequences. Make sure you understand the risks before diving in!</p>
                        </div>
                    `
                },
            }
        },

        community: { // always unique
            title: 'Community',
            icon: 'fas fa-heart',
            subcategories: {
                staffDiscretion: { // always unique
                    title: '👨‍💼 Staff Discretion',
                    icon: false,
                    content: `
                        <h3>🚨 Staff Discretion</h3>
                        <ul>
                            <li>Staff has the final say on all server-related issues. If a staff member makes a decision, it's final.</li>
                            <li>Don't go directly to server management about issues. Start with a Moderator, and they'll handle it.</li>
                            <li><strong>Reporting Issues:</strong> If you find a bug or issue in the server, report it through the proper channels. Exploiting bugs for personal gain is forbidden and will be met with disciplinary action.</li>
                        </ul>

                        <h3>🗣️ Community Feedback</h3>
                        <ul>
                            <li>We value player input. Regular community feedback sessions will be held to discuss ideas, suggestions, and concerns.</li>
                            <li>You can also submit feedback anytime through our suggestion box on Discord.</li>
                        </ul>

                        <h3>💼 Property Regulations - Assets and Files</h3>
                        <ul>
                            <li>All assets and files on the server belong to OneLife Roleplay and are accessible to all players while on the server.</li>
                            <li>Any assets donated to the server become the property of OneLife Roleplay. No refunds or removals will be issued if you or the asset are removed or leave the community.</li>
                            <li>Attempts to duplicate, resell, repurpose, or steal these assets are strictly prohibited. Violators will face disciplinary action, including server bans, reports to CFx, Discord, and possible legal action.</li>
                            <li>Report any such behavior to the staff immediately.</li>
                        </ul>

                        <h3>📜 Disclaimers</h3>
                        <ul>
                            <li>We don't issue refunds on items, cars, money, etc., lost due to bugs/exploits unless verified by our development team. Report any bugs that cause loss immediately.</li>
                            <li><strong>Backup Rules:</strong> During large events or emergencies (e.g., bank heists, gang wars), only those directly involved in the roleplay should respond. Avoid overwhelming a scene with unnecessary backup unless it fits the roleplay context.</li>
                            <li>This document may change, and members must stay updated on the rules. All assets given to OneLife Roleplay belong to us. If you leave, we keep the assets.</li>
                            <li>OneLife is a roleplaying community and is not affiliated with any official government, law enforcement, or security agency. We are also not affiliated with Rockstar Games, Grand Theft Auto V, or Project Cfx.re.</li>
                        </ul>

                        <h3>🚨 Emergency Protocols</h3>
                        <ul>
                            <li>If there's a server crash, major bug, or significant issue, all players should pause their roleplay and await instructions from the Admin Team.</li>
                            <li>Don't exploit these situations for personal gain or to advance roleplay scenarios. Our priority is to ensure a fair and enjoyable experience for all.</li>
                        </ul>
                    `
                },
            }
        },
    }
};
