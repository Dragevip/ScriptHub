local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dragevip/ScriptHub/main/source.lua"))()
local Window = Library.CreateLib("Script Hub", "BloodTheme")

--MAIN
local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Main")


MainSection:NewButton("Infinite Yield", "Opens Infinite Yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

MainSection:NewButton("Remote Spy", "Opens SimpleSpy", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua'))()
end)

MainSection:NewButton("Gravity Gun", "Gives you a gravity gun", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Dragevip/ScriptHub/main/GravityGun.lua'))()
end)

MainSection:NewButton("UNC Test", "Shows you how much UNC your executor has", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/unified-naming-convention/NamingStandard/main/UNCCheckEnv.lua", true))()
end)

MainSection:NewToggle("ESP", "Toggles esp", function(state)
    if state then
      for _, v in game.Players:GetChildren() do
        if v.Name == not game.Players.LocalPlayer.Name then
          local esp = Instance.new("Highlight")
          esp.Name = "esp"
          esp.Parent = v.Character
        end
      end
    else
      for _, v in game.Players:GetChildren() do
        if v.Name == not game.Players.LocalPlayer.Name then
          v.Character.esp:Remove()
        end
      end
    end
end)

MainSection:NewSlider("Walk Speed", "Changes Your Walk Speed", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

MainSection:NewSlider("Jump Height", "Changes Your Jump Height", 500, 50, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

--Piggy
local Piggy = Window:NewTab("Piggy")
local PiggySection = Piggy:NewSection("Piggy")

PiggySection:NewButton("Piggy Book 1 Hub", "Opens a hub for piggy book 1", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Piggy/Book_1.lua"))()
end)

Map = "House"
Mode = "Bot"
PiggySection:NewToggle("Auto Vote", "Automatically votes for the next map and gamemode", function(state)
    while state do
        task.wait(0.5)
        game.ReplicatedStorage.Remotes.NewVote:FireServer("Map", Map)
        game.ReplicatedStorage.Remotes.NewVote:FireServer("Piggy", Mode)
    end
end)

PiggySection:NewDropdown("AutoVote Map", "The map you want to vote for", {"House", "Station", "Gallery", "Forest", "School", "Hospital", "Metro", "Carnival", "City", "Mall", "Outpost", "Plant"}, function(currentOption)
    Map = currentOption
end)

PiggySection:NewDropdown("AutoVote Mode", "The gamemode you want to vote for", {"Bot", "Player", "PlayerBot", "Infection", "Traitor", "Swarm", "Tag"}, function(currentOption)
    Mode = currentOption
end)

--3008
local ikea = Window:NewTab("3008")
local ikeaSection = ikea:NewSection("3008")

ikeaSection:NewButton("Remove Fall Damage", "", function()
    if game.Players.LocalPlayer.Character:FindFirstChild("FallDamage") then
        game.Players.LocalPlayer.Character.FallDamage:Remove() 
    end
end)

--BEAR (Alpha)
local bear = Window:NewTab("BEAR (Alpha)")
local bearsection = bear:NewSection("BEAR (Alpha)")

getgenv().Toggled = false

bearsection:NewToggle("Toggle AutoWin", "Automatically completes puzzles as survivor or kills other players as bear", function(state)
   getgenv().Toggled = state
end)

getgenv().Running = false

game:GetService("RunService").RenderStepped:Connect(function()

    if getgenv().Toggled and not getgenv().Running then
        getgenv().Running = true
        while getgenv().Toggled do
            local plr = game.Players.LocalPlayer
            local char = plr.Character
            local rootpart = char.HumanoidRootPart
            if plr.Team.Name == "Bear" then
                wait(1)
                while plr.Team.Name == "Bear" and getgenv().Toggled do
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player.Team and player.Team.Name == "Survivors" and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            player.Character:SetPrimaryPartCFrame(rootpart.CFrame + Vector3.new(0, 3, 0))
                        end
                    end
                    wait(0.5)
                end
            elseif plr.Team.Name == "Survivors" then
                local puzzles = game.Workspace.PuzzleBin
                wait(2)
                local function WirePuzzle(v)
                    for _, s in v.Wires:GetChildren() do
                        for i = 1, 15, 1 do
                            if s:FindFirstChild("ClickDetector") then
                                fireclickdetector(s.ClickDetector)
                            else
                                break
                            end
                            wait()
                        end
                    end
                    print("Wires Complete")
                end
                
                local function ColorCode()
                    for i = 1, 4 do 
                        while puzzles.ColorCode.Buttons[i].Note.Label.Text ~= puzzles.ColorCode.Clue.Note.Frame[i].Text do
                            fireclickdetector(puzzles.ColorCode.Buttons[i].ClickDetector)
                            wait(0.2)
                        end
                    end
                    print("Color Code Complete")
                end
                
                local function CheesePuzzle(altar)
                    local function CompleteCheese(cheese)
                        local firstpos = rootpart.CFrame
                        rootpart.CFrame = cheese.CFrame
                        wait(0.3)
                        char.Humanoid:EquipTool(plr.Backpack:FindFirstChild("PuzzleCheese"))
                        rootpart.CFrame = altar.Cheese.CFrame
                        wait(0.2)
                        char.Humanoid:UnequipTools()
                        rootpart.CFrame = firstpos
                        wait(0.3)
                    end
                    if workspace.Map._Entities:FindFirstChild("Cheese") then
                        CompleteCheese(workspace.Map._Entities:FindFirstChild("Cheese").Cheese)
                    elseif workspace.Map._Entities:FindFirstChild("CheeseCollect") then
                        CompleteCheese(workspace.Map._Entities:FindFirstChild("CheeseCollect").Cheese)
                    end
                    print("Cheese Complete")
                end
                
                
                
                for _, v in workspace.PuzzleBin:GetChildren() do
                    if v.Name == "Wire" then
                        local co = coroutine.create(function()
                            WirePuzzle(v)
                        end)
                        coroutine.resume(co)
                    end
                
                    if v.Name == "ColorCode" then
                        local co = coroutine.create(ColorCode)
                        coroutine.resume(co)
                    end
                
                    if v.Name == "CheeseAltar" then
                        local co = coroutine.create(CheesePuzzle)
                        coroutine.resume(co, v)
                    end
                end
                
                while plr.Team == game.Teams:FindFirstChild("Survivors") and getgenv().Toggled do
                    wait(0.2)
                end
            end
            wait(0.2)
        end
    end
    if not getgenv().Toggled then
        getgenv().Running = false
    end
end)

--[[bearsection:NewButton("AutoPuzzle (WIP)", "Automatically does every puzzle for you", function()
    local char = game.Players.LocalPlayer.Character
    local rootpart = char.HumanoidRootPart
    local firstpos = rootpart.CFrame
    wait(2)
    for _, v in workspace.PuzzleBin:GetChildren() do
        if v.Name == "Wire" then
            rootpart.CFrame = v.Back.CFrame
            for _, s in v.Wires:GetChildren() do
                wait(0.3)
                for i = 1, 15, 1 do
                    if s:FindFirstChild("ClickDetector") then
                        fireclickdetector(s.ClickDetector)
                    else
                    --print("Wire Finished")
                    end
                    wait(0.01)
                end


            end
            wait(1)
        end

        local function CheesePuzzle(cheese)
            rootpart.CFrame = cheese.CFrame
            wait(0.3)
            char.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("PuzzleCheese"))
            rootpart.CFrame = v.Cheese.CFrame
            wait(0.1)
            char.Humanoid:UnequipTools()
            wait(0.3)
        end

        if v.Name == "CheeseAltar" then
            if workspace.Map._Entities:FindFirstChild("Cheese") then
                CheesePuzzle(workspace.Map._Entities:FindFirstChild("Cheese").Cheese)
            elseif workspace.Map._Entities:FindFirstChild("CheeseCollect") then
                CheesePuzzle(workspace.Map._Entities:FindFirstChild("CheeseCollect").Cheese)
            end
        end

        if v.Name == "ColorCode" then
            rootpart.CFrame = v.Buttons["1"].CFrame
            for i = 1, 4 do 
                for f = 1, 10 do
                    if v.Buttons[i].Note.Label.Text ~= v.Clue.Note.Frame[i].Text then
                        fireclickdetector(v.Buttons[i].ClickDetector)
                        wait(0.5)
                    end
                end
            end
        end
    end
	
	bearsection:NewButton("Kill All (Bear Only)", "Teleports you to everybody to kill them", function()
		local function KillAll()
			local rootpart = game.Players.LocalPlayer.Character.HumanoidRootPart
			local pos = rootpart.CFrame
			for _, v in game.Players:GetChildren() do
				if v ~= game.Players.LocalPlayer and v.Team.Name == "Survivors" then
					for i = 0, 30 do
						rootpart.CFrame = v.Character.HumanoidRootPart.CFrame
						wait()
					end
				end
			end
			rootpart.CFrame = pos
		end
		local uis = game:GetService("UserInputService")
		uis.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.RightBracket then
				if game.Players.LocalPlayer.Team.Name == "Bear" then
					KillAll()
				end
			end
		end)
	end)
	
    rootpart.CFrame = firstpos]
end)]]--
