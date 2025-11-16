ServerConfig = {
    Discord = {
        Enabled = true,
        Webhooks = {
            [Logs.TREE_PLACED] = {
                url = 'YOUR_WEBHOOK',
                username = 'Tree',
                embeds = {
                    {
                        color = 32768,
                        title = '**Tree Placed**',
                        description =
                        '**{player.name}** *({player.id}, {player.identifier})* placed a tree **{data.tree}** at `{data.position.coords}`, rotation: `{data.position.rotation}`, heading: `{data.position.heading}`.',
                    }
                }
            },
            [Logs.TREE_DESTROYED] = {
                url = 'YOUR_WEBHOOK',
                username = 'Tree',
                embeds = {
                    {
                        color = 16711680,
                        title = '**Tree Destroyed**',
                        description =
                        '**{player.name}** *({player.id}, {player.identifier})* destroyed a tree **{data.tree}** at `{data.position.coords}`.',
                    }
                }
            },
            [Logs.TREE_DECORATED] = {
                url = 'YOUR_WEBHOOK',
                username = 'Tree',
                embeds = {
                    {
                        color = 16753920,
                        title = '**Tree Decorated**',
                        description =
                        '**{player.name}** *({player.id}, {player.identifier})* decorated a tree **{data.tree}** at `{data.position.coords}`.',
                    }
                }
            },
            [Logs.TREE_ADMIN_DELETE] = {
                url = 'YOUR_WEBHOOK',
                username = 'Tree',
                embeds = {
                    {
                        color = 16711680,
                        title = '**Tree Admin Deleted**',
                        description =
                        'Admin **{player.name}** *({player.id}, {player.identifier})* deleted a tree **{data.tree}** at `{data.position.coords}`.',
                    }
                }
            },
            [Logs.SNOWMAN_BUILT_PART] = {
                url = 'YOUR_WEBHOOK',
                username = 'Snowman',
                embeds = {
                    {
                        color = 16753920,
                        title = '**Snowman Part Built**',
                        description =
                        '**{player.name}** *({player.id}, {player.identifier})* built a **{data.part}** part of a snowman at `{data.position.coords}`.',
                    }
                }
            },
            [Logs.SNOWMAN_BUILT_FULL] = {
                url = 'YOUR_WEBHOOK',
                username = 'Snowman',
                embeds = {
                    {
                        color = 32768,
                        title = '**Snowman Built**',
                        description =
                        '**{player.name}** *({player.id}, {player.identifier})* built a snowman `{data.snowman}` at `{data.position.coords}`.',
                    }
                }
            },
            [Logs.SNOWMAN_DESTROYED] = {
                url = 'YOUR_WEBHOOK',
                username = 'Snowman',
                embeds = {
                    {
                        color = 32768,
                        title = '**Snowman Destroyed**',
                        description =
                        '**{player.name}** *({player.id}, {player.identifier})* destroyed a snowman `{data.snowman}` at `{data.position.coords}`.',
                    }
                }
            },
            [Logs.SNOWMAN_ADMIN_DELETE_PART] = {
                url = 'YOUR_WEBHOOK',
                username = 'Snowman',
                embeds = {
                    {
                        color = 32768,
                        title = '**Snowman Part Deleted**',
                        description =
                        'Admin **{player.name}** *({player.id}, {player.identifier})* deleted a snowman part at `{data.position.coords}`.',
                    }
                }
            },
            [Logs.SNOWMAN_ADMIN_DELETE_FULL] = {
                url = 'YOUR_WEBHOOK',
                username = 'Snowman',
                embeds = {
                    {
                        color = 32768,
                        title = '**Snowman Deleted**',
                        description =
                        'Admin **{player.name}** *({player.id}, {player.identifier})* deleted a snowman `{data.snowman}` at `{data.position.coords}`.',
                    }
                }
            },
            [Logs.PRESENT_COLLECTED] = {
                url = 'YOUR_WEBHOOK',
                username = 'Present',
                embeds = {
                    {
                        color = 16753920,
                        title = '**Present Collected**',
                        description =
                        '**{player.name}** *({player.id}, {player.identifier})* collected a present `{data.present}` at `{data.position.coords}`.\nRewards: {data.rewards}',
                    }
                }
            },
            [Logs.GIFT_UNPACKED] = {
                url = 'YOUR_WEBHOOK',
                username = 'Gift',
                embeds = {
                    {
                        color = 16753920,
                        title = '**Gift Unpacked**',
                        description =
                        '**{player.name}** *({player.id}, {player.identifier})* unpacked a gift.\nRewards: {data.rewards}',
                    }
                }
            },
            [Logs.GIFT_PACKED] = {
                url = 'YOUR_WEBHOOK',
                username = 'Gift',
                embeds = {
                    {
                        color = 16753920,
                        title = '**Gift Packed**',
                        description =
                        '**{player.name}** *({player.id}, {player.identifier})* packed a gift with nametag text **{data.nametag}**.\nRewards: {data.rewards}',
                    }
                }
            }
        }
    }
}
