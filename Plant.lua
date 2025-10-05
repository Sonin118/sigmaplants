local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- APLICAR ANTI-LAG IMEDIATAMENTE (ANTES DE TUDO)
local function hideAllBrainrots()
    local scriptedMap = Workspace:WaitForChild("ScriptedMap", 5)
    local plots = Workspace:FindFirstChild("Plots")
    local totalHidden = 0
    
    -- Tornar brainrots invisíveis no ScriptedMap (sistema principal)
    if scriptedMap then
        local brainrotsFolder = scriptedMap:FindFirstChild("Brainrots")
        if brainrotsFolder then
            for _, brainrot in ipairs(brainrotsFolder:GetChildren()) do
                if brainrot:IsA("Model") then
                    for _, part in ipairs(brainrot:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 1
                            part.CanCollide = false
                            part.CanQuery = false
                            part.CanTouch = false
                        end
                        if part:IsA("Decal") or part:IsA("Texture") then
                            part.Transparency = 1
                        end
                        if part:IsA("ParticleEmitter") then
                            part.Enabled = false
                        end
                        if part:IsA("BillboardGui") then
                            part.Enabled = false
                        end
                    end
                    totalHidden = totalHidden + 1
                    -- Brainrot tornado invisível
                end
            end
        end
    end
    
    -- Também esconder brainrots nos plots (caso existam)
    if plots then
        for _, plot in ipairs(plots:GetChildren()) do
            local plotBrainrots = plot:FindFirstChild("Brainrots")
            if plotBrainrots then
                for _, brainrot in ipairs(plotBrainrots:GetChildren()) do
                    if brainrot:IsA("Model") then
                        for _, part in ipairs(brainrot:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Transparency = 1
                                part.CanCollide = false
                                part.CanQuery = false
                                part.CanTouch = false
                            end
                            if part:IsA("Decal") or part:IsA("Texture") then
                                part.Transparency = 1
                            end
                            if part:IsA("ParticleEmitter") then
                                part.Enabled = false
                            end
                            if part:IsA("BillboardGui") then
                                part.Enabled = false
                            end
                        end
                        totalHidden = totalHidden + 1
                        -- Brainrot do plot tornado invisível
                    end
                end
            end
        end
    end
    
    -- Total de brainrots tornados invisíveis
end

local function removeBrainrotVFXImmediate()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local plots = Workspace:FindFirstChild("Plots")
    
    -- Lista de brainrots com VFX (mesma lista)
    local brainrotVFXList = {
        "Fluri Flura", "Trulimero Trulicina", "Agarrini La Palini", "Lirili Larila", "Noobini Bananini",
        "Orangutini Ananassini", "Pipi Kiwi", "Espresso Signora", "Tim Cheese", "Bambini Crostini",
        "Trippi Troppi", "Brr Brr Patapim", "Cappuccino Assasino", "Svinino Bombondino", "Alessio",
        "Orcalero Orcala", "Bandito Bobrito", "Ballerina Cappuccina", "Bananita Dolphinita", "Elefanto Cocofanto",
        "Burbaloni Lulliloli", "Gansgter Footera", "Madung", "Bombardiro Crocodilo", "Bombini Gussini",
        "Frigo Camelo", "Matteo", "Odin Din Din Dun", "Tralalero Tralala", "Giraffa Celeste",
        "Vacca Saturno Saturnita", "Crazylone Pizalone", "Brri Brri Bicus Dicus Bombicus", "Garamararam",
        "Blueberrinni Octopussini", "Los Tralaleritos", "Pot Hotspot", "67"
    }
    
    -- Remover VFX dos Assets
    if replicatedStorage:FindFirstChild("Assets") then
        local assets = replicatedStorage.Assets
        if assets:FindFirstChild("Brainrots") then
            local brainrots = assets.Brainrots
            for _, brainrotName in ipairs(brainrotVFXList) do
                local brainrot = brainrots:FindFirstChild(brainrotName)
                if brainrot then
                    local vfx = brainrot:FindFirstChild("Vfx") or brainrot:FindFirstChild("vfx")
                    if vfx then vfx:Destroy() end
                    for _, child in ipairs(brainrot:GetDescendants()) do
                        if child:IsA("Animation") or child:IsA("AnimationTrack") then
                            child:Destroy()
                        end
                        if child:IsA("ParticleEmitter") then
                            child.Enabled = false
                        end
                    end
                end
            end
        end
    end
    
    -- Tornar brainrots invisíveis nos plots
    if plots then
        for _, plot in ipairs(plots:GetChildren()) do
            local brainrotsFolder = plot:FindFirstChild("Brainrots")
            if brainrotsFolder then
                for _, brainrot in ipairs(brainrotsFolder:GetChildren()) do
                    if brainrot:IsA("Model") then
                        local isInList = false
                        for _, brainrotName in ipairs(brainrotVFXList) do
                            if brainrot.Name == brainrotName then
                                isInList = true
                                break
                            end
                        end
                        
                        if isInList then
                            for _, part in ipairs(brainrot:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.Transparency = 1
                                    part.CanCollide = false
                                end
                                if part:IsA("Decal") or part:IsA("Texture") then
                                    part.Transparency = 1
                                end
                                if part:IsA("ParticleEmitter") then
                                    part.Enabled = false
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function applyImmediateAntiLag()
    local lighting = game:GetService("Lighting")
    
    -- Aplicar configurações básicas de anti-lag imediatamente
    lighting.GlobalShadows = false
    lighting.ShadowSoftness = 0
    lighting.Brightness = 2
    lighting.Ambient = Color3.new(0.8, 0.8, 0.8)
    lighting.OutdoorAmbient = Color3.new(0.8, 0.8, 0.8)
    
    -- Desabilitar efeitos
    for _, effect in pairs(lighting:GetChildren()) do
        if effect:IsA("PostEffect") or effect:IsA("Sky") then
            effect:Destroy()
        end
    end
    
    -- Esconder brainrots imediatamente
    hideAllBrainrots()
    
    -- Remover VFX e tornar brainrots específicos invisíveis
    removeBrainrotVFXImmediate()
    
    -- Anti-Lag aplicado IMEDIATAMENTE!
end

-- APLICAR ANTI-LAG AGORA MESMO
applyImmediateAntiLag()

-- Loop para monitorar novos brainrots e torná-los invisíveis (otimizado)
task.spawn(function()
    while task.wait(5) do -- Verificar a cada 5 segundos (reduzido)
        pcall(function()
            hideAllBrainrots()
        end)
    end
end)

-- Aguardar o PlayerGui carregar
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then
    error("PlayerGui não encontrado!")
end

-- Tentar PlayerGui primeiro, depois StarterGui
local mainGui = playerGui:FindFirstChild("Main")
if not mainGui then
    local starterGui = game:GetService("StarterGui")
    mainGui = starterGui:FindFirstChild("Main")
    if not mainGui then
        error("Main GUI não encontrado em PlayerGui nem StarterGui!")
    else
        -- Main GUI encontrado em StarterGui
    end
else
    -- Main GUI encontrado em PlayerGui
end

local seedsGui = mainGui:FindFirstChild("Seeds")
if not seedsGui then
    error("Seeds GUI não encontrado!")
end

local gearsGui = mainGui:FindFirstChild("Gears")
if not gearsGui then
    error("Gears GUI não encontrado!")
end

local seedsFrame = seedsGui:FindFirstChild("Frame")
if seedsFrame then
    seedsFrame = seedsFrame:FindFirstChild("ScrollingFrame")
    if not seedsFrame then
        -- Seeds ScrollingFrame não encontrado
    end
else
    -- Seeds Frame não encontrado
end

local gearsFrame = gearsGui:FindFirstChild("Frame")
if gearsFrame then
    gearsFrame = gearsFrame:FindFirstChild("ScrollingFrame")
    if not gearsFrame then
        -- Gears ScrollingFrame não encontrado
        -- Tentar procurar diretamente no gearsGui
        gearsFrame = gearsGui:FindFirstChild("ScrollingFrame")
        if gearsFrame then
            -- Gears ScrollingFrame encontrado diretamente
        end
    end
else
    -- Gears Frame não encontrado
    -- Tentar procurar diretamente no gearsGui
    gearsFrame = gearsGui:FindFirstChild("ScrollingFrame")
    if gearsFrame then
        -- Gears ScrollingFrame encontrado diretamente
    end
end

-- Aguardar os remotes com timeout
local dataRemoteEvent
local useItemRemote
local buyGearRemote
local buyItemRemote
local equipBestBrainrotsRemote

pcall(function()
    local bridgeNet2 = ReplicatedStorage:WaitForChild("BridgeNet2", 10)
    if bridgeNet2 then
        dataRemoteEvent = bridgeNet2:WaitForChild("dataRemoteEvent", 5)
    end
end)

pcall(function()
    local remotes = ReplicatedStorage:WaitForChild("Remotes", 10)
    if remotes then
        useItemRemote = remotes:WaitForChild("UseItem", 5)
        buyGearRemote = remotes:WaitForChild("BuyGear", 5)
        buyItemRemote = remotes:WaitForChild("BuyItem", 5)
        equipBestBrainrotsRemote = remotes:WaitForChild("EquipBestBrainrots", 5)
    end
end)

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Sistema de Configurações
local ConfigSystem = {
    AutoLoad = true,
    CurrentConfig = "Default",
    Configs = {}
}

-- Função para salvar configuração
local function saveConfig(configName)
    -- Iniciando salvamento da config
    
    local config = {
        SelectedSeeds = SelectedSeeds,
        SelectedGears = SelectedGears,
        AutoBuyEnabled = AutoBuyEnabled,
        BUY_DELAY = BUY_DELAY,
        CHECK_STOCK = CHECK_STOCK,
        SelectedRarities = SelectedRarities,
        AutoFireEnabled = AutoFireEnabled,
        AUTO_TP_ENABLED = AUTO_TP_ENABLED,
        DETECT_RADIUS = DETECT_RADIUS,
        FIRE_INTERVAL = FIRE_INTERVAL,
        NOCLIP_ENABLED = NOCLIP_ENABLED,
        AUTO_BAT_ENABLED = AUTO_BAT_ENABLED,
        BAT_INTERVAL = BAT_INTERVAL,
        BAT_KILL_AURA_ENABLED = BAT_KILL_AURA_ENABLED,
        ANTI_LAG_ENABLED = ANTI_LAG_ENABLED,
        GRAPHICS_QUALITY = GRAPHICS_QUALITY,
        PARTICLE_DISTANCE = PARTICLE_DISTANCE,
        RENDERING_DISTANCE = RENDERING_DISTANCE,
        timestamp = os.time()
    }
    
    -- Config criada, tentando salvar no arquivo
    
    local fileName = "PlantsVsBrainrot_" .. configName .. ".json"
    local jsonData = game:GetService("HttpService"):JSONEncode(config)
    
    -- Salvando arquivo de configuração
    
    local success, errorMsg = pcall(function()
        writefile(fileName, jsonData)
    end)
    
    if success then
        ConfigSystem.Configs[configName] = config
        -- Arquivo salvo com sucesso
        return true
    else
        -- Erro ao salvar arquivo
        return false, errorMsg
    end
end

-- Função para carregar configuração
local function loadConfig(configName)
    if ConfigSystem.Configs[configName] then
        local config = ConfigSystem.Configs[configName]
        SelectedSeeds = config.SelectedSeeds or {}
        SelectedGears = config.SelectedGears or {}
        AutoBuyEnabled = config.AutoBuyEnabled or false
        BUY_DELAY = config.BUY_DELAY or 1
        CHECK_STOCK = config.CHECK_STOCK or true
        SelectedRarities = config.SelectedRarities or {"Secret","Limited"}
        AutoFireEnabled = config.AutoFireEnabled or false
        AUTO_TP_ENABLED = config.AUTO_TP_ENABLED or false
        DETECT_RADIUS = config.DETECT_RADIUS or 20
        FIRE_INTERVAL = config.FIRE_INTERVAL or 2
        NOCLIP_ENABLED = config.NOCLIP_ENABLED or false
        AUTO_BAT_ENABLED = config.AUTO_BAT_ENABLED or false
        BAT_INTERVAL = config.BAT_INTERVAL or 0.5
        BAT_KILL_AURA_ENABLED = config.BAT_KILL_AURA_ENABLED or false
        ANTI_LAG_ENABLED = config.ANTI_LAG_ENABLED or true
        GRAPHICS_QUALITY = config.GRAPHICS_QUALITY or 1
        PARTICLE_DISTANCE = config.PARTICLE_DISTANCE or 100
        RENDERING_DISTANCE = config.RENDERING_DISTANCE or 500
        return true
    end
    return false
end

-- Função para carregar configurações salvas
local function loadSavedConfigs()
    local configs = {}
    
    -- Carregar configs numeradas (Config1, Config2, etc.)
    for i = 1, 10 do
        local configName = "Config" .. i
        if isfile("PlantsVsBrainrot_" .. configName .. ".json") then
            local success, config = pcall(function()
                return game:GetService("HttpService"):JSONDecode(readfile("PlantsVsBrainrot_" .. configName .. ".json"))
            end)
            if success then
                ConfigSystem.Configs[configName] = config
                table.insert(configs, configName)
            end
        end
    end
    
    -- Lista de nomes personalizados comuns para verificar
    local customNames = {
        "Minha Config", "Farm Config", "PvP Setup", "Config Premium", 
        "Config Padrão", "Melee Config", "Ranged Config", "Auto Config",
        "Fast Config", "Slow Config", "Test Config", "Main Config"
    }
    
    -- Verificar configs personalizadas conhecidas
    for _, configName in ipairs(customNames) do
        if isfile("PlantsVsBrainrot_" .. configName .. ".json") then
            local success, config = pcall(function()
                return game:GetService("HttpService"):JSONDecode(readfile("PlantsVsBrainrot_" .. configName .. ".json"))
            end)
            if success then
                ConfigSystem.Configs[configName] = config
                if not table.find(configs, configName) then
                    table.insert(configs, configName)
                end
            end
        end
    end
    
    return configs
end

-- Carregar configurações salvas
local savedConfigs = loadSavedConfigs()

local function getStock(text)
    local amount = text:match("x(%d+)")
    return tonumber(amount) or 0
end

local function getItemList(scrollFrame)
    local items = {}
    if not scrollFrame then
        return items
    end
    
    for _, itemFrame in ipairs(scrollFrame:GetChildren()) do
        if itemFrame:IsA("Frame") and itemFrame:FindFirstChild("Stock") then
            table.insert(items, itemFrame.Name)
        end
    end
    return items
end

local function buyItem(itemName, amount, isSeed)
    if isSeed then
        -- Para sementes, usar o sistema correto
        if not buyItemRemote then
            -- Erro: buyItemRemote não encontrado
            return
        end
        
        -- Comprando semente
        
        for i = 1, amount do
            local success, errorMsg = pcall(function()
                buyItemRemote:FireServer(itemName, false) -- itemName, isAutoBuy
            end)
            
            if success then
                -- Compra de semente enviada
            else
                -- Erro ao enviar compra de semente
            end
            
            task.wait(0.1) -- Pequeno delay entre compras
        end
    else
        -- Para gears, usar o sistema correto
        if not buyGearRemote then
            -- Erro: buyGearRemote não encontrado
            return
        end
        
        -- Comprando gear
        
        for i = 1, amount do
            local success, errorMsg = pcall(function()
                buyGearRemote:FireServer(itemName, false) -- itemName, isAutoBuy
            end)
            
            if success then
                -- Compra de gear enviada
            else
                -- Erro ao enviar compra de gear
            end
            
            task.wait(0.1) -- Pequeno delay entre compras
        end
    end
end

local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local plotsFolder = Workspace:WaitForChild("Plots")
local myPlot
for _, plot in ipairs(plotsFolder:GetChildren()) do
    if plot:GetAttribute("Owner") == player.Name then
        myPlot = plot
        break
    end
end
if not myPlot then return end

local tierModel
local highestTier = 0
if myPlot:FindFirstChild("Other") then
    for _, candidate in ipairs(myPlot.Other:GetChildren()) do
        local tierNum = candidate.Name:match("^Tier(%d+)$")
        if tierNum then
            tierNum = tonumber(tierNum)
            if tierNum > highestTier and candidate:IsA("Model") then
                highestTier = tierNum
                tierModel = candidate
            end
        end
    end
end
if not tierModel then return end

local roadModel = tierModel:FindFirstChild("Road")
if not roadModel then return end
local roadParts = {}
for _, p in ipairs(roadModel:GetDescendants()) do
    if p:IsA("BasePart") then table.insert(roadParts,p) end
end

local Clip = true
local NoclipConnection
local floatName = "HumanoidRootPart"
local function noclip()
    Clip = false
    NoclipConnection = RunService.Stepped:Connect(function()
        if not Clip and character then
            for _, v in pairs(character:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide and v.Name ~= floatName then
                    v.CanCollide = false
                end
            end
        end
    end)
end
local function clip()
    Clip = true
    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end
end

local function findFrostGrenade()
    for _, container in ipairs({character, player:WaitForChild("Backpack")}) do
        for _, item in ipairs(container:GetChildren()) do
            if item:IsA("Tool") and string.match(item.Name, "^%[x%d+%] Frost Grenade$") then
                return item
            end
        end
    end
    return nil
end

local function findAluminumBat()
    for _, container in ipairs({character, player:WaitForChild("Backpack")}) do
        for _, item in ipairs(container:GetChildren()) do
            if item:IsA("Tool") and string.match(item.Name, "^%[x%d+%] Aluminum Bat$") then
                return item
            end
        end
    end
    return nil
end

local function fireFrostGrenade(brainrot)
    if not brainrot or not brainrot.Parent then return end
    if not useItemRemote then
        -- Erro: useItemRemote não encontrado
        return
    end
    
    local progress = brainrot:GetAttribute("Progress") or 0
    if progress > 0.6 then
        local tool = findFrostGrenade()
        if tool then
            local bp = brainrot.PrimaryPart or brainrot:FindFirstChildWhichIsA("BasePart")
            if bp then
                humanoid:EquipTool(tool)
                local args = {{
                    Toggle = true,
                    Tool = tool,
                    Time = 0.5,
                    Pos = Vector3.new(bp.Position.X, bp.Position.Y, bp.Position.Z)
                }}
                
                -- Adicionar delay para evitar spam de remotes
                local success, errorMsg = pcall(function()
                    useItemRemote:FireServer(unpack(args))
                end)
                
                if not success then
                    -- Erro ao usar Frost Grenade
                end
                
                -- Delay entre usos para evitar spam
                task.wait(0.1)
            end
        end
    end
end

local function attackWithBat(brainrot)
    if not brainrot or not brainrot.Parent then return end
    
    local tool = findAluminumBat()
    if tool then
        local bp = brainrot.PrimaryPart or brainrot:FindFirstChildWhichIsA("BasePart")
        if bp then
            humanoid:EquipTool(tool)
            
            -- Tentar diferentes métodos de ataque com proteção contra spam
            local success = false
            
            if tool:FindFirstChild("Activate") then
                local attackSuccess, attackError = pcall(function()
                    tool.Activate:FireServer()
                end)
                if attackSuccess then
                    success = true
                else
                    -- Erro ao ativar bat
                end
            elseif tool:FindFirstChild("RemoteEvent") then
                local attackSuccess, attackError = pcall(function()
                    tool.RemoteEvent:FireServer()
                end)
                if attackSuccess then
                    success = true
                else
                    -- Erro ao usar RemoteEvent
                end
            elseif tool:FindFirstChild("RemoteFunction") then
                local attackSuccess, attackError = pcall(function()
                    tool.RemoteFunction:InvokeServer()
                end)
                if attackSuccess then
                    success = true
                else
                    -- Erro ao usar RemoteFunction
                end
            else
                -- Método alternativo: simular clique
                local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                if mouse then
                    mouse.Target = bp
                    local attackSuccess, attackError = pcall(function()
                        tool.Activated:Fire()
                    end)
                    if attackSuccess then
                        success = true
                    else
                        -- Erro ao simular clique
                    end
                end
            end
            
            -- Delay para evitar spam
            if success then
                task.wait(0.1)
            end
        end
    end
end

-- Função de Kill Aura para o Bat
local function batKillAura()
    local tool = findAluminumBat()
    if not tool then return end
    
    -- Equipar o bat se não estiver equipado
    if humanoid:GetActiveTool() ~= tool then
        humanoid:EquipTool(tool)
    end
    
    -- Encontrar todos os brainrots próximos
    for _, brainrot in ipairs(brainrotsFolder:GetChildren()) do
        if brainrot:IsA("Model") and brainrot.Parent then
            local rarity = brainrot:GetAttribute("Rarity")
            if rarity and table.find(SelectedRarities, rarity) then
                local primary = brainrot.PrimaryPart or brainrot:FindFirstChildWhichIsA("BasePart")
                if primary then
                    -- Verificar se está dentro do raio
                    local distance = (hrp.Position - primary.Position).Magnitude
                    if distance <= DETECT_RADIUS then
                        -- Atacar o brainrot
                        attackWithBat(brainrot)
                        task.wait(0.1) -- Pequeno delay entre ataques
                    end
                end
            end
        end
    end
end

local brainrotsFolder
pcall(function()
    local scriptedMap = Workspace:WaitForChild("ScriptedMap", 10)
    if scriptedMap then
        brainrotsFolder = scriptedMap:WaitForChild("Brainrots", 5)
    end
end)

local DETECT_RADIUS = 20
local FIRE_INTERVAL = 2

local function findTargetBrainrot(selectedRarities)
    if not brainrotsFolder then
        return nil
    end
    
    for _, b in ipairs(brainrotsFolder:GetChildren()) do
        if b:IsA("Model") then
            local rarity = b:GetAttribute("Rarity")
            if rarity and table.find(selectedRarities, rarity) then
                local primary = b.PrimaryPart or b:FindFirstChildWhichIsA("BasePart")
                if primary then
                    for _, roadPart in ipairs(roadParts) do
                        if (primary.Position - roadPart.Position).Magnitude <= DETECT_RADIUS then
                            return b
                        end
                    end
                end
            end
        end
    end
    return nil
end

local Window = Rayfield:CreateWindow({
    Name = "SoninHub",
    LoadingTitle = "Auto-Buy & Brainrot Tool",
    LoadingSubtitle = "Script Melhorado - Premium Seeds & Combat",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PlantsVsBrainrot",
        FileName = "Config"
    }
})


local ShopTab = Window:CreateTab("Shop")
local SelectedSeeds = {}
local SelectedGears = {"Frost Grenade", "Carrot Launcher", "Frost Blower", "Water Bucket", "Banana Gun"} -- Todos os equipamentos selecionados por padrão
local AutoBuyEnabled = true -- Ativado por padrão
local BUY_DELAY = 1
local CHECK_STOCK = true
local AUTO_COLLECT_MONEY = true -- Coletar dinheiro automaticamente (equipar melhores brainrots)
local COLLECT_MONEY_COOLDOWN = 300 -- Cooldown de 300 segundos (5 minutos)

-- Sementes específicas das imagens
local PremiumSeeds = {
    "Shroombino Seed",
    "Mango Seed", 
    "Carnivorous Plant Seed",
    "Mr Carrot Seed",
    "Tomatrio Seed",
    "Watermelon Seed",
    "Grape Seed",
    "Cocotank Seed"
}

-- Configuração inicial - sementes raras selecionadas
SelectedSeeds = PremiumSeeds

ShopTab:CreateSection("Sementes Premium")
ShopTab:CreateDropdown({
    Name = "Sementes Raras (Secret/Godly/Mythic)",
    Options = PremiumSeeds,
    CurrentOption = PremiumSeeds,
    MultipleOptions = true,
    Flag = "PremiumSeedDropdown",
    Callback = function(selected)
        -- Atualizar a lista completa de sementes selecionadas
        SelectedSeeds = {}
        for _, seed in ipairs(selected) do
            table.insert(SelectedSeeds, seed)
        end
    end
})

ShopTab:CreateSection("Sementes Normais")
ShopTab:CreateDropdown({
    Name = "Select Seeds to Auto-Buy",
    Options = getItemList(seedsFrame),
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "SeedDropdown",
    Callback = function(selected)
        SelectedSeeds = selected
    end
})

ShopTab:CreateSection("Equipamentos")
ShopTab:CreateDropdown({
    Name = "Select Gears to Auto-Buy",
    Options = {"Frost Grenade", "Carrot Launcher", "Frost Blower", "Water Bucket", "Banana Gun"},
    CurrentOption = {"Frost Grenade", "Carrot Launcher", "Frost Blower", "Water Bucket", "Banana Gun"},
    MultipleOptions = true,
    Flag = "GearDropdown",
    Callback = function(selected)
        SelectedGears = selected
    end
})

ShopTab:CreateSection("Configurações")
ShopTab:CreateToggle({
    Name = "Enable Auto-Buy",
    CurrentValue = AutoBuyEnabled,
    Flag = "AutoBuyToggle",
    Callback = function(value)
        AutoBuyEnabled = value
    end
})

ShopTab:CreateToggle({
    Name = "Auto Collect Money",
    CurrentValue = AUTO_COLLECT_MONEY,
    Flag = "AutoCollectMoneyToggle",
    Callback = function(value)
        AUTO_COLLECT_MONEY = value
    end
})

ShopTab:CreateSlider({
    Name = "Buy Delay (seconds)",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = 1,
    Flag = "BuyDelaySlider",
    Callback = function(value)
        BUY_DELAY = value
    end
})

ShopTab:CreateToggle({
    Name = "Only Buy When Stock > 0",
    CurrentValue = true,
    Flag = "StockCheckToggle",
    Callback = function(value)
        CHECK_STOCK = value
    end
})

local CombatTab = Window:CreateTab("Combat")
local AutoFireEnabled = true -- Ativado por padrão
local SelectedRarities = {"Secret","Limited"} -- Apenas Secret e Limited selecionados por padrão
local AUTO_TP_ENABLED = true -- Teleporte ativado por padrão
local FIRE_RADIUS = 20
local AUTO_BAT_ENABLED = true -- Bat ativado por padrão
local BAT_INTERVAL = 0.5
local BAT_KILL_AURA_ENABLED = true -- Kill Aura ativado por padrão

local RarityOptions = {"Rare","Epic","Legendary","Mythic","Godly","Secret","Limited"}

CombatTab:CreateSection("Configurações de Raridade")
CombatTab:CreateDropdown({
    Name = "Select Rarities",
    Options = RarityOptions,
    CurrentOption = {"Secret","Limited"},
    MultipleOptions = true,
    Flag = "RarityDropdown",
    Callback = function(selected)
        SelectedRarities = selected
    end
})

CombatTab:CreateSection("Auto Combate")
CombatTab:CreateToggle({
    Name = "Auto Frost Grenade",
    CurrentValue = AutoFireEnabled,
    Flag = "AutoFireToggle",
    Callback = function(value)
        AutoFireEnabled = value
    end
})

CombatTab:CreateToggle({
    Name = "Auto Teleport to Target",
    CurrentValue = AUTO_TP_ENABLED,
    Flag = "AutoTPToggle",
    Callback = function(value)
        AUTO_TP_ENABLED = value
    end
})

CombatTab:CreateSlider({
    Name = "Detection Radius",
    Range = {10, 100},
    Increment = 5,
    CurrentValue = 20,
    Flag = "RadiusSlider",
    Callback = function(value)
        DETECT_RADIUS = value
    end
})

CombatTab:CreateSlider({
    Name = "Fire Interval (seconds)",
    Range = {0.5, 5},
    Increment = 0.5,
    CurrentValue = 2,
    Flag = "FireIntervalSlider",
    Callback = function(value)
        FIRE_INTERVAL = value
    end
})

CombatTab:CreateSection("Aluminum Bat")
CombatTab:CreateToggle({
    Name = "Auto Aluminum Bat",
    CurrentValue = AUTO_BAT_ENABLED,
    Flag = "AutoBatToggle",
    Callback = function(value)
        AUTO_BAT_ENABLED = value
    end
})

CombatTab:CreateToggle({
    Name = "Bat Kill Aura",
    CurrentValue = BAT_KILL_AURA_ENABLED,
    Flag = "BatKillAuraToggle",
    Callback = function(value)
        BAT_KILL_AURA_ENABLED = value
    end
})

CombatTab:CreateSlider({
    Name = "Bat Attack Speed (seconds)",
    Range = {0.1, 2},
    Increment = 0.1,
    CurrentValue = 0.5,
    Flag = "BatIntervalSlider",
    Callback = function(value)
        BAT_INTERVAL = value
    end
})

-- Loop para coletar dinheiro automaticamente (equipar melhores brainrots) - otimizado
task.spawn(function()
    while task.wait(COLLECT_MONEY_COOLDOWN) do -- A cada 300 segundos (5 minutos)
        if AUTO_COLLECT_MONEY and equipBestBrainrotsRemote then
            -- Coletando dinheiro automaticamente
            pcall(function()
                equipBestBrainrotsRemote:FireServer()
                showNotification("Collect Money", "Dinheiro coletado automaticamente!")
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(BUY_DELAY) do
        if AutoBuyEnabled and seedsFrame and gearsFrame then
            -- Auto-Buy ativo - verificando itens
            pcall(function()
                -- Comprar sementes
                for _, seedName in ipairs(SelectedSeeds) do
                local seedFrame = seedsFrame:FindFirstChild(seedName)
                if seedFrame and seedFrame:FindFirstChild("Stock") then
                    local stock = getStock(seedFrame.Stock.Text)
                    -- Verificando estoque da semente
                    if CHECK_STOCK then
                        if stock > 0 then
                            buyItem(seedName, stock, true)
                            
                            -- Notificar se comprou uma planta especial
                            if SPECIAL_PLANTS[seedName] then
                                local plantType = SPECIAL_PLANTS[seedName]
                                if WEBHOOK_ENABLED then
                                    if plantType == "Secret" and NOTIFY_SECRET_PLANTS then
                                        sendWebhook(
                                            "✅ PLANTA SECRETA COMPRADA!",
                                            "**" .. seedName .. "** foi comprada automaticamente!\nQuantidade: **x" .. stock .. "**\n\n🎉 Auto-Buy funcionando perfeitamente!",
                                            65280 -- Verde
                                        )
                                    elseif plantType == "Mythic" and NOTIFY_MYTHIC_PLANTS then
                                        sendWebhook(
                                            "✅ PLANTA MÍTICA COMPRADA!",
                                            "**" .. seedName .. "** foi comprada automaticamente!\nQuantidade: **x" .. stock .. "**\n\n🎉 Auto-Buy funcionando perfeitamente!",
                                            65280 -- Verde
                                        )
                                    end
                                end
                            end
                        else
                            -- Estoque zero
                        end
                    else
                        buyItem(seedName, stock, true)
                        
                        -- Notificar se comprou uma planta especial
                        if SPECIAL_PLANTS[seedName] then
                            local plantType = SPECIAL_PLANTS[seedName]
                            if WEBHOOK_ENABLED then
                                if plantType == "Secret" and NOTIFY_SECRET_PLANTS then
                                    sendWebhook(
                                        "✅ PLANTA SECRETA COMPRADA!",
                                        "**" .. seedName .. "** foi comprada automaticamente!\nQuantidade: **x" .. stock .. "**\n\n🎉 Auto-Buy funcionando perfeitamente!",
                                        65280 -- Verde
                                    )
                                elseif plantType == "Mythic" and NOTIFY_MYTHIC_PLANTS then
                                    sendWebhook(
                                        "✅ PLANTA MÍTICA COMPRADA!",
                                        "**" .. seedName .. "** foi comprada automaticamente!\nQuantidade: **x" .. stock .. "**\n\n🎉 Auto-Buy funcionando perfeitamente!",
                                        65280 -- Verde
                                    )
                                end
                            end
                        end
                    end
                else
                    -- Semente não encontrada
                end
            end

            -- Comprar equipamentos
            for _, gearName in ipairs(SelectedGears) do
                local gearFrame = gearsFrame:FindFirstChild(gearName)
                if gearFrame and gearFrame:FindFirstChild("Stock") then
                    local stock = getStock(gearFrame.Stock.Text)
                    -- Verificando estoque do equipamento
                    if CHECK_STOCK then
                        if stock > 0 then
                            buyItem(gearName, stock, false)
                        else
                            -- Estoque zero
                        end
                    else
                        buyItem(gearName, stock, false)
                    end
                else
                    -- Equipamento não encontrado
                end
            end
            end)
        else
            -- Auto-Buy desativado
        end
    end
end)

-- Loop separado para Kill Aura do Bat
task.spawn(function()
    while true do
        if BAT_KILL_AURA_ENABLED then
            batKillAura()
            task.wait(BAT_INTERVAL)
        else
            task.wait(1)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do -- Adicionar delay mínimo
        if (AutoFireEnabled or AUTO_BAT_ENABLED) and brainrotsFolder then
            pcall(function()
                local targetBrainrot = findTargetBrainrot(SelectedRarities)
            if targetBrainrot then
                local targetPart = targetBrainrot.PrimaryPart or targetBrainrot:FindFirstChildWhichIsA("BasePart")
                if targetPart then
                    if AUTO_TP_ENABLED then
                        noclip()
                        hrp.CFrame = CFrame.new(targetPart.Position)
                        local bodyPos = Instance.new("BodyPosition")
                        bodyPos.MaxForce = Vector3.new(1e5,1e5,1e5)
                        bodyPos.P = 5000
                        bodyPos.D = 100
                        bodyPos.Position = hrp.Position
                        bodyPos.Parent = hrp
                        
                        local lastFire = 0
                        local lastBatAttack = 0
                        while targetBrainrot.Parent and (AutoFireEnabled or AUTO_BAT_ENABLED) do
                            bodyPos.Position = targetPart.Position
                            
                            -- Sistema de granadas
                            if AutoFireEnabled then
                                local progress = targetBrainrot:GetAttribute("Progress") or 0
                                if progress > 0.6 then
                                    local tool = findFrostGrenade()
                                    if tool then
                                        humanoid:EquipTool(tool)
                                    end
                                end
                                local now = tick()
                                if now - lastFire >= FIRE_INTERVAL then
                                    fireFrostGrenade(targetBrainrot)
                                    lastFire = now
                                    -- Granada disparada
                                end
                            end
                            
                            -- Sistema de bat
                            if AUTO_BAT_ENABLED then
                                local now = tick()
                                if now - lastBatAttack >= BAT_INTERVAL then
                                    attackWithBat(targetBrainrot)
                                    lastBatAttack = now
                                    -- Bat usado
                                end
                            end
                            
                            task.wait(0.03)
                        end
                        
                        humanoid:UnequipTools()
                        bodyPos:Destroy()
                        clip()
                    else
                        -- Sem teleporte, apenas atacar
                        local lastFire = 0
                        local lastBatAttack = 0
                        while targetBrainrot.Parent and (AutoFireEnabled or AUTO_BAT_ENABLED) do
                            -- Sistema de granadas
                            if AutoFireEnabled then
                                local progress = targetBrainrot:GetAttribute("Progress") or 0
                                if progress > 0.6 then
                                    local tool = findFrostGrenade()
                                    if tool then
                                        humanoid:EquipTool(tool)
                                    end
                                end
                                local now = tick()
                                if now - lastFire >= FIRE_INTERVAL then
                                    fireFrostGrenade(targetBrainrot)
                                    lastFire = now
                                    -- Granada disparada
                                end
                            end
                            
                            -- Sistema de bat
                            if AUTO_BAT_ENABLED then
                                local now = tick()
                                if now - lastBatAttack >= BAT_INTERVAL then
                                    attackWithBat(targetBrainrot)
                                    lastBatAttack = now
                                    -- Bat usado
                                end
                            end
                            
                            task.wait(0.03)
                        end
                        humanoid:UnequipTools()
                    end
                end
            else
                task.wait(1)
            end
            end)
        else
            task.wait(1)
        end
    end
end)

-- Sistema Anti-AFK Passivo (sempre ativo)
local lastAntiAfkAction = 0

-- Função para executar ações anti-AFK
local function performAntiAfk()
    local currentTime = tick()
    if currentTime - lastAntiAfkAction < 25 then return end -- A cada 25 segundos
    
    lastAntiAfkAction = currentTime
    
    -- Movimento anti-AFK
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local currentPosition = hrp.Position
        
        -- Pequeno movimento sutil
        local newPosition = currentPosition + Vector3.new(0, 0, 0.5)
        hrp.CFrame = CFrame.new(newPosition)
        task.wait(0.05)
        hrp.CFrame = CFrame.new(currentPosition)
    end
    
    -- Pulo anti-AFK
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        humanoid.Jump = true
        task.wait(0.05)
        humanoid.Jump = false
    end
end

-- Sistema anti-AFK com rotação de câmera
local function cameraAntiAfk()
    local camera = workspace.CurrentCamera
    if camera then
        -- Pequena rotação da câmera
        local currentCFrame = camera.CFrame
        local newCFrame = currentCFrame * CFrame.Angles(0, math.rad(0.5), 0)
        camera.CFrame = newCFrame
        task.wait(0.05)
        camera.CFrame = currentCFrame
    end
end

-- Sistema anti-AFK com teclas
local function keyPressAntiAfk()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    if VirtualInputManager then
        -- Simular pressionar tecla W
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game)
        
        -- Simular pressionar tecla S
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.S, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.S, false, game)
    end
end

-- Loops anti-AFK passivos (otimizados)
task.spawn(function()
    while task.wait(30) do -- A cada 30 segundos (reduzido)
        pcall(function()
            performAntiAfk()
        end)
    end
end)

task.spawn(function()
    while task.wait(45) do -- A cada 45 segundos (reduzido)
        pcall(function()
            cameraAntiAfk()
        end)
    end
end)

task.spawn(function()
    while task.wait(60) do -- A cada 60 segundos (reduzido)
        pcall(function()
            keyPressAntiAfk()
        end)
    end
end)

-- Sistema de monitoramento de performance
local performanceStats = {
    fps = 0,
    memory = 0,
    loops = 0,
    errors = 0
}

-- Função para monitorar performance
local function updatePerformanceStats()
    performanceStats.fps = math.floor(1 / game:GetService("RunService").Heartbeat:Wait())
    performanceStats.memory = game:GetService("Stats"):GetTotalMemoryUsageMb()
end

-- Loop de monitoramento de performance
task.spawn(function()
    while task.wait(10) do
        pcall(function()
            updatePerformanceStats()
        end)
    end
end)

-- Nova aba de utilidades
local UtilsTab = Window:CreateTab("Utils")
local NOCLIP_ENABLED = true -- Noclip ativado por padrão

-- Sistema Anti-Lag
local ANTI_LAG_ENABLED = true
local GRAPHICS_QUALITY = 1
local PARTICLE_DISTANCE = 100
local LIGHTING_QUALITY = 1
local RENDERING_DISTANCE = 500

-- Funções Anti-Lag
local function applyGraphicsQuality(quality)
    local lighting = game:GetService("Lighting")
    local players = game:GetService("Players")
    local runService = game:GetService("RunService")
    
    if quality <= 3 then
        -- Configurações de baixa qualidade
        lighting.GlobalShadows = false
        lighting.ShadowSoftness = 0
        lighting.Brightness = 2
        lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
        
        -- Desabilitar efeitos
        for _, effect in pairs(lighting:GetChildren()) do
            if effect:IsA("PostEffect") then
                effect.Enabled = false
            end
        end
        
        -- Configurar RunService
        runService:Set3dRenderingEnabled(true)
    end
end

local function applyParticleSettings(distance)
    local particles = Workspace:GetDescendants()
    for _, particle in ipairs(particles) do
        if particle:IsA("ParticleEmitter") then
            particle.Enabled = false
        end
    end
end

-- Função para tornar brainrots invisíveis
local function hideAllBrainrots()
    local plots = Workspace:FindFirstChild("Plots")
    if not plots then
        print("Plots folder não encontrado!")
        return
    end
    
    local totalHidden = 0
    
    -- Percorrer todos os plots
    for _, plot in ipairs(plots:GetChildren()) do
        local brainrotsFolder = plot:FindFirstChild("Brainrots")
        if brainrotsFolder then
            -- Encontrado Brainrots no plot
            
            -- Tornar todos os brainrots invisíveis
            for _, brainrot in ipairs(brainrotsFolder:GetChildren()) do
                if brainrot:IsA("Model") then
                    -- Tornar o modelo invisível
                    for _, part in ipairs(brainrot:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 1
                            part.CanCollide = false
                        end
                        if part:IsA("Decal") or part:IsA("Texture") then
                            part.Transparency = 1
                        end
                    end
                    totalHidden = totalHidden + 1
                    -- Brainrot tornado invisível
                end
            end
        end
    end
    
    -- Total de brainrots tornados invisíveis
end

-- Função para remover VFX e tornar brainrots invisíveis
local function removeBrainrotVFX()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local plots = Workspace:FindFirstChild("Plots")
    
    -- Lista de brainrots com VFX
    local brainrotVFXList = {
        -- Rare
        "Fluri Flura",
        "Trulimero Trulicina",
        "Agarrini La Palini",
        "Lirili Larila",
        "Noobini Bananini",
        "Orangutini Ananassini",
        "Pipi Kiwi",
        "Espresso Signora",
        "Tim Cheese",
        "Bambini Crostini",
        -- Epic
        "Trippi Troppi",
        "Brr Brr Patapim",
        "Cappuccino Assasino",
        "Svinino Bombondino",
        "Alessio",
        "Orcalero Orcala",
        "Bandito Bobrito",
        -- Legendary
        "Ballerina Cappuccina",
        "Bananita Dolphinita",
        "Elefanto Cocofanto",
        "Burbaloni Lulliloli",
        "Gansgter Footera",
        "Madung",
        -- Mythic
        "Bombardiro Crocodilo",
        "Bombini Gussini",
        "Frigo Camelo",
        -- Godly
        "Matteo",
        "Odin Din Din Dun",
        "Tralalero Tralala",
        "Giraffa Celeste",
        -- Secret
        "Vacca Saturno Saturnita",
        "Crazylone Pizalone",
        "Brri Brri Bicus Dicus Bombicus",
        "Garamararam",
        "Blueberrinni Octopussini",
        "Los Tralaleritos",
        "Pot Hotspot",
        "67"
    }
    
    local totalProcessed = 0
    
    -- Remover VFX dos Assets
    if replicatedStorage:FindFirstChild("Assets") then
        local assets = replicatedStorage.Assets
        if assets:FindFirstChild("Brainrots") then
            local brainrots = assets.Brainrots
            
            for _, brainrotName in ipairs(brainrotVFXList) do
                local brainrot = brainrots:FindFirstChild(brainrotName)
                if brainrot then
                    -- Remover VFX
                    local vfx = brainrot:FindFirstChild("Vfx") or brainrot:FindFirstChild("vfx")
                    if vfx then
                        vfx:Destroy()
                        -- VFX removido
                    end
                    
                    -- Remover animações
                    for _, child in ipairs(brainrot:GetDescendants()) do
                        if child:IsA("Animation") or child:IsA("AnimationTrack") then
                            child:Destroy()
                        end
                        if child:IsA("ParticleEmitter") then
                            child.Enabled = false
                        end
                    end
                    totalProcessed = totalProcessed + 1
                end
            end
        end
    end
    
    -- Tornar brainrots invisíveis nos plots
    if plots then
        for _, plot in ipairs(plots:GetChildren()) do
            local brainrotsFolder = plot:FindFirstChild("Brainrots")
            if brainrotsFolder then
                for _, brainrot in ipairs(brainrotsFolder:GetChildren()) do
                    if brainrot:IsA("Model") then
                        -- Verificar se é um dos brainrots da lista
                        local isInList = false
                        for _, brainrotName in ipairs(brainrotVFXList) do
                            if brainrot.Name == brainrotName then
                                isInList = true
                                break
                            end
                        end
                        
                        if isInList then
                            -- Tornar invisível
                            for _, part in ipairs(brainrot:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.Transparency = 1
                                    part.CanCollide = false
                                end
                                if part:IsA("Decal") or part:IsA("Texture") then
                                    part.Transparency = 1
                                end
                                if part:IsA("ParticleEmitter") then
                                    part.Enabled = false
                                end
                            end
                            -- Brainrot tornado invisível
                            totalProcessed = totalProcessed + 1
                        end
                    end
                end
            end
        end
    end
    
    -- VFX removidos e brainrots processados
end

local function applyRenderingSettings(distance)
    local camera = workspace.CurrentCamera
    camera.CameraType = Enum.CameraType.Custom
    camera.FieldOfView = 70
    
    -- Reduzir detalhes de objetos distantes
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Parent and obj.Parent.Name ~= "Camera" then
            local distanceToPlayer = (obj.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
            if distanceToPlayer > distance then
                if obj:FindFirstChild("Mesh") then
                    obj.Mesh.Scale = Vector3.new(0.1, 0.1, 0.1)
                end
            end
        end
    end
end

local function applyMaximumOptimization()
    local lighting = game:GetService("Lighting")
    local runService = game:GetService("RunService")
    
    -- Máxima otimização
    lighting.GlobalShadows = false
    lighting.ShadowSoftness = 0
    lighting.Brightness = 2
    lighting.Ambient = Color3.new(0.8, 0.8, 0.8)
    lighting.OutdoorAmbient = Color3.new(0.8, 0.8, 0.8)
    
    -- Desabilitar todos os efeitos
    for _, effect in pairs(lighting:GetChildren()) do
        if effect:IsA("PostEffect") or effect:IsA("Sky") then
            effect:Destroy()
        end
    end
    
    -- Desabilitar partículas
    applyParticleSettings(50)
    
    -- Reduzir renderização
    applyRenderingSettings(100)
    
    -- Remover VFX e animações dos brainrots
    removeBrainrotVFX()
    
    -- Tornar todos os brainrots invisíveis
    hideAllBrainrots()
    
    -- Otimização máxima aplicada
end

local function resetGraphicsSettings()
    local lighting = game:GetService("Lighting")
    
    -- Restaurar configurações padrão
    lighting.GlobalShadows = true
    lighting.ShadowSoftness = 0.2
    lighting.Brightness = 1
    lighting.Ambient = Color3.new(0.2, 0.2, 0.2)
    lighting.OutdoorAmbient = Color3.new(0.2, 0.2, 0.2)
    
    -- Reabilitar partículas
    for _, particle in ipairs(workspace:GetDescendants()) do
        if particle:IsA("ParticleEmitter") then
            particle.Enabled = true
        end
    end
    
    -- Configurações gráficas restauradas
end

local function applyAntiLagSettings()
    applyGraphicsQuality(GRAPHICS_QUALITY)
    applyParticleSettings(PARTICLE_DISTANCE)
    applyRenderingSettings(RENDERING_DISTANCE)
    
    -- Esconder todos os brainrots para reduzir lag
    hideAllBrainrots()
    
    -- Configurações Anti-Lag aplicadas
end

-- Função para limpar remotes problemáticos
local function clearProblematicRemotes()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    
    -- Lista de remotes que podem causar problemas
    local problematicRemotes = {
        "ChangeBrainrotStat",
        "BrainrotStatChanged",
        "UpdateBrainrotProgress"
    }
    
    for _, remoteName in ipairs(problematicRemotes) do
        local remote = replicatedStorage:FindFirstChild(remoteName)
        if remote then
            -- Remote problemático encontrado
            -- Não deletar, apenas avisar
        end
    end
    
    -- Verificação de remotes problemáticos concluída
end

-- Função para otimizar loops e reduzir spam
local function optimizeLoops()
    -- Aumentar delays dos loops para reduzir spam
    if BUY_DELAY < 2 then
        BUY_DELAY = 2
    end
    
    if FIRE_INTERVAL < 1 then
        FIRE_INTERVAL = 1
    end
    
    if BAT_INTERVAL < 0.5 then
        BAT_INTERVAL = 0.5
    end
    
    -- Loops otimizados para reduzir spam
end

UtilsTab:CreateSection("Movimento")
UtilsTab:CreateToggle({
    Name = "Noclip (F)",
    CurrentValue = NOCLIP_ENABLED,
    Flag = "NoclipToggle",
    Callback = function(value)
        NOCLIP_ENABLED = value
        if value then
            noclip()
        else
            clip()
        end
    end
})

UtilsTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        if character then
            character:BreakJoints()
        end
    end
})

UtilsTab:CreateSection("Teleporte")
UtilsTab:CreateButton({
    Name = "Teleport to Plot",
    Callback = function()
        if myPlot then
            local plotPart = myPlot:FindFirstChildWhichIsA("BasePart")
            if plotPart then
                hrp.CFrame = CFrame.new(plotPart.Position + Vector3.new(0, 10, 0))
            end
        end
    end
})

UtilsTab:CreateButton({
    Name = "Teleport to Spawn",
    Callback = function()
        local spawn = Workspace:FindFirstChild("Spawn")
        if spawn then
            local spawnPart = spawn:FindFirstChildWhichIsA("BasePart")
            if spawnPart then
                hrp.CFrame = CFrame.new(spawnPart.Position + Vector3.new(0, 5, 0))
            end
        end
    end
})

UtilsTab:CreateSection("Anti-Lag")
UtilsTab:CreateToggle({
    Name = "Anti-Lag Ativo",
    CurrentValue = ANTI_LAG_ENABLED,
    Flag = "AntiLagToggle",
    Callback = function(value)
        ANTI_LAG_ENABLED = value
        if value then
            applyAntiLagSettings()
            showNotification("Anti-Lag", "Sistema Anti-Lag ativado!")
        else
            resetGraphicsSettings()
            showNotification("Anti-Lag", "Sistema Anti-Lag desativado!")
        end
    end
})

UtilsTab:CreateSlider({
    Name = "Qualidade Gráfica",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = 1,
    Flag = "GraphicsQualitySlider",
    Callback = function(value)
        GRAPHICS_QUALITY = value
        if ANTI_LAG_ENABLED then
            applyGraphicsQuality(value)
        end
    end
})

UtilsTab:CreateSlider({
    Name = "Distância de Partículas",
    Range = {50, 1000},
    Increment = 50,
    CurrentValue = 100,
    Flag = "ParticleDistanceSlider",
    Callback = function(value)
        PARTICLE_DISTANCE = value
        if ANTI_LAG_ENABLED then
            applyParticleSettings(value)
        end
    end
})

UtilsTab:CreateSlider({
    Name = "Distância de Renderização",
    Range = {100, 2000},
    Increment = 100,
    CurrentValue = 500,
    Flag = "RenderingDistanceSlider",
    Callback = function(value)
        RENDERING_DISTANCE = value
        if ANTI_LAG_ENABLED then
            applyRenderingSettings(value)
        end
    end
})

UtilsTab:CreateButton({
    Name = "Otimização Máxima",
    Callback = function()
        GRAPHICS_QUALITY = 1
        PARTICLE_DISTANCE = 50
        RENDERING_DISTANCE = 100
        LIGHTING_QUALITY = 1
        applyMaximumOptimization()
        showNotification("Anti-Lag", "Otimização máxima aplicada!")
    end
})

UtilsTab:CreateButton({
    Name = "Restaurar Gráficos",
    Callback = function()
        resetGraphicsSettings()
        showNotification("Anti-Lag", "Configurações gráficas restauradas!")
    end
})

UtilsTab:CreateButton({
    Name = "Collect Money",
    Callback = function()
        if equipBestBrainrotsRemote then
            local success, errorMsg = pcall(function()
                equipBestBrainrotsRemote:FireServer()
            end)
            
            if success then
                showNotification("Collect Money", "Dinheiro coletado com sucesso!")
            else
                showNotification("Erro", "Erro ao coletar dinheiro: " .. tostring(errorMsg))
            end
        else
            showNotification("Erro", "Remote EquipBestBrainrots não encontrado!")
        end
    end
})


UtilsTab:CreateButton({
    Name = "Remover VFX Brainrots",
    Callback = function()
        removeBrainrotVFX()
        showNotification("VFX Removidos", "Animações e VFX dos brainrots removidos!")
    end
})

UtilsTab:CreateButton({
    Name = "Otimizar e Limpar Problemas",
    Callback = function()
        clearProblematicRemotes()
        optimizeLoops()
        showNotification("Otimização", "Problemas de spam e remotes limpos!")
    end
})

UtilsTab:CreateSection("Performance & Debug")
UtilsTab:CreateButton({
    Name = "Ver Estatísticas de Performance",
    Callback = function()
        local stats = "📊 **Estatísticas do Script:**\n\n"
        stats = stats .. "🎮 **FPS:** " .. performanceStats.fps .. "\n"
        stats = stats .. "💾 **Memória:** " .. math.floor(performanceStats.memory) .. " MB\n"
        stats = stats .. "🔄 **Loops Ativos:** " .. performanceStats.loops .. "\n"
        stats = stats .. "❌ **Erros:** " .. performanceStats.errors .. "\n\n"
        stats = stats .. "⚡ **Status dos Sistemas:**\n"
        stats = stats .. "Auto-Buy: " .. (AutoBuyEnabled and "✅" or "❌") .. "\n"
        stats = stats .. "Combat: " .. (AutoFireEnabled and "✅" or "❌") .. "\n"
        stats = stats .. "Anti-Lag: " .. (ANTI_LAG_ENABLED and "✅" or "❌") .. "\n"
        stats = stats .. "Webhook: " .. (WEBHOOK_ENABLED and "✅" or "❌")
        
        showNotification("Performance", stats)
    end
})

UtilsTab:CreateButton({
    Name = "Otimizar Performance",
    Callback = function()
        -- Aplicar otimizações extras
        task.spawn(function()
            applyMaximumOptimization()
            optimizeLoops()
            clearProblematicRemotes()
        end)
        showNotification("Otimização", "Performance otimizada!")
    end
})

UtilsTab:CreateButton({
    Name = "Limpar Cache e Reset",
    Callback = function()
        -- Limpar caches
        lastNotifiedBrainrots = {}
        lastNotifiedPlants = {}
        savedNotifications = {}
        
        -- Resetar estatísticas
        performanceStats.errors = 0
        performanceStats.loops = 0
        
        showNotification("Cache", "Cache limpo e performance resetada!")
    end
})

UtilsTab:CreateSection("Informações")
UtilsTab:CreateLabel("Script Version: 2.0 Premium")
UtilsTab:CreateLabel("Features: Auto-Buy Premium Seeds, Combat, Utils, Anti-Lag")
UtilsTab:CreateLabel("Premium Seeds: " .. #PremiumSeeds .. " disponíveis")

-- Sistema de notificações (definir antes de usar)
local function showNotification(title, message)
    Rayfield:Notify({
        Title = title,
        Content = message,
        Duration = 3,
        Image = 4483362458
    })
end

-- Sistema de Webhook do Discord
local WEBHOOK_URL = ""
local WEBHOOK_ENABLED = false
local NOTIFY_SECRET_PLANTS = true
local NOTIFY_MYTHIC_PLANTS = true
local NOTIFY_SECRET_BRAINROTS = true
local NOTIFY_LIMITED_BRAINROTS = true

-- Função para salvar configurações do webhook
local function saveWebhookSettings()
    local settings = {
        WEBHOOK_ENABLED = WEBHOOK_ENABLED,
        NOTIFY_SECRET_PLANTS = NOTIFY_SECRET_PLANTS,
        NOTIFY_MYTHIC_PLANTS = NOTIFY_MYTHIC_PLANTS,
        NOTIFY_SECRET_BRAINROTS = NOTIFY_SECRET_BRAINROTS,
        NOTIFY_LIMITED_BRAINROTS = NOTIFY_LIMITED_BRAINROTS
    }
    
    local success, errorMsg = pcall(function()
        writefile("PlantsVsBrainrot_WebhookSettings.json", game:GetService("HttpService"):JSONEncode(settings))
    end)
    
    if not success then
        print("Erro ao salvar configurações do webhook: " .. tostring(errorMsg))
    end
end

-- Função para carregar configurações do webhook
local function loadWebhookSettings()
    if isfile("PlantsVsBrainrot_WebhookSettings.json") then
        local success, settings = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile("PlantsVsBrainrot_WebhookSettings.json"))
        end)
        
        if success and settings then
            WEBHOOK_ENABLED = settings.WEBHOOK_ENABLED or false
            NOTIFY_SECRET_PLANTS = settings.NOTIFY_SECRET_PLANTS or true
            NOTIFY_MYTHIC_PLANTS = settings.NOTIFY_MYTHIC_PLANTS or true
            NOTIFY_SECRET_BRAINROTS = settings.NOTIFY_SECRET_BRAINROTS or true
            NOTIFY_LIMITED_BRAINROTS = settings.NOTIFY_LIMITED_BRAINROTS or true
            return true
        end
    end
    return false
end

-- Função para enviar webhook usando método alternativo
local function sendWebhook(title, description, color)
    if not WEBHOOK_ENABLED or WEBHOOK_URL == "" then
        return false
    end
    
    local success, errorMsg = pcall(function()
        -- Método 1: Tentar com syn.request (funciona em alguns executores)
        if syn and syn.request then
            local payload = {
                username = "SoninHub Bot",
                content = "**" .. title .. "**\n\n" .. description .. "\n\n*SoninHub v2.0 - Plants vs Brainrot*"
            }
            
            local response = syn.request({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = game:GetService("HttpService"):JSONEncode(payload)
            })
            
            return response.StatusCode == 200 or response.StatusCode == 204
        end
        
        -- Método 2: Tentar com request (executores mais antigos)
        if request then
            local payload = {
                username = "SoninHub Bot",
                content = "**" .. title .. "**\n\n" .. description .. "\n\n*SoninHub v2.0 - Plants vs Brainrot*"
            }
            
            local response = request({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = game:GetService("HttpService"):JSONEncode(payload)
            })
            
            return response.StatusCode == 200 or response.StatusCode == 204
        end
        
        -- Método 3: Usar HttpService (pode não funcionar)
        local http = game:GetService("HttpService")
        local payload = {
            username = "SoninHub Bot",
            content = "**" .. title .. "**\n\n" .. description .. "\n\n*SoninHub v2.0 - Plants vs Brainrot*"
        }
        
        local jsonPayload = http:JSONEncode(payload)
        local response = http:RequestAsync({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = jsonPayload
        })
        
        return response.Success
    end)
    
    if not success then
        print("Erro ao enviar webhook: " .. tostring(errorMsg))
        -- Salvar notificação para enviar depois
        saveNotificationForLater(title, description)
        return false
    end
    
    return true
end

-- Sistema de notificações salvas (para quando HTTP não funcionar)
local savedNotifications = {}

local function saveNotificationForLater(title, description)
    table.insert(savedNotifications, {
        title = title,
        description = description,
        timestamp = os.time()
    })
    
    -- Manter apenas as últimas 10 notificações
    if #savedNotifications > 10 then
        table.remove(savedNotifications, 1)
    end
    
    print("Notificação salva para enviar depois: " .. title)
end

-- Função alternativa para webhook com embeds
local function sendWebhookEmbed(title, description, color)
    if not WEBHOOK_ENABLED or WEBHOOK_URL == "" then
        return false
    end
    
    local success, errorMsg = pcall(function()
        local http = game:GetService("HttpService")
        local timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        
        local embed = {
            {
                title = title,
                description = description,
                color = color or 65280,
                timestamp = timestamp,
                footer = {
                    text = "SoninHub v2.0 - Plants vs Brainrot"
                },
                author = {
                    name = "SoninHub Bot",
                    icon_url = "https://cdn.discordapp.com/emojis/1234567890.png"
                }
            }
        }
        
        local payload = {
            username = "SoninHub Bot",
            embeds = embed
        }
        
        local jsonPayload = http:JSONEncode(payload)
        
        local success2, response = pcall(function()
            if syn and syn.request then
                return syn.request({
                    Url = WEBHOOK_URL,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonPayload
                })
            else
                return http:RequestAsync({
                    Url = WEBHOOK_URL,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonPayload
                })
            end
        end)
        
        return success2
    end)
    
    if not success then
        print("Erro ao enviar webhook embed: " .. tostring(errorMsg))
        return false
    end
    
    return success
end

-- Lista de plantas especiais para detectar
local SPECIAL_PLANTS = {
    -- Plantas Secretas/Godly
    ["Shroombino Seed"] = "Secret",
    ["Mango Seed"] = "Secret", 
    ["Carnivorous Plant Seed"] = "Secret",
    ["Mr Carrot Seed"] = "Secret",
    ["Tomatrio Seed"] = "Secret",
    ["Watermelon Seed"] = "Secret",
    ["Grape Seed"] = "Secret",
    ["Cocotank Seed"] = "Secret",
    -- Plantas Míticas/Legendárias
    ["Peashooter Seed"] = "Mythic",
    ["Sunflower Seed"] = "Mythic",
    ["Cherry Bomb Seed"] = "Mythic",
    ["Wall-nut Seed"] = "Mythic",
    ["Potato Mine Seed"] = "Mythic",
    ["Snow Pea Seed"] = "Mythic",
    ["Chomper Seed"] = "Mythic",
    ["Repeater Seed"] = "Mythic",
    ["Puff-shroom Seed"] = "Mythic",
    ["Sun-shroom Seed"] = "Mythic",
    ["Fume-shroom Seed"] = "Mythic",
    ["Grave Buster Seed"] = "Mythic",
    ["Hypno-shroom Seed"] = "Mythic",
    ["Scaredy-shroom Seed"] = "Mythic",
    ["Ice-shroom Seed"] = "Mythic",
    ["Doom-shroom Seed"] = "Mythic"
}

-- Função para verificar plantas secretas/míticas no shop
local function checkSecretPlants()
    if not seedsFrame then return end
    
    for _, itemFrame in ipairs(seedsFrame:GetChildren()) do
        if itemFrame:IsA("Frame") and itemFrame:FindFirstChild("Stock") then
            local seedName = itemFrame.Name
            local stock = getStock(itemFrame.Stock.Text)
            
            -- Verificar se é uma planta especial
            if stock > 0 and SPECIAL_PLANTS[seedName] then
                local plantType = SPECIAL_PLANTS[seedName]
                
                if plantType == "Secret" and NOTIFY_SECRET_PLANTS then
                    local description = "**" .. seedName .. "** está disponível no shop!\n\n"
                    description = description .. "🏪 **Loja:** Seeds Shop\n"
                    description = description .. "📦 **Estoque:** x" .. stock .. "\n"
                    description = description .. "⭐ **Raridade:** Secret/Godly\n"
                    description = description .. "💰 **Auto-Buy:** Ativo\n"
                    description = description .. "🕐 **Detectado em:** " .. os.date("%H:%M:%S") .. "\n\n"
                    description = description .. "⚡ **Corra para comprar antes que acabe!**"
                    
                    sendWebhook(
                        "🌱 PLANTA SECRETA DISPONÍVEL!",
                        description,
                        16711680 -- Vermelho
                    )
                elseif plantType == "Mythic" and NOTIFY_MYTHIC_PLANTS then
                    local description = "**" .. seedName .. "** está disponível no shop!\n\n"
                    description = description .. "🏪 **Loja:** Seeds Shop\n"
                    description = description .. "📦 **Estoque:** x" .. stock .. "\n"
                    description = description .. "⭐ **Raridade:** Mythic/Legendary\n"
                    description = description .. "💰 **Auto-Buy:** Ativo\n"
                    description = description .. "🕐 **Detectado em:** " .. os.date("%H:%M:%S") .. "\n\n"
                    description = description .. "⚡ **Corra para comprar antes que acabe!**"
                    
                    sendWebhook(
                        "🌿 PLANTA MÍTICA DISPONÍVEL!",
                        description,
                        16776960 -- Amarelo
                    )
                end
            end
        end
    end
end

-- Cache para evitar notificações duplicadas
local lastNotifiedBrainrots = {}
local lastNotifiedPlants = {}

-- Função para obter informações detalhadas do brainrot
local function getBrainrotInfo(brainrot)
    local info = {
        name = brainrot.Name,
        rarity = brainrot:GetAttribute("Rarity") or "Unknown",
        health = "N/A",
        maxHealth = "N/A",
        distance = "N/A",
        owner = "N/A",
        position = "N/A"
    }
    
    -- Obter vida do brainrot
    local humanoid = brainrot:FindFirstChild("Humanoid")
    if humanoid then
        info.health = math.floor(humanoid.Health)
        info.maxHealth = math.floor(humanoid.MaxHealth)
    end
    
    -- Calcular distância do jogador
    if character and character:FindFirstChild("HumanoidRootPart") then
        local brainrotPart = brainrot.PrimaryPart or brainrot:FindFirstChildWhichIsA("BasePart")
        if brainrotPart then
            local distance = math.floor((character.HumanoidRootPart.Position - brainrotPart.Position).Magnitude)
            info.distance = distance
            info.position = math.floor(brainrotPart.Position.X) .. ", " .. math.floor(brainrotPart.Position.Y) .. ", " .. math.floor(brainrotPart.Position.Z)
        end
    end
    
    -- Obter dono do brainrot
    local owner = brainrot:GetAttribute("Owner")
    if owner then
        info.owner = owner
    end
    
    return info
end

-- Função para verificar brainrots secretos/limitados com informações detalhadas
local function checkSecretBrainrots()
    if not brainrotsFolder then return end
    
    for _, brainrot in ipairs(brainrotsFolder:GetChildren()) do
        if brainrot:IsA("Model") then
            local rarity = brainrot:GetAttribute("Rarity")
            local brainrotName = brainrot.Name
            local brainrotId = brainrotName .. "_" .. rarity
            
            -- Evitar notificações duplicadas - APENAS SECRET e LIMITED
            if not lastNotifiedBrainrots[brainrotId] then
                if (rarity == "Secret" and NOTIFY_SECRET_BRAINROTS) or 
                   (rarity == "Limited" and NOTIFY_LIMITED_BRAINROTS) then
                    
                    local info = getBrainrotInfo(brainrot)
                    local rarityEmoji = {
                        ["Secret"] = "🔥",
                        ["Limited"] = "⚡"
                    }
                    
                    local emoji = rarityEmoji[rarity] or "🤖"
                    local color = {
                        ["Secret"] = 16711680, -- Vermelho
                        ["Limited"] = 16776960 -- Amarelo
                    }
                    
                    local description = "**" .. info.name .. "** apareceu no mapa!\n\n"
                    description = description .. "📊 **Raridade:** " .. info.rarity .. "\n"
                    description = description .. "❤️ **Vida:** " .. info.health .. " / " .. info.maxHealth .. "\n"
                    description = description .. "📏 **Distância:** " .. info.distance .. " studs\n"
                    description = description .. "👤 **Dono:** " .. info.owner .. "\n"
                    description = description .. "📍 **Posição:** " .. info.position .. "\n\n"
                    description = description .. "🎯 **Sistema de combate ativo para eliminar!**"
                    
                    sendWebhook(
                        emoji .. " BRAINROT " .. string.upper(rarity) .. " DETECTADO!",
                        description,
                        color[rarity] or 65280
                    )
                    lastNotifiedBrainrots[brainrotId] = true
                end
            end
        end
    end
    
    -- Limpar cache a cada 5 minutos
    if tick() % 300 < 10 then
        lastNotifiedBrainrots = {}
    end
end

-- Loop para verificar plantas secretas/míticas (otimizado)
task.spawn(function()
    while task.wait(45) do -- Verificar a cada 45 segundos (reduzido)
        if WEBHOOK_ENABLED and seedsFrame then
            pcall(function()
                checkSecretPlants()
            end)
        end
    end
end)

-- Loop para verificar brainrots secretos/limitados (otimizado)
task.spawn(function()
    while task.wait(15) do -- Verificar a cada 15 segundos (reduzido)
        if WEBHOOK_ENABLED and brainrotsFolder then
            pcall(function()
                checkSecretBrainrots()
            end)
        end
    end
end)

-- Nova aba de Webhook
local WebhookTab = Window:CreateTab("Discord Webhook")

WebhookTab:CreateSection("Configuração do Webhook")
WebhookTab:CreateInput({
    Name = "URL do Webhook Discord",
    PlaceholderText = "Cole aqui a URL do seu webhook do Discord...",
    RemoveTextAfterFocusLost = false,
    Flag = "WebhookURLInput",
    Callback = function(text)
        WEBHOOK_URL = text
        -- Salvar URL no arquivo
        writefile("PlantsVsBrainrot_WebhookURL.txt", text)
    end
})

WebhookTab:CreateToggle({
    Name = "Ativar Webhook",
    CurrentValue = WEBHOOK_ENABLED,
    Flag = "WebhookToggle",
    Callback = function(value)
        WEBHOOK_ENABLED = value
        if value and WEBHOOK_URL == "" then
            showNotification("Webhook", "Configure a URL do webhook primeiro!")
            WEBHOOK_ENABLED = false
        else
            showNotification("Webhook", "Webhook " .. (value and "ativado" or "desativado") .. "!")
            saveWebhookSettings() -- Salvar configurações automaticamente
        end
    end
})

WebhookTab:CreateButton({
    Name = "Testar Webhook Simples",
    Callback = function()
        if WEBHOOK_URL == "" then
            showNotification("Erro", "Configure a URL do webhook primeiro!")
            return
        end
        
        local success = sendWebhook(
            "🧪 TESTE DO WEBHOOK SIMPLES",
            "Se você está vendo esta mensagem, o webhook está funcionando perfeitamente!\n\n**SoninHub v2.0** - Sistema de notificações ativo!",
            3447003
        )
        
        if success then
            showNotification("Webhook", "Teste simples enviado com sucesso!")
        else
            showNotification("Erro", "Falha ao enviar teste simples!")
        end
    end
})

WebhookTab:CreateButton({
    Name = "Testar Webhook com Embed",
    Callback = function()
        if WEBHOOK_URL == "" then
            showNotification("Erro", "Configure a URL do webhook primeiro!")
            return
        end
        
        local success = sendWebhookEmbed(
            "🧪 TESTE DO WEBHOOK COM EMBED",
            "Se você está vendo esta mensagem com embed, o webhook está funcionando perfeitamente!\n\n**SoninHub v2.0** - Sistema de notificações ativo!",
            3447003
        )
        
        if success then
            showNotification("Webhook", "Teste com embed enviado com sucesso!")
        else
            showNotification("Erro", "Falha ao enviar teste com embed!")
        end
    end
})

WebhookTab:CreateButton({
    Name = "Testar Notificação Detalhada",
    Callback = function()
        if WEBHOOK_URL == "" then
            showNotification("Erro", "Configure a URL do webhook primeiro!")
            return
        end
        
        -- Simular notificação de brainrot detalhada (Secret)
        local description = "**Matteo** apareceu no mapa!\n\n"
        description = description .. "📊 **Raridade:** Secret\n"
        description = description .. "❤️ **Vida:** 2500 / 3000\n"
        description = description .. "📏 **Distância:** 25 studs\n"
        description = description .. "👤 **Dono:** guilhermeolol201\n"
        description = description .. "📍 **Posição:** 123, 45, 678\n\n"
        description = description .. "🎯 **Sistema de combate ativo para eliminar!**"
        
        local success = sendWebhook(
            "🔥 BRAINROT SECRET DETECTADO!",
            description,
            16711680 -- Vermelho
        )
        
        if success then
            showNotification("Teste", "Notificação detalhada enviada com sucesso!")
        else
            showNotification("Erro", "Falha ao enviar notificação detalhada!")
        end
    end
})

WebhookTab:CreateButton({
    Name = "Testar Conectividade",
    Callback = function()
        if WEBHOOK_URL == "" then
            showNotification("Erro", "Configure a URL do webhook primeiro!")
            return
        end
        
        local success, errorMsg = pcall(function()
            local http = game:GetService("HttpService")
            local testPayload = {
                username = "SoninHub Test",
                content = "🔗 Teste de conectividade - " .. os.date("%H:%M:%S")
            }
            
            local jsonPayload = http:JSONEncode(testPayload)
            
            if syn and syn.request then
                local response = syn.request({
                    Url = WEBHOOK_URL,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonPayload
                })
                return response.StatusCode == 200
            else
                local response = http:RequestAsync({
                    Url = WEBHOOK_URL,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonPayload
                })
                return response.Success
            end
        end)
        
        if success then
            showNotification("Conectividade", "Webhook conectado com sucesso!")
        else
            showNotification("Erro", "Falha na conectividade: " .. tostring(errorMsg))
        end
    end
})

WebhookTab:CreateSection("Notificações de Plantas")
WebhookTab:CreateToggle({
    Name = "Notificar Plantas Secretas/Godly",
    CurrentValue = NOTIFY_SECRET_PLANTS,
    Flag = "NotifySecretPlantsToggle",
    Callback = function(value)
        NOTIFY_SECRET_PLANTS = value
        showNotification("Webhook", "Notificação de plantas secretas " .. (value and "ativada" or "desativada") .. "!")
        saveWebhookSettings() -- Salvar configurações automaticamente
    end
})

WebhookTab:CreateToggle({
    Name = "Notificar Plantas Míticas/Legendárias",
    CurrentValue = NOTIFY_MYTHIC_PLANTS,
    Flag = "NotifyMythicPlantsToggle",
    Callback = function(value)
        NOTIFY_MYTHIC_PLANTS = value
        showNotification("Webhook", "Notificação de plantas míticas " .. (value and "ativada" or "desativada") .. "!")
        saveWebhookSettings() -- Salvar configurações automaticamente
    end
})

WebhookTab:CreateSection("Notificações de Brainrots")
WebhookTab:CreateToggle({
    Name = "Notificar Brainrots Secretos",
    CurrentValue = NOTIFY_SECRET_BRAINROTS,
    Flag = "NotifySecretBrainrotsToggle",
    Callback = function(value)
        NOTIFY_SECRET_BRAINROTS = value
        showNotification("Webhook", "Notificação de brainrots secretos " .. (value and "ativada" or "desativada") .. "!")
        saveWebhookSettings() -- Salvar configurações automaticamente
    end
})

WebhookTab:CreateToggle({
    Name = "Notificar Brainrots Limitados",
    CurrentValue = NOTIFY_LIMITED_BRAINROTS,
    Flag = "NotifyLimitedBrainrotsToggle",
    Callback = function(value)
        NOTIFY_LIMITED_BRAINROTS = value
        showNotification("Webhook", "Notificação de brainrots limitados " .. (value and "ativada" or "desativada") .. "!")
        saveWebhookSettings() -- Salvar configurações automaticamente
    end
})


WebhookTab:CreateSection("Informações")
WebhookTab:CreateLabel("Como configurar:")
WebhookTab:CreateLabel("1. Vá no seu servidor do Discord")
WebhookTab:CreateLabel("2. Configurações do Canal > Integrações > Webhooks")
WebhookTab:CreateLabel("3. Criar Webhook > Copiar URL")
WebhookTab:CreateLabel("4. Cole a URL no campo acima")
WebhookTab:CreateLabel("5. Ative o webhook e teste!")

WebhookTab:CreateSection("⚠️ IMPORTANTE")
WebhookTab:CreateLabel("Se der erro de HTTP:")
WebhookTab:CreateLabel("• Use Synapse X, Script-Ware ou KRNL")
WebhookTab:CreateLabel("• Alguns executores bloqueiam HTTP")
WebhookTab:CreateLabel("• Notificações são salvas automaticamente")
WebhookTab:CreateLabel("• Tente usar webhook externo (veja abaixo)")

WebhookTab:CreateSection("🎯 Foco em Raridades")
WebhookTab:CreateLabel("• Apenas Brainrots SECRET e LIMITED")
WebhookTab:CreateLabel("• Plantas Secretas/Godly e Míticas/Legendárias")
WebhookTab:CreateLabel("• Notificações otimizadas e detalhadas")

WebhookTab:CreateButton({
    Name = "Ver Notificações Salvas",
    Callback = function()
        if #savedNotifications == 0 then
            showNotification("Notificações", "Nenhuma notificação salva!")
        else
            local message = "Notificações salvas (" .. #savedNotifications .. "):\n"
            for i, notif in ipairs(savedNotifications) do
                message = message .. i .. ". " .. notif.title .. "\n"
            end
            showNotification("Notificações Salvas", message)
        end
    end
})

WebhookTab:CreateButton({
    Name = "Limpar Notificações Salvas",
    Callback = function()
        savedNotifications = {}
        showNotification("Notificações", "Notificações salvas limpas!")
    end
})

WebhookTab:CreateButton({
    Name = "Resetar Configurações",
    Callback = function()
        WEBHOOK_ENABLED = false
        NOTIFY_SECRET_PLANTS = true
        NOTIFY_MYTHIC_PLANTS = true
        NOTIFY_SECRET_BRAINROTS = true
        NOTIFY_LIMITED_BRAINROTS = true
        saveWebhookSettings()
        showNotification("Reset", "Configurações do webhook resetadas!")
    end
})

WebhookTab:CreateSection("Debug")
WebhookTab:CreateButton({
    Name = "Verificar Status",
    Callback = function()
        local status = "URL: " .. (WEBHOOK_URL ~= "" and "✅ Configurada" or "❌ Não configurada")
        status = status .. "\nWebhook: " .. (WEBHOOK_ENABLED and "✅ Ativo" or "❌ Inativo")
        status = status .. "\nPlantas Secretas: " .. (NOTIFY_SECRET_PLANTS and "✅ Ativo" or "❌ Inativo")
        status = status .. "\nPlantas Míticas: " .. (NOTIFY_MYTHIC_PLANTS and "✅ Ativo" or "❌ Inativo")
        status = status .. "\nBrainrots Secretos: " .. (NOTIFY_SECRET_BRAINROTS and "✅ Ativo" or "❌ Inativo")
        status = status .. "\nBrainrots Limitados: " .. (NOTIFY_LIMITED_BRAINROTS and "✅ Ativo" or "❌ Inativo")
        
        showNotification("Status do Webhook", status)
    end
})

WebhookTab:CreateButton({
    Name = "Limpar Cache",
    Callback = function()
        lastNotifiedBrainrots = {}
        lastNotifiedPlants = {}
        showNotification("Cache", "Cache de notificações limpo!")
    end
})

WebhookTab:CreateSection("🌐 Solução Alternativa")
WebhookTab:CreateLabel("Se HTTP não funcionar, use:")
WebhookTab:CreateLabel("1. webhook.site (temporário)")
WebhookTab:CreateLabel("2. Discord bot externo")
WebhookTab:CreateLabel("3. Executor com HTTP habilitado")
WebhookTab:CreateLabel("4. Notificações são salvas automaticamente")

WebhookTab:CreateButton({
    Name = "Gerar Código para Webhook Externo",
    Callback = function()
        local code = [[
-- Cole este código em um bot Discord ou script externo
-- Substitua WEBHOOK_URL pela sua URL do Discord

local function sendNotification(title, description)
    local payload = {
        username = "SoninHub Bot",
        content = "**" .. title .. "**\n\n" .. description .. "\n\n*SoninHub v2.0*"
    }
    
    -- Enviar para webhook
    -- Implementar envio HTTP aqui
end

-- Exemplos de uso:
sendNotification("🌱 PLANTA SECRETA!", "Shroombino Seed disponível!")
sendNotification("🔥 BRAINROT SECRETO!", "Matteo detectado no mapa!")
]]
        
        -- Salvar código em arquivo
        writefile("webhook_external_code.txt", code)
        showNotification("Código Gerado", "Código salvo em 'webhook_external_code.txt'!")
    end
})

-- Carregar configurações do webhook
loadWebhookSettings()

-- Carregar URL salva do webhook
if isfile("PlantsVsBrainrot_WebhookURL.txt") then
    WEBHOOK_URL = readfile("PlantsVsBrainrot_WebhookURL.txt")
    if WEBHOOK_URL ~= "" then
        showNotification("Webhook", "URL do webhook carregada automaticamente!")
        
        -- Notificar inicialização do script apenas se webhook estiver ativo
        if WEBHOOK_ENABLED then
            task.wait(3) -- Aguardar 3 segundos para tudo carregar
            sendWebhook(
                "🚀 SONINHUB v2.0 INICIADO!",
                "**SoninHub v2.0** foi iniciado com sucesso!\n\n✅ Auto-Buy: Ativo\n✅ Combat: Ativo\n✅ Anti-Lag: Ativo\n✅ Anti-AFK: Ativo\n✅ Webhook: Conectado\n\n🎯 Monitorando plantas secretas e brainrots especiais!",
                3447003 -- Azul
            )
        end
    end
end

-- Nova aba de configurações
local ConfigTab = Window:CreateTab("Config")
local currentConfigName = "Minha Config"
local savedConfigNames = {"Config1", "Config2", "Config3", "Config4", "Config5"}

ConfigTab:CreateSection("Criar Nova Configuração")
ConfigTab:CreateInput({
    Name = "Nome da Configuração",
    PlaceholderText = "Digite o nome da sua config...",
    RemoveTextAfterFocusLost = false,
    Flag = "ConfigNameInput",
    Callback = function(text)
        currentConfigName = text
    end
})

ConfigTab:CreateButton({
    Name = "Criar e Salvar Configuração",
    Callback = function()
        if currentConfigName and currentConfigName ~= "" then
            -- Tentando salvar config
            
            local success, errorMsg = pcall(function()
                return saveConfig(currentConfigName)
            end)
            
            if success then
                -- Atualizar a lista de configurações
                updateConfigList()
                showNotification("Config Criada", "Configuração '" .. currentConfigName .. "' criada e salva com sucesso!")
                -- Config salva com sucesso
            else
                showNotification("Erro", "Falha ao salvar configuração: " .. tostring(errorMsg))
                -- Erro ao salvar
            end
        else
            showNotification("Erro", "Digite um nome para a configuração!")
        end
    end
})

ConfigTab:CreateSection("Gerenciar Configurações Salvas")
local configDropdown = ConfigTab:CreateDropdown({
    Name = "Configurações Salvas",
    Options = savedConfigNames,
    CurrentOption = savedConfigNames[1] or "",
    Flag = "ConfigDropdown",
    Callback = function(selected)
        currentConfigName = selected
        if ConfigSystem.Configs[selected] then
            loadConfig(selected)
            showNotification("Config Carregada", "Configuração '" .. selected .. "' carregada com sucesso!")
        end
    end
})

-- Função para atualizar a lista de configurações
local function updateConfigList()
    savedConfigNames = loadSavedConfigs()
    configDropdown:SetOptions(savedConfigNames)
    if #savedConfigNames > 0 then
        configDropdown:SetCurrentOption(savedConfigNames[1])
    end
    -- Lista de configs atualizada
end

ConfigTab:CreateButton({
    Name = "Salvar na Config Selecionada",
    Callback = function()
        if currentConfigName and currentConfigName ~= "" then
            if saveConfig(currentConfigName) then
                updateConfigList()
                showNotification("Config Salva", "Configuração '" .. currentConfigName .. "' salva com sucesso!")
            else
                showNotification("Erro", "Falha ao salvar configuração!")
            end
        else
            showNotification("Erro", "Selecione uma configuração!")
        end
    end
})

ConfigTab:CreateButton({
    Name = "Carregar Config Selecionada",
    Callback = function()
        if currentConfigName and currentConfigName ~= "" then
            if loadConfig(currentConfigName) then
                showNotification("Config Carregada", "Configuração '" .. currentConfigName .. "' carregada com sucesso!")
            else
                showNotification("Erro", "Configuração '" .. currentConfigName .. "' não encontrada!")
            end
        else
            showNotification("Erro", "Selecione uma configuração!")
        end
    end
})

ConfigTab:CreateButton({
    Name = "Deletar Config Selecionada",
    Callback = function()
        if currentConfigName and currentConfigName ~= "" then
            if ConfigSystem.Configs[currentConfigName] then
                ConfigSystem.Configs[currentConfigName] = nil
                delfile("PlantsVsBrainrot_" .. currentConfigName .. ".json")
                updateConfigList()
                showNotification("Config Deletada", "Configuração '" .. currentConfigName .. "' deletada com sucesso!")
                currentConfigName = ""
            else
                showNotification("Erro", "Configuração não encontrada!")
            end
        else
            showNotification("Erro", "Selecione uma configuração para deletar!")
        end
    end
})

ConfigTab:CreateSection("Auto Load")
ConfigTab:CreateToggle({
    Name = "Auto Load Config",
    CurrentValue = ConfigSystem.AutoLoad,
    Flag = "AutoLoadToggle",
    Callback = function(value)
        ConfigSystem.AutoLoad = value
        writefile("PlantsVsBrainrot_AutoLoad.json", tostring(value))
    end
})

ConfigTab:CreateDropdown({
    Name = "Config para Auto Load",
    Options = {"Config1", "Config2", "Config3", "Config4", "Config5"},
    CurrentOption = "Config1",
    Flag = "AutoLoadConfigDropdown",
    Callback = function(selected)
        writefile("PlantsVsBrainrot_AutoLoadConfig.json", selected)
    end
})

ConfigTab:CreateSection("Configurações Rápidas")
ConfigTab:CreateButton({
    Name = "Config Padrão (Secret/Limited)",
    Callback = function()
        SelectedSeeds = {}
        SelectedGears = {}
        AutoBuyEnabled = false
        SelectedRarities = {"Secret", "Limited"}
        AutoFireEnabled = false
        AUTO_TP_ENABLED = false
        showNotification("Config Padrão", "Configuração padrão aplicada!")
    end
})

ConfigTab:CreateButton({
    Name = "Config Premium (Todas as Raridades)",
    Callback = function()
        SelectedSeeds = PremiumSeeds
        SelectedGears = {}
        AutoBuyEnabled = true
        SelectedRarities = {"Rare", "Epic", "Legendary", "Mythic", "Godly", "Secret", "Limited"}
        AutoFireEnabled = true
        AUTO_TP_ENABLED = true
        showNotification("Config Premium", "Configuração premium aplicada!")
    end
})

ConfigTab:CreateSection("Debug")
ConfigTab:CreateButton({
    Name = "Atualizar Lista de Configs",
    Callback = function()
        updateConfigList()
        showNotification("Lista Atualizada", "Lista de configurações atualizada!")
    end
})

ConfigTab:CreateButton({
    Name = "Testar Sistema de Arquivos",
    Callback = function()
        local success, errorMsg = pcall(function()
            writefile("test_file.txt", "Teste de salvamento")
            local content = readfile("test_file.txt")
            delfile("test_file.txt")
            return content
        end)
        
        if success then
            showNotification("Sistema OK", "Arquivos funcionando corretamente!")
            -- Sistema de arquivos funcionando
        else
            showNotification("Erro", "Problema com arquivos: " .. tostring(errorMsg))
            -- Erro no sistema de arquivos
        end
    end
})

ConfigTab:CreateSection("Informações")
ConfigTab:CreateLabel("Configurações salvas: " .. #savedConfigs)
if #savedConfigs > 0 then
    ConfigTab:CreateLabel("Configs: " .. table.concat(savedConfigs, ", "))
end
ConfigTab:CreateLabel("Auto Load: " .. (ConfigSystem.AutoLoad and "Ativo" or "Inativo"))

-- Carregar configuração automática se habilitada
if ConfigSystem.AutoLoad then
    if isfile("PlantsVsBrainrot_AutoLoadConfig.json") then
        local autoLoadConfig = readfile("PlantsVsBrainrot_AutoLoadConfig.json")
        if ConfigSystem.Configs[autoLoadConfig] then
            loadConfig(autoLoadConfig)
            showNotification("Auto Load", "Configuração '" .. autoLoadConfig .. "' carregada automaticamente!")
        end
    end
end


-- Verificação de funcionalidades carregadas
local loadedFeatures = {}
if dataRemoteEvent then table.insert(loadedFeatures, "Auto-Buy") end
if useItemRemote then table.insert(loadedFeatures, "Combat") end
if brainrotsFolder then table.insert(loadedFeatures, "Brainrot Detection") end
if seedsFrame then table.insert(loadedFeatures, "Seeds Shop") end
if gearsFrame then table.insert(loadedFeatures, "Gears Shop") end

local featuresText = table.concat(loadedFeatures, ", ")
if featuresText == "" then
    featuresText = "Carregando..."
end

-- Ativar noclip por padrão
if NOCLIP_ENABLED then
    noclip()
end

-- Aplicar otimizações por padrão (depois das funções estarem definidas)
task.spawn(function()
    task.wait(2) -- Aguardar 2 segundos para tudo carregar
    
    -- Ativar anti-lag por padrão
    if ANTI_LAG_ENABLED then
        applyAntiLagSettings()
    end
    
    -- Aplicar otimização máxima por padrão
    applyMaximumOptimization()
    
    -- Otimizar loops e limpar problemas automaticamente
    optimizeLoops()
    clearProblematicRemotes()
    
    -- Otimizações padrão aplicadas com sucesso
end)

-- Notificação de inicialização
showNotification("Script Carregado", "SoninHub v2.0 - Preset Ativo!\nAuto-Buy: ✅ | Combat: ✅ | Noclip: ✅ | Anti-Lag: ✅ | Anti-AFK: ✅\nOtimização Máxima: ✅\nFuncionalidades: " .. featuresText)
