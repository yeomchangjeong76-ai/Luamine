-- [[ SCRIPT SOURCE CLONER v1.0 ]]
local setclipboard = setclipboard or print
local decompile = decompile or nil -- 익스큐터의 디컴파일러 기능 확인

local function CopyScriptSource(scriptName)
    -- 1. 게임 전체에서 해당 이름의 스크립트를 찾음
    local targetScript = nil
    for _, obj in pairs(game:GetDescendants()) do
        if obj.Name == scriptName and (obj:IsA("LocalScript") or obj:IsA("ModuleScript")) then
            targetScript = obj
            break
        end
    end

    if targetScript then
        -- 2. 소스 코드 추출 (익스큐터의 디컴파일 기능 사용)
        local source = ""
        if decompile then
            source = decompile(targetScript) -- 바이트코드를 다시 루아 코드로 변환
        else
            source = "-- [ERROR] Your executor doesn't support decompiling."
        end

        local finalData = "--- [ SCRIPT CLONED: " .. targetScript.Name .. " ] ---\n"
        finalData = finalData .. "Path: " .. targetScript:GetFullName() .. "\n\n"
        finalData = finalData .. source

        -- 3. 클립보드 복사
        setclipboard(finalData)
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "COPY SUCCESS",
            Text = scriptName .. " 소스 코드가 복사되었습니다!",
            Duration = 5
        })
    else
        warn("[SYSTEM] 해당 이름의 스크립트를 찾을 수 없거나 서버 전용 스크립트입니다.")
    end
end

-- 실행 예시: 'MainClient'라는 이름의 스크립트를 복사하고 싶을 때
CopyScriptSource("SubmitName") 
