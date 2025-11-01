--- WEBHOOKS ---

function WebhookLogs(logType, source, logData)
  Debugprint("WebhookLogs", logType, source, logData)
  local discord_webhook
  local headers
  local data
  if logType == "advertising" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "AdvertisingAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "AdvertisingAPP",
          ['description'] = '**Phone Number:** ' ..logData[1].. '\n**Message:** ' ..logData[2].. '\n**Filter:** ' ..logData[4]
        }
      }
    }

    if type(logData[3]) == "table" then
      for k, l in pairs(logData[3]) do
        if k == 1 then
          data['embeds'][1]['url'] = "https://www.gkshop.org/GKSHOP1.png"
          data['embeds'][1]['image'] = {
            ["url"] = l
          }
        else
          data['embeds'][k] = {
            ["url"] = "https://www.gkshop.org/GKSHOP1.png",
            ["image"] = {
              ["url"] = l
            }
          }
        end
      end
    end
  elseif logType == "bank" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "BankAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BankAPP",
          ['description'] = '**Sender Phone Number:** ' ..logData[1].. '\n**Receiver Phone Number:** ' ..logData[2].. '\n**Amount:** ' ..logData[3].. '\n**Sender Description:** ' ..logData[4].. '\n**Receiver Description:** ' ..logData[5] .. '\n**Sender Citizen ID:** ' ..logData[6].. '\n**Receiver Citizen ID:** ' ..logData[7]
        }
      }
    }
  elseif logType == "carsellerAddPost" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "CarSellerAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "CarSellerAPP Add Post",
          ['description'] = '**ID:** ' ..logData.id.. '\n**Player Name:** ' ..logData.player_name.. '\n**Phone Number:** ' ..logData.phone_number.. '\n**Plate:** ' ..logData.plate.. '\n**Model:** ' ..logData.model.. '\n**Price:** ' ..logData.price..  '\n**Identifier:** ' ..logData.identifier
        }
      }
    }

    if type(logData.image) == "table" then
      for k, l in pairs(logData.image) do
        if k == 1 then
          data['embeds'][1]['url'] = "https://www.gkshop.org/GKSHOP1.png"
          data['embeds'][1]['image'] = {
            ["url"] = l
          }
        else
          data['embeds'][k] = {
            ["image"] = {
              ["url"] = l
            },
            ["url"] = "https://www.gkshop.org/GKSHOP1.png",
          }
        end
      end
    end
  elseif logType == "carsellerBuy" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "CarSellerAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "CarSellerAPP Buy",
          ['description'] = '**Player Name:** ' ..logData.player_name.. '\n**Phone Number:** ' ..logData.phone_number.. '\n**Plate:** ' ..logData.plate.. '\n**Model:** ' ..logData.model.. '\n**Price:** ' ..logData.price..  '\n**Seller Identifier:** ' ..logData.identifier .. '\n**Buyer Identifier:** ' ..logData.buyer
        }
      }
    }
  elseif logType == "cryptoBuy" then
    -- cryptoBuy
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "CryptoAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "CryptoAPP Buy",
          ['description'] = '**Phone Number:** ' ..logData[1].. '\n**Amount:** ' ..logData[3].. '\n**Price:** ' ..logData[4].. '\n**Crypto Name:** ' ..logData[2].. '\n**Identifier:** ' ..logData[5]
        }
      }
    }
  elseif logType == "cryptoSell" then
    -- cryptoSell
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "CryptoAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "CryptoAPP Sell",
          ['description'] = '**Phone Number:** ' ..logData[1].. '\n**Amount:** ' ..logData[3].. '\n**Price:** ' ..logData[4].. '\n**Crypto Name:** ' ..logData[2].. '\n**Identifier:** ' ..logData[5]
        }
      }
    }
  elseif logType == "cryptoTransfer" then
    -- cryptoTransfer
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "CryptoAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "CryptoAPP Transfer",
          ['description'] = '**Sender Phone Number:** ' ..logData[1].. '\n**Receiver Phone Number:** ' ..logData[6].. '\n**Amount:** ' ..logData[3].. '\n**Crypto Name:** ' ..logData[2].. '\n**Sender Identifier:** ' ..logData[5].. '\n**Receiver Identifier:** ' ..logData[7]
        }
      }
    }
  elseif logType == "darkchat" then
    -- darkchat
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "DarkChatAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "DarkChatAPP",
          ['description'] = '**Room Id:** ' ..logData[1].. '\n**Message:** ' ..logData[2].. '\n**Room Name:** ' ..logData[3] .. '\n**Source:** ' ..source
        }
      }
    }
  elseif logType == "dispatchSendMessage" then
    -- dispatchSendMessage
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "DispatchAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "DispatchAPP",
          ['description'] = '**Job:** ' ..logData.receiverjob .. '\n**Message:** ' ..logData.message.. '\n**Sender Job:** ' ..logData.senderjob .. '\n**Sender Job Grade:** ' ..logData.senderjobgrade .. '\n**Source:** ' ..source.. '\n**Sender Identifier:** ' ..logData.sendercitizenid
        }
      }
    }
  elseif logType == "dispatchSendReport" then
    -- dispatchSendReport
    discord_webhook = Cfg.DiscordWebHooks[logType]
    Anonymous = logData.isAnonymous == true and 'Yes' or 'No'
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "DispatchAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "DispatchAPP",
          ['description'] = '**Job:** ' ..logData.job .. '\n**Message:** ' ..logData.message.. '\n**Location:** ' ..logData.location .. '\n**Street:** ' ..logData.street .. '\n**Anonymous:** ' ..Anonymous.. '\n**Phone Number:** ' ..logData.phone.. '\n**Source:** ' ..source .. '\n**Identifier:** ' ..logData.sendercitizenid ,
          ['image'] = {
            ["url"] = logData.photo
          },
          ['url'] = logData.photo
        }
      }
    }
  elseif logType == "startCall" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "Phone",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "Phone - Start Call",
          ['description'] = '**Caller:** ' ..logData.caller.. '\n**Receiver:** ' ..logData.receiver.. '\n**Source:** ' ..source .. '\n**Caller Citizen ID:** ' ..logData.callerIdentifier .. '\n**Receiver Citizen ID:** ' ..logData.receiverIdentifier .. '\n**Call Type:** ' ..logData.type .. '\n**Call Is Anonymous:** ' ..logData.is_anonymous
        }
      }
    }
  elseif logType == "livestreamCreate" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "LiveAPP Create",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "LiveAPP Create",
          ['description'] = '**Streamer:** ' ..logData.source.. ' **['..logData.xPlayer..']**' .. '\n**Stream Title:** ' ..logData.livetitle
        }
      }
    }
  elseif logType == "livestreamDonate" then
    -- livestreamDonate
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "LiveAPP Donate",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "LiveAPP Donate",
          ['description'] = '**Donation person:** ' ..logData.xPlayerSrc.. ' **['..logData.xPlayer..']**' ..'\n**Streamer:** ' ..logData.yPlayerSrc.. ' **['..logData.yPlayer..']**' ..'\n**Amount donated:** '.. logData.DonatePrice
        }
      }
    }
  elseif logType == "mail" then
    -- mail
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "MailAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "MailAPP",
          ['description'] = '**Sender:** ' ..logData.sender.. '\n**Subject:** ' ..logData.subject.. '\n**Message:** ' ..logData.message
        }
      }
    }

    if logData.image then
      data['embeds'][1]['url'] = logData.image
      data['embeds'][1]['image'] = {
        ["url"] = logData.image
      }
    end
  elseif logType == "news" then
    -- news
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }

    logData.news_title = logData.news_title:gsub("<[bB][rR]%s*/?>", "\n")
    logData.news_title = logData.news_title:gsub("<[^>]->", "")
    logData.news_text = logData.news_text:gsub("<[bB][rR]%s*/?>", "\n")
    logData.news_text = logData.news_text:gsub("<[^>]->", "")
    logData.news_text = logData.news_text:gsub("&[%w#]+;", "")

    data = {
      ["username"] = "News",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = logData.news_title,
          ['description'] = logData.news_text
        }
      }
    }

    if logData.news_image then
      data['embeds'][1]['url'] = logData.news_image
      data['embeds'][1]['image'] = {
        ["url"] = logData.news_image
      }
    end
  elseif logType == "rentacarRent" then
    -- rentacarRent
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "RentACarAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "RentACarAPP Rent",
          ['description'] = '**Model:** ' ..logData.model.. '\n**Plate:** ' ..logData.plate.. '\n**Price:** ' ..logData.price.. '\n**Stock:** ' ..logData.stock.. '\n**Identifier:** ' ..logData.identifier
        }
      }
    }
  elseif logType == "rentacarReturn" then
    -- rentacarReturn
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
     data = {
      ["username"] = "RentACarAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "RentACarAPP Return",
          ['description'] = '**Model:** ' ..logData.model.. '\n**Plate:** ' ..logData.plate.. '\n**Car Damge Price:** ' ..logData.price.. '\n**Health:** ' ..logData.health.. '\n**Engine:** ' ..logData.engine
        }
      }
    }
  elseif logType == "squawkPost" then
    -- squawkPost
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }

    local tweetData = logData.tweetData
    local TweetUserData = logData.TweetUserData
    local tweetType = logData.tweetType
    local pollTime = logData.pollTime

    if TweetUserData.avatar == "/html/img/icons/avatar.png" then
      TweetUserData.avatar = "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"
    end

    data = {
      ["embeds"] = {{
        ["title"] = "There is a new post",
        ["description"] = tweetData.content,
        ["url"] = TweetUserData.avatar,
        ["color"] = 5814783,
        ["author"] = {
          ["name"] = TweetUserData.username
        },
        ["fields"] = {}
      }},
      ["username"] = TweetUserData.username,
      ["avatar_url"] = TweetUserData.avatar,
    }

    if tweetType == "postpoll" then
      local pollId = 1
      data['embeds'][1]['fields'][#data['embeds'][1]['fields'] + 1] = {
        ["name"] = "Started a Poll",
        ["value"] = ""
      }

        for i, item in ipairs(tweetData.poll_options) do
            for key, value in pairs(item) do
                data['embeds'][1]['fields'][1]["value"] = data['embeds'][1]['fields'][1]["value"] ..'\n'..pollId ..'. '..key
                pollId = pollId + 1
            end
        end

        data['embeds'][1]['fields'][1]["value"] = data['embeds'][1]['fields'][1]["value"]..'\n\nPoll end time : ' ..pollTime

    end
    if type(tweetData.media) == "table" then
      for k, l in pairs(tweetData.media) do
        if k == 1 then
          data['embeds'][1]['image'] = {
            ["url"] = l
          }
        else
          data['embeds'][k] = {
            ["url"] = TweetUserData.avatar,
            ["image"] = {
              ["url"] = l
            }
          }
        end
      end
    end
  elseif logType == "taxiCall" then
    -- TaxiCall
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "TaxiAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "TaxiAPP - Call",
          ['description'] = '**Customer Identifier:** ' ..logData.identifier.. '\n**Customer Source:** ' ..logData.src.. '\n**Taxi Status:** ' ..logData.status.. '\n**Customer Phone Number:** ' ..logData.phone
        }
      }
    }

  elseif logType == "taxiCallAccpet" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "TaxiAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "TaxiAPP - Taxi Accept Job",
          ['description'] = '**Customer Identifier:** ' ..logData.identifier.. '\n**Customer Source:** ' ..logData.src.. '\n**Taxi Status:** ' ..logData.status.. '\n**Customer Phone Number:** ' ..logData.phone.. '\n**Taxi Name:** ' ..logData.taxiInfo.name.. '\n**Taxi Phone Number:** ' ..logData.taxiInfo.phone.. '\n**Taxi Identifier:** ' ..logData.taxiInfo.identifier.. '\n**Taxi Source:** ' ..logData.taxiInfo.src
        }
      }
    }
  elseif logType == "taxiFinish" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "TaxiAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "TaxiAPP - Job Finish",
          ['description'] = '**Customer Identifier:** ' ..logData.identifier.. '\n**Customer Source:** ' ..logData.src.. '\n**Taxi Status:** ' ..logData.status.. '\n**Customer Phone Number:** ' ..logData.phone.. '\n**Taxi Name:** ' ..logData.taxiInfo.name.. '\n**Taxi Phone Number:** ' ..logData.taxiInfo.phone.. '\n**Taxi Identifier:** ' ..logData.taxiInfo.identifier.. '\n**Taxi Source:** ' ..logData.taxiInfo.src.. '\n**Total Price:** ' ..logData.jobInfo.price
        }
      }
    }
  elseif logType == "taxiTip" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "TaxiAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "TaxiAPP - Taxi Tip",
          ['description'] = "**Customer Identifier:** " ..logData.customerCid.. '\n**Taxi Identifier:** ' ..logData.driverCid.. '\n**Total Tip:** ' ..logData.tip
        }
      }
    }
  elseif logType == "bussinesBillingCreate" then
    -- bussinesBillingCreate
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Billing Create",
          ['description'] = '**Bussines Name:** ' ..logData.billingSocietyLabel.. '\n**Receiver Identifier:** ' ..logData.receiverID.. '\n**Amount:** ' ..logData.billingAmaount.. '\n**Description:** ' ..logData.billingLabel.. '\n**Status:** ' ..logData.status .. '\n**Sender:** ' ..logData.senderID.. '\n**Sender Name:** ' ..logData.senderName .. '\n**Bussines Job Code:** ' ..logData.billingSociety
        }
      }
    }
  elseif logType == "bussinesBillingPay" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Pay Bill",
          ['description'] = '**Bussines Name:** ' ..logData.societylabel.. '\n**Receiver Identifier:** ' ..logData.sendercitizenid.. '\n**Amount:** ' ..logData.amount.. '\n**Description:** ' ..logData.description.. '\n**Status:** ' ..logData.status .. '\n**Sender:** ' ..logData.sendercitizenid.. '\n**Sender Name:** ' ..logData.bill_holder .. '\n**Bussines Job Code:** ' ..logData.society
        }
      }
    }
  elseif logType == "bussinesBillDelete" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Delete Bill",
          ['description'] = '**Bussines Name:** ' ..logData.societylabel.. '\n**Receiver Identifier:** ' ..logData.sendercitizenid.. '\n**Amount:** ' ..logData.amount.. '\n**Description:** ' ..logData.description.. '\n**Status:** ' ..logData.status .. '\n**Sender:** ' ..logData.sendercitizenid.. '\n**Sender Name:** ' ..logData.bill_holder .. '\n**Bussines Job Code:** ' ..logData.society
        }
      }
    }
  elseif logType == "bussinesSetJob" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Set Job",
          ['description'] = '**Bussines Name:** ' ..logData.job.. '\n**Recruiter Identifier:** ' ..logData.PlayerCid.. '\n**Player Identifier:** ' ..logData.TargetCid
        }
      }
    }
  elseif logType == "bussinesGradeUpDown" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Grade Up/Down/Fire",
          ['description'] = '**Bussines Name:** ' ..logData.job.. '\n**Recruiter Identifier:** ' ..logData.PlayerCid.. '\n**Player Identifier:** ' ..logData.target.. '\n**Action:** ' ..logData.action
        }
      }
    }

  elseif logType == "bussinesTip" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Tip",
          ['description'] = '**Job:** ' ..logData.job.. '\n**Amount:** ' ..logData.amount.. '\n**Phone Number:** ' ..logData.phone.. '\n**Player Identifier (Recipient):** ' ..logData.yPlayer .. '\n**Source (Giver):** ' ..source .. '\n**Identifier (Giver):** ' ..logData.xPlayer
        }
      }
    }

  elseif logType == "messageSend" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "MessageAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "Message - Send",
          ['description'] = '**Sender:** ' ..logData.sender.. '\n**Receiver:** ' ..logData.receiver.. '\n**Message:** ' ..logData.message.. '\n**Source:** ' ..source .. '\n**Sender Citizen ID:** ' ..logData.senderIdentifier .. '\n**Receiver Citizen ID:** ' ..logData.receiverIdentifier
        }
      }
    }

  elseif logType == "messageGroupSend" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "MessageAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "Message - Send",
          ['description'] = '**Sender:** ' ..logData.sender.. '\n**Group ID:** ' ..logData.group_id.. '\n**Message:** ' ..logData.message.. '\n**Source:** ' ..source .. '\n**Sender Citizen ID:** ' ..logData.senderIdentifier
        }
      }
    }

  elseif logType == "casinoChipBuy" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "Casino",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "Casino - Buy Chip",
          ['description'] = '**Player Identifier:** ' ..logData.xPlayer.. '\n**Purchased Chips:** ' ..logData.chips.. '\n**Price:** ' ..logData.chips
        }
      }
    }
  elseif logType == "casinoChipSeller" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "Casino",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "Casino - Sell Chip",
          ['description'] = '**Player Identifier:** ' ..logData.xPlayer.. '\n**Sold Chips:** ' ..logData.chips.. '\n**Price:** ' ..logData.amount
        }
      }
    }
  elseif logType == "casinoDiceWinner" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    local identifier = GetIdentifier(source)
    local getName = GetCharacterName(source)
    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "Casino",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "Casino - Winner Dice Chip",
          ['description'] =  '**Player Identifier:** ' ..identifier.. '\n**Player Name:** ' ..getName.. '\n**Won Chips:** ' ..logData.chips
        }
      }
    }
  elseif logType == "casinoRollWinner" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    local getName = GetCharacterName(source)
    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "Casino",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "Casino - Winner Roll Chip",
          ['description'] =  '**Player Identifier:** ' ..logData.xPlayer.. '\n**Player Name:** ' ..getName.. '\n**Won Chips:** ' ..logData.chips
        }
      }
    }
  elseif logType == "livestreamcheerbuy" then
    discord_webhook = Cfg.DiscordWebHooks[logType]

    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "LiveStream",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "LiveStream - Buy Cheer",
          ['description'] = '**Player Identifier:** ' ..logData.xPlayer.. '\n**Purchased Cheer:** ' ..logData.cheer
        }
      }
    }
  elseif logType == "livestreamtransfer" then
    discord_webhook = Cfg.DiscordWebHooks[logType]

    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "LiveStream",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "LiveStream - Buy Cheer to Coin",
          ['description'] = '**Player Identifier:** ' ..logData.xPlayer.. '\n**Transfer Cheer:** ' ..logData.TransferCheer.. '\n**Total Cheer:** ' ..logData.TotalCheer.. '\n**Total Coin:** ' ..logData.TotalCoin
        }
      }
    }
  elseif logType == "livestremcoinsell" then
    discord_webhook = Cfg.DiscordWebHooks[logType]

    headers = {
      ['Content-Type'] = 'application/json'
    }

    data = {
      ["username"] = "LiveStream",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "LiveStream - Buy Cheer to Coin",
          ['description'] = '**Player Identifier:** ' ..logData.xPlayer.. '\n**Sell Coin:** ' ..logData.SellCoin.. '\n**Total Coin:** ' ..logData.TotalCoin .. '\n**Add Bank Money:** ' ..logData.addBankMoney
        }
      }
    }
  elseif logType == "snapgramPost" then
    discord_webhook = Cfg.DiscordWebHooks[logType]
    headers = {
      ['Content-Type'] = 'application/json'
    }

    if logData.profile_picture_url == "/html/img/icons/avatar.png" or logData.profile_picture_url == '' then
      logData.profile_picture_url = "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"
    end

    data = {
      ["embeds"] = {{
        ["title"] = "There is a new post",
        ["description"] = logData.caption,
        ["url"] = logData.profile_picture_url,
        ["color"] = 5814783,
        ["author"] = {
          ["name"] = logData.username
        },
        ["fields"] = {}
      }},
      ["username"] = logData.username,
      ["avatar_url"] = logData.profile_picture_url,
    }
    
    if type(logData.media) == "table" then
      for k, l in ipairs(logData.media) do
        if k == 1 then
          data['embeds'][1]['image'] = {
            ["url"] = l
          }
        else
          data['embeds'][k] = {
            ["url"] = logData.profile_picture_url,
            ["image"] = {
              ["url"] = l
            }
          }
        end
      end
    end
  elseif logType == "darkchatCreateRoom" then
      -- darkchat
      discord_webhook = Cfg.DiscordWebHooks[logType]
      local roomIsPassword = logData.is_password_protected and "Yes" or "No"
      local roomIsPrivate = logData.is_private and "Yes" or "No"
      local roomPassword = logData.roomPassword or ""

      local logMessage = '**Player Source:** ' .. source ..
      '\n**Room Name:** ' .. logData.roomName ..
      '\n**Room is password:** ' .. roomIsPassword ..
      '\n**Room password:** ' .. roomPassword ..
      '\n**Room is private:** ' .. roomIsPrivate
      headers = {
        ['Content-Type'] = 'application/json'
      }
      data = {
        ["username"] = "DarkChatAPP",
        ["embeds"] = {
          {
            ["color"] = 1942002,
            ['title'] = "DarkChatAPP Create Room",
            ['description'] = logMessage
          }
        }
      }
  elseif logType == "darkchatDeleteRoom" then
    -- darkchat
    discord_webhook = Cfg.DiscordWebHooks[logType]

    local logMessage = '**Player Source:** ' .. source ..
    '\n**Room Name:** ' .. logData.roomName
    headers = {
      ['Content-Type'] = 'application/json'
    }
    data = {
      ["username"] = "DarkChatAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "DarkChatAPP Delete Room",
          ['description'] = logMessage
        }
      }
    }
  end

  if discord_webhook and Cfg.LogService == "discord" then
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif Cfg.LogService == "fivemanage" then
    if GetResourceState("fmsdk") ~= "started" then
        print("Cfg.LogService is set to 'fivemanage', but fmsdk is not started. To log using Fivemanage, you need to install fmsdk from https://github.com/fivemanage/sdk/releases/latest.")
        return
    end

    local FmsdkLogData = {
      playerSource = source,
      customData = data
    }

    exports.fmsdk:LogMessage("info", logType, FmsdkLogData)
  elseif Cfg.LogService == "fivemerr" then
    if GetResourceState("fm-logs") ~= "started" then
        print("Cfg.LogService is set to 'fivemerr', but fm-logs is not started. To log using Fivemerr, you need to install fmsdk from https://github.com/FiveMerr/fm-logs/releases/latest.")
        return
    end

    exports['fm-logs']:createLog({
        LogType = logType, -- The log type, must be defined in Config.Logs
        Message = data['embeds'][1]['title'], -- The message of the log
        Level = "info", -- The level of the log (can be filtered on Fivemerr) (info by default)
        Resource = "gksphone", -- Resource where the log is coming from (If not provided, `fm-logs` will be set by default)
        Source = source, -- Server id for player (Required for Player Attributes to be pulled)
        Metadata = data -- Custom attributes to be added
    })
  end

end

--- WEBHOOKS ---