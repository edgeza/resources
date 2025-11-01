local docs, downloadLink = 'https://docs.nass.dev/', 'https://portal.cfx.re/assets/granted-assets'
local checkingScripts = {}

local function isOnLatest(currentVersion, latestVersion)
    local currentParts = {}
    for part in currentVersion:gmatch("%d+") do
        table.insert(currentParts, tonumber(part))
    end

    local latestParts = {}
    for part in latestVersion:gmatch("%d+") do
        table.insert(latestParts, tonumber(part))
    end

    for i = 1, math.max(#currentParts, #latestParts) do
        local currentPart = currentParts[i] or 0
        local latestPart = latestParts[i] or 0

        if currentPart < latestPart then
            return false
        elseif currentPart > latestPart then
            return true
        end
    end

    return true
end

local function checkVersion(resourceName)
    local currentVersion = GetResourceMetadata(resourceName, 'version', 0)
    PerformHttpRequest('https://raw.githubusercontent.com/Nass-Scripts/nass_versions/main/'..resourceName,function(error, data, headers)
        if not data then return end
        local result = json.decode(data:sub(1, -2))
        local newVersion = result.version
        if not isOnLatest(currentVersion, newVersion) then
            print(string.format('%sVersion ^5%s^0 of ^5%s^0 is now out!^0\nCurrent Version: ^5%s^0\nChangelog: ^5%s^0\nPlease update here: ^5%s^0', textToAsciiArt(resourceName), newVersion, resourceName, currentVersion, result.changelog, downloadLink))
            checkingScripts[resourceName] = true
        end
    end,'GET')
end

function nass.versionCheck(resource)
    local resourceName = GetInvokingResource() or resource
    if checkingScripts[resourceName] then return end
    checkVersion(resourceName)
end

Citizen.CreateThread(function()
    Wait(10000)
    if nass.getTableLength(checkingScripts) == 0 then return end
    
    while true do
        Wait(3600000)
        for k, v in pairs(checkingScripts) do
            checkVersion(k)
        end
    end
end)

-- Define a complete ASCII art mapping for letters A-Z
local asciiArtMap = {
    A = [[
  A  
 A A 
AAAAA
A   A
A   A
]],
    B = [[
BBBB 
B   B
BBBB 
B   B
BBBB 
]],
    C = [[
 CCC 
C   C
C    
C   C
 CCC 
]],
    D = [[
DDDD 
D   D
D   D
D   D
DDDD 
]],
    E = [[
EEEEE
E    
EEEE 
E    
EEEEE
]],
    F = [[
FFFFF
F    
FFFF 
F    
F    
]],
    G = [[
 GGG 
G    
G  GG
G   G
 GGG 
]],
    H = [[
H   H
H   H
HHHHH
H   H
H   H
]],
    I = [[
IIIII
  I  
  I  
  I  
IIIII
]],
    J = [[
JJJJJ
   J 
   J 
J  J 
 JJJ 
]],
    K = [[
K   K
K  K 
KKK  
K  K 
K   K
]],
    L = [[
L    
L    
L    
L    
LLLLL
]],
    M = [[
M   M
MM MM
M M M
M   M
M   M
]],
    N = [[
N   N
NN  N
N N N
N  NN
N   N
]],
    O = [[
 OOO 
O   O
O   O
O   O
 OOO 
]],
    P = [[
PPPP 
P   P
PPPP 
P    
P    
]],
    Q = [[
 QQQ 
Q   Q
Q   Q
Q  QQ
 QQQQ
]],
    R = [[
RRRR 
R   R
RRRR 
R  R 
R   R
]],
    S = [[
 SSS 
S    
 SSS 
    S
SSSS 
]],
    T = [[
TTTTT
  T  
  T  
  T  
  T  
]],
    U = [[
U   U
U   U
U   U
U   U
 UUU 
]],
    V = [[
V   V
V   V
V   V
 V V 
  V  
]],
    W = [[
W   W
W   W
W W W
WW WW
W   W
]],
    X = [[
X   X
 X X 
  X  
 X X 
X   X
]],
    Y = [[
Y   Y
 Y Y 
  Y  
  Y  
  Y  
]],
    Z = [[
ZZZZZ
   Z 
  Z  
 Z   
ZZZZZ
]],
_ = [[
     
     
     
     
_____
]]
}


function textToAsciiArt(text)
    local colorCodes = {"^1", "^2", "^3", "^4", "^5", "^6", "^7", "^8", "^9"}
    local lines = {"", "", "", "", "", "^0"}
    text = string.upper(text) 

    for i = 1, #text do
        local char = string.sub(text, i, i)
        local colorCode = colorCodes[(i - 1) % #colorCodes + 1]  -- Cycle through the color codes

        if asciiArtMap[char] then
            local art = asciiArtMap[char]
            local artLines = {}
            for line in art:gmatch("([^\n]+)") do
                table.insert(artLines, line)
            end
            for j = 1, 5 do
                lines[j] = lines[j] .. colorCode .. artLines[j] .. " "
            end
        else
            for j = 1, 5 do
                lines[j] = lines[j] .. "     "
            end
        end
    end
    return table.concat(lines, "\n")
end

nass.versionCheck(GetCurrentResourceName())