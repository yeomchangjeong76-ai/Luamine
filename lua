-- [[ HK416 & RWA SYSTEM INTEGRATED LOADER ]]
-- Powered by Your Secret Hack Group

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InsertService = game:GetService("InsertService")
local LocalPlayer = Players.LocalPlayer

-- [ 1. 기능: 리모트 & 스크립트 자동 스캔 및 복사 ]
local function AutoScanAndCopy()
    local output = "--- [ RWA & BABFT SCAN REPORT ] ---\n\n"
    local count = 0
    
    -- 리모트 스캔
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            output = output .. "Name: " .. obj.Name .. " | Path: " .. obj:GetFullName() .. "\n"
            count = count + 1
        end
    end
    
    -- 클립보드 복사 (익스큐터 전용 함수)
    if setclipboard then
        setclipboard(output)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "SCAN SUCCESS",
            Text = count .. "개의 리모트 정보가 클립보드에 복사되었습니다!",
            Duration = 5
        })
    end
end

-- [ 2. 기능: HK416 무기 지급 및 사살 로직 ]
local function GiveHK416()
    local HK416_ID = 2402476448
    local success, model = pcall(function() return InsertService:LoadAsset(HK416_ID) end)
    
    if success and model then
        local tool = model:FindFirstChildOfClass("Tool") or model:FindFirstChildWhichIsA("Model")
        if tool then
            tool.Name = "HK416_Elite"
            tool.Parent = LocalPlayer.Backpack
            
            -- 사격 시 보이드 킬(Void Kill) 트리거
            tool.Activated:Connect(function()
                -- 여기에 실시간으로 스캔한 리모트 이름을 적용하면 됨
                print("HK416 Fired: Targeting nearest player...")
            end)
        end
    end
end

-- [ 3. 메인 실행부 ]
local function Main()
    -- 안티 안티치트 실행 (메타테이블 변조)
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__index
    mt.__index = newcclosure(function(t, k)
        if not checkcaller() and t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower") then
            return k == "WalkSpeed" and 16 or 50
        end
        return old(t, k)
    end)
    setreadonly(mt, true)

    -- 기능 가동
    AutoScanAndCopy()
    GiveHK416()

    -- 로고 출력
    print([[ 
    ____  _  _  ____  ____ 
   (  _ \( \/ )(  _ \(  _ \
    ) _ ( \  /  ) _ ( )   /
   (____/  \/  (____/(_)\_)
    HK416 ELITE SYSTEM LOADED
    ]])
end

pcall(Main)

