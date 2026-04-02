-- [[ BABFT DEEP REMOTE SCANNER v2.0 ]]
local setclipboard = setclipboard or print

local function DeepScan()
    local results = "--- [ BABFT DEEP SCAN RESULTS ] ---\n"
    local count = 0
    
    -- 탐색할 서비스 목록
    local services = {
        game:GetService("ReplicatedStorage"),
        game:GetService("Workspace"),
        game:GetService("JointsService"),
        game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    }

    for _, service in pairs(services) do
        for _, obj in pairs(service:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                -- 이름, 부모, 그리고 실제 경로(FullName)까지 복사해서 정확한 위치 파악
                results = results .. "Name: " .. obj.Name .. " | Path: " .. obj:GetFullName() .. "\n"
                count = count + 1
            end
        end
    end

    results = results .. "\nTotal Found: " .. count
    setclipboard(results)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "DEEP SCAN COMPLETE",
        Text = count .. "개의 숨겨진 리모트를 찾았습니다! (클립보드 확인)",
        Duration = 5
    })
end

pcall(DeepScan)

