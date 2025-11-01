Cfg = {}

--- ### TEBEX - MUSIC - PlayTube  ### ---
Cfg.TebexTransactionID = "tbx-...." --- GKSPhone TBX-ID Required for PlayTube and Music app. (Example : tbx-....)

--## Media Service Settings ## --
-- Write the media service name you will use ( fivemanage, fivemerr, gksmedia, customMedia)
Cfg.MediaService = "fivemerr"
-- Write the media service token you will use ( GKS Media Api Key, Fivemanage Token, Fivemerr Api Token)
Cfg.AuthTokenImage = ""
Cfg.AuthTokenAudio = ""
Cfg.AuthTokenVideo = ""


-- ## LOG  ## --
Cfg.LogService = "discord" --- discord, fivemanage, fivemerr
Cfg.DiscordWebHooks = {
    ['advertising'] = "",
    ['bank'] = "",
    ['carsellerAddPost'] = "",
    ['carsellerBuy'] = "",
    ['cryptoBuy'] = "",
    ['cryptoSell'] = "",
    ['cryptoTransfer'] = "",
    ['darkchat'] = "",
    ['dispatchSendMessage'] = "",
    ['dispatchSendReport'] = "",
    ['livestreamCreate'] = "",
    ['livestreamDonate'] = "",
    ['mail'] = "",
    ['news'] = "",
    ['rentacarRent'] = "",
    ['rentacarReturn'] = "",
    ['squawkPost'] = "",
    ['taxiCall'] = "",
    ['taxiCallAccpet'] = "",
    ['taxiFinish'] = "",
    ['taxiTip'] = "",
    ['bussinesBillingCreate'] = "",
    ['bussinesBillingPay'] = "",
    ['bussinesBillDelete'] = "",
    ['bussinesSetJob'] = "",
    ['bussinesGradeUpDown'] = "",
    ['messageSend'] = "",
    ['messageGroupSend'] = "",
    ['startCall'] = "",
    ['casinoRollWinner'] = "",
    ['casinoDiceWinner'] = "",
    ['casinoChipSeller'] = "",
    ['casinoChipBuy'] = "",
    ['livestreamcheerbuy'] = "",
    ['livestreamtransfer'] = "",
    ['livestremcoinsell'] = "",
    ['snapgramPost'] = "",
    ['darkchatCreateRoom'] = "",
    ['darkchatDeleteRoom'] = ""
}









---- Media Services Settings ----
---## If you do not have a custom media service, do not change the section below. ##--
Cfg.MediaServices = {
    gksmedia = {
        ImgService = {
            url = "https://servicemedia.gkshop.org/mediau",
            field = "gks_image",
            AuthHeader = "GKSHOP-Secret",
            AuthToken = Cfg.AuthTokenImage,
            returnIndex = "link"
        },
        AudioService = {
            url = "https://servicemedia.gkshop.org/mediau",
            field = "gks_audio",
            AuthHeader = "GKSHOP-Secret",
            AuthToken = Cfg.AuthTokenAudio,
            returnIndex = "link"
        },
        VideoService = {
            url = "https://servicemedia.gkshop.org/mediau",
            field = "gks_video",
            AuthHeader = "GKSHOP-Secret",
            AuthToken = Cfg.AuthTokenVideo,
            returnIndex = "link"
        },
    },
    fivemanage = {
        ImgService = {
            url = "https://fmapi.net/api/v2/presigned-url?fileType=image",
            field = "file",
            returnIndex = "data.url"
        },
        AudioService = {
            url = "https://fmapi.net/api/v2/presigned-url?fileType=audio",
            field = "file",
            returnIndex = "data.url"
        },
        VideoService = {
            url = "https://fmapi.net/api/v2/presigned-url?fileType=video",
            field = "file",
            returnIndex = "data.url"
        }
    },
    fivemerr = {
        ImgService = {
            url = "https://api.fivemerr.com/v1/media/images",
            field = "file",
            AuthHeader = "Authorization",
            AuthToken = Cfg.AuthTokenImage,
            returnIndex = "url"
        },
        AudioService = {
            url = "https://api.fivemerr.com/v1/media/audios",
            field = "file",
            AuthHeader = "Authorization",
            AuthToken = Cfg.AuthTokenAudio,
            returnIndex = "url"
        },
        VideoService = {
            url = "https://api.fivemerr.com/v1/media/videos",
            field = "file",
            AuthHeader = "Authorization",
            AuthToken = Cfg.AuthTokenVideo,
            returnIndex = "url"
        },
    },
    customMedia = {
        ImgService = {
            url = "",
            field = "",
            AuthHeader = "",
            AuthToken = Cfg.AuthTokenImage,
            returnIndex = ""
        },
        AudioService = {
            url = "",
            field = "",
            AuthHeader = "",
            AuthToken = Cfg.AuthTokenAudio,
            returnIndex = ""
        },
        VideoService = {
            url = "",
            field = "",
            AuthHeader = "",
            AuthToken = Cfg.AuthTokenVideo,
            returnIndex = ""
        },
    }
}