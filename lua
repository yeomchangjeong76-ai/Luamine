-- [[ REMOTE EVENT AUTO-SCANNER & CLIPBOARD COPIER ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local setclipboard = setclipboard or print -- 익스큐터가 setclipboard를 지원하지 않으면 콘솔에 출력

local function ScanRemotes()
    local foundRemotes = "--- [ SCANNED REMOTE EVENTS ] ---\n"
    local count = 0

    -- ReplicatedStorage 전체를 뒤져서 리모트 이벤트를 찾음
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            foundRemotes = foundRemotes .. "Name: " .. obj.Name .. " | Parent: " .. obj.Parent.Name .. "\n"
            count = count + 1
        end
    end

    foundRemotes = foundRemotes .. "\nTotal Found: " .. count
    
    -- [핵심] 클립보드에 복사
    setclipboard(foundRemotes)

    -- 알림 출력 (의뢰인 확인용)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "SCAN COMPLETE",
        Text = count .. "개의 리모트 이벤트가 클립보드에 복사되었습니다!",
        Duration = 5
    })
end

-- 실행
pcall(ScanRemotes)

