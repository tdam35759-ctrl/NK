if _G.NKCleanup then
    pcall(_G.NKCleanup)
end

local G = game
local S = function(n) return G:GetService(n) end
local P, RS, L, TS, UIS = S("Players").LocalPlayer, S("RunService"), S("Lighting"), S("TweenService"), S("UserInputService")
local PG = P:WaitForChild("PlayerGui")

if PG:FindFirstChild("NKMenu") then PG.NKMenu:Destroy() end
local sg = Instance.new("ScreenGui", PG)
sg.Name = "NKMenu"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local H, U, V, F, FB = Color3.fromHex, UDim2.new, Vector3.new, Enum.Font.SourceSansBold, Enum.Font.SourceSansSemibold
local cBg, cCard, cCardH, cAcc, cAccD, cTxt, cSub, cWht, bgId = H("141018"), H("1E1824"), H("282030"), H("FF5C9D"), H("3A2838"), H("F8EDF2"), H("B89AA8"), H("FFFFFF"), "11422142913"

-- Bộ âm thanh phong cách Kawaii
local sOpen = Instance.new("Sound", sg)
sOpen.SoundId = "rbxassetid://6042053626"
sOpen.Volume = 0.7

local sClick = Instance.new("Sound", sg)
sClick.SoundId = "rbxassetid://6895079853"
sClick.Volume = 0.75

local sHover = Instance.new("Sound", sg)
sHover.SoundId = "rbxassetid://7148585764"
sHover.Volume = 0.25

local function playSnd(snd, pitch)
    snd.PlaybackSpeed = pitch or 1
    snd:Play()
end

local function tw(o, p, t, st, dr)
    local x = TS:Create(o, TweenInfo.new(t or 0.18, st or Enum.EasingStyle.Exponential, dr or Enum.EasingDirection.Out), p)
    x:Play()
    return x
end

local function ui(c, p, par, r, st, sc, tr)
    local o = Instance.new(c, par)
    for k, v in pairs(p) do o[k] = v end
    if r then Instance.new("UICorner", o).CornerRadius = UDim.new(0, r) end
    local s = st and Instance.new("UIStroke", o)
    if s then
        s.Thickness = 1.2
        s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        s.Color = sc or cAccD
        s.Transparency = tr or 0
    end
    return o, s
end

-- Kéo thả giao diện mượt mà
local function drag(obj, hdl)
    hdl = hdl or obj
    local drg, dIn, dSt, sPos = false, nil, nil, nil
    hdl.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drg = true
            dSt = i.Position
            sPos = obj.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then drg = false end
            end)
        end
    end)
    hdl.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then dIn = i end
    end)
    UIS.InputChanged:Connect(function(i)
        if i == dIn and drg then
            local d = i.Position - dSt
            obj.Position = U(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
        end
    end)
end

-- Hiệu ứng nhấn & lướt nút hỗ trợ cả Mobile và PC mượt mà
local function fx(b, st, baseC, hovC)
    local s = Instance.new("UIScale", b)
    b.MouseEnter:Connect(function()
        playSnd(sHover, 1.4)
        if hovC then tw(b, {BackgroundColor3 = hovC}, 0.14) end
        if st then tw(st, {Color = cAcc}, 0.14) end
    end)
    b.MouseLeave:Connect(function()
        tw(s, {Scale = 1}, 0.16)
        if baseC then tw(b, {BackgroundColor3 = baseC}, 0.14) end
        if st then tw(st, {Color = cAccD}, 0.16) end
    end)
    b.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            tw(s, {Scale = 0.92}, 0.08, Enum.EasingStyle.Quad)
            if st then tw(st, {Color = cAcc}, 0.08) end
        end
    end)
    b.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            tw(s, {Scale = 1}, 0.24, Enum.EasingStyle.Back)
            if st then tw(st, {Color = cAccD}, 0.18) end
        end
    end)
end

-- Nút mở nhanh thu gọn
local open, openS = ui("TextButton", {Size = U(0, 44, 0, 44), Position = U(0, 18, 0, 95), BackgroundColor3 = cBg, BackgroundTransparency = 0.25, TextColor3 = cAcc, Text = "NK", TextSize = 16, Font = F, AutoButtonColor = false, ZIndex = 10}, sg, 13, true, cAcc)
local bowO = ui("TextLabel", {Size = U(0, 20, 0, 20), Position = U(1, -12, 0, -8), BackgroundTransparency = 1, Text = "🎀", TextSize = 16, Rotation = 18, ZIndex = 12}, open)
drag(open)
fx(open, openS, cBg, cCard)

-- Khung chính gọn gàng
local main, mainS = ui("Frame", {Size = U(0, 390, 0, 238), Position = U(0.5, -195, 0.5, -119), BackgroundColor3 = cBg, BackgroundTransparency = 0.42, ZIndex = 2}, sg, 16, true, cAcc, 0.15)
local bgImg = ui("ImageLabel", {Size = U(1, 0, 1, 0), BackgroundTransparency = 1, Image = "rbxassetid://" .. bgId, ImageTransparency = 0.85, ScaleType = Enum.ScaleType.Crop, ZIndex = 2}, main, 16)
local bowL = ui("TextLabel", {Size = U(0, 26, 0, 26), Position = U(0, -9, 0, -9), BackgroundTransparency = 1, Text = "🎀", TextSize = 20, Rotation = -20, ZIndex = 12}, main)
local bowR = ui("TextLabel", {Size = U(0, 26, 0, 26), Position = U(1, -17, 0, -9), BackgroundTransparency = 1, Text = "🎀", TextSize = 20, Rotation = 20, ZIndex = 12}, main)
local mSc = Instance.new("UIScale", main)

-- Biểu tượng NK mini di chuyển ở góc dưới bên trái menu
local nkMove = ui("Frame", {
    Size = U(0, 44, 0, 18),
    Position = U(0, 10, 1, -22),
    BackgroundColor3 = cCard,
    BackgroundTransparency = 0.25,
    ZIndex = 12
}, main, 6, true, cAcc, 0.25)

local nkMoveLbl = ui("TextLabel", {
    Size = U(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = "🎀 NK",
    TextColor3 = cAcc,
    TextSize = 11.5,
    Font = F,
    ZIndex = 13
}, nkMove)

TS:Create(nkMove, TweenInfo.new(2.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    Position = U(0, 185, 1, -22)
}):Play()

-- Chữ kawaii cố định ở góc dưới bên phải menu
local kwLbl = ui("TextLabel", {
    Size = U(0, 100, 0, 18),
    Position = U(1, -110, 1, -22),
    BackgroundTransparency = 1,
    Text = "✨ kawaii ✨",
    TextColor3 = cAcc,
    TextXAlignment = Enum.TextXAlignment.Right,
    TextSize = 12,
    Font = F,
    ZIndex = 12
}, main)

-- Thanh tiêu đề
local hdr = ui("Frame", {Size = U(1, -16, 0, 34), Position = U(0, 8, 0, 8), BackgroundColor3 = cCard, BackgroundTransparency = 0.35, ZIndex = 4}, main, 10, true, cAccD, 0.2)
drag(main, hdr)
local g1 = Instance.new("UIGradient", hdr)
g1.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, H("FFFFFF")), ColorSequenceKeypoint.new(0.5, H("E6C8D6")), ColorSequenceKeypoint.new(1, H("FFFFFF"))})
g1.Offset = Vector2.new(-1, 0)
TS:Create(g1, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Offset = Vector2.new(1, 0)}):Play()
TS:Create(openS, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.5}):Play()

local title = ui("TextLabel", {Size = U(0, 165, 1, 0), Position = U(0, 10, 0, 0), BackgroundTransparency = 1, TextColor3 = cTxt, Text = "🎀 NGUYENKIET <font color='#FF5C9D'>v1.5</font>", RichText = true, TextXAlignment = Enum.TextXAlignment.Left, TextSize = 14, Font = F, ZIndex = 5}, hdr)
local stat = ui("TextLabel", {Size = U(0, 150, 0, 22), Position = U(1, -180, 0.5, -11), BackgroundColor3 = cBg, BackgroundTransparency = 0.4, TextColor3 = cSub, Text = "60 FPS • 0, 0, 0", TextSize = 11, Font = Enum.Font.Code, ZIndex = 5}, hdr, 7, true, cAccD, 0.2)
local cls, clsS = ui("TextButton", {Size = U(0, 22, 0, 22), Position = U(1, -26, 0.5, -11), BackgroundColor3 = cBg, BackgroundTransparency = 0.35, TextColor3 = cAcc, Text = "×", TextSize = 17, Font = F, AutoButtonColor = false, ZIndex = 6}, hdr, 7, true, cAccD, 0.2)
fx(cls, clsS, cBg, cAccD)

-- Đóng/mở bảng chính mượt mà
local isO, tapPos, animId = true, nil, 0
local function toggleUI(state)
    if isO == state then return end
    isO = state
    animId = animId + 1
    local curId = animId
    if isO then
        playSnd(sOpen, 1.15)
        main.Visible = true
        mSc.Scale = 0.88
        main.BackgroundTransparency = 0.92
        bgImg.ImageTransparency = 0.98
        tw(mSc, {Scale = 1}, 0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        tw(main, {BackgroundTransparency = 0.42}, 0.22, Enum.EasingStyle.Exponential)
        tw(bgImg, {ImageTransparency = 0.85}, 0.22, Enum.EasingStyle.Exponential)
    else
        playSnd(sOpen, 0.9)
        tw(main, {BackgroundTransparency = 1}, 0.18, Enum.EasingStyle.Exponential)
        tw(bgImg, {ImageTransparency = 1}, 0.18, Enum.EasingStyle.Exponential)
        tw(mSc, {Scale = 0.88}, 0.18, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out).Completed:Connect(function()
            if not isO and curId == animId then
                main.Visible = false
            end
        end)
    end
end

playSnd(sOpen, 1.15)

cls.Activated:Connect(function() toggleUI(false) end)
open.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then tapPos = i.Position end
end)
open.InputEnded:Connect(function(i)
    if tapPos and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1) and (i.Position - tapPos).Magnitude < 8 then
        tapPos = nil
        toggleUI(not isO)
    end
end)

-- Khung cuộn
local scr = ui("ScrollingFrame", {Size = U(1, -16, 1, -74), Position = U(0, 8, 0, 48), BackgroundTransparency = 1, ScrollBarImageColor3 = cAcc, ScrollBarThickness = 2.5, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = U(), ZIndex = 4}, main)
local grd = Instance.new("UIGridLayout", scr)
grd.CellSize = U(0.5, -4, 0, 32)
grd.CellPadding = U(0, 7, 0, 7)
grd.SortOrder = Enum.SortOrder.LayoutOrder

local spd, jmp, fov, camSpd = 100, 150, 70, 50
local jOn, fOn, fbOn, lagOn, fcOn, noclipOn = false, false, false, false, false, false

-- Ô chỉnh thông số
local function adj(txt, val, stp, mn, mx, fn)
local f, fs = ui("Frame", {Size = U(1, 0, 1, 0), BackgroundColor3 = cCard, BackgroundTransparency = 0.38, ZIndex = 5}, scr, 9, true, cAccD, 0.2)
local l = ui("TextLabel", {Size = U(1, -56, 1, 0), Position = U(0, 28, 0, 0), BackgroundTransparency = 1, TextColor3 = cTxt, Text = txt .. ": " .. val .. "", RichText = true, TextSize = 12.5, Font = FB, ZIndex = 6}, f)
local m, ms = ui("TextButton", {Size = U(0, 22, 0, 22), Position = U(0, 5, 0.5, -11), BackgroundColor3 = cBg, BackgroundTransparency = 0.35, TextColor3 = cAcc, Text = "−", TextSize = 15, Font = F, AutoButtonColor = false, ZIndex = 7}, f, 7, true, cAccD, 0.2)
local p, ps = ui("TextButton", {Size = U(0, 22, 0, 22), Position = U(1, -27, 0.5, -11), BackgroundColor3 = cBg, BackgroundTransparency = 0.35, TextColor3 = cAcc, Text = "+", TextSize = 15, Font = F, AutoButtonColor = false, ZIndex = 7}, f, 7, true, cAccD, 0.2)
fx(m, ms, cBg, cAccD)
fx(p, ps, cBg, cAccD)
m.Activated:Connect(function()
playSnd(sClick, 1.1)
l.Text = txt .. ": " .. fn(-stp, mn, mx) .. ""
end)
p.Activated:Connect(function()
playSnd(sClick, 1.45)
l.Text = txt .. ": " .. fn(stp, mn, mx) .. ""
end)
end
-- Nút bật/tắt
local function btn(txt, fn)
local st = false
local b, bs = ui("TextButton", {Size = U(1, 0, 1, 0), BackgroundColor3 = cCard, BackgroundTransparency = 0.38, TextColor3 = cTxt, Text = "  " .. txt, TextXAlignment = Enum.TextXAlignment.Left, TextSize = 12.5, Font = FB, AutoButtonColor = false, ZIndex = 6}, scr, 9, true, cAccD, 0.2)
local pill = ui("Frame", {Size = U(0, 30, 0, 16), Position = U(1, -37, 0.5, -8), BackgroundColor3 = cBg, BackgroundTransparency = 0.3, ZIndex = 7}, b, 8, true, cAccD, 0.2)
local knob = ui("Frame", {Size = U(0, 12, 0, 12), Position = U(0, 2, 0.5, -6), BackgroundColor3 = cSub, ZIndex = 8}, pill, 6)
local s = Instance.new("UIScale", b)
b.MouseEnter:Connect(function()
playSnd(sHover, 1.3)
if not st then tw(b, {BackgroundColor3 = cCardH, BackgroundTransparency = 0.24}, 0.14) end
end)
b.MouseLeave:Connect(function()
tw(s, {Scale = 1}, 0.16)
if not st then tw(b, {BackgroundColor3 = cCard, BackgroundTransparency = 0.38}, 0.14) end
end)
b.InputBegan:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
tw(s, {Scale = 0.94}, 0.08, Enum.EasingStyle.Quad)
end
end)
b.InputEnded:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
tw(s, {Scale = 1}, 0.24, Enum.EasingStyle.Back)
end
end)
local function upd()
tw(b, {BackgroundColor3 = st and cAccD or cCard, BackgroundTransparency = st and 0.22 or 0.38, TextColor3 = st and cWht or cTxt}, 0.18, Enum.EasingStyle.Exponential)
tw(bs, {Color = st and cAcc or cAccD}, 0.18)
tw(pill, {BackgroundColor3 = st and cAcc or cBg}, 0.18)
tw(knob, {Position = st and U(0, 16, 0.5, -6) or U(0, 2, 0.5, -6), BackgroundColor3 = st and cWht or cSub}, 0.22, Enum.EasingStyle.Back)
end
local function setState(v)
st = v
upd()
end
b.Activated:Connect(function()
st = fn(setState)
playSnd(sClick, st and 1.38 or 1.05)
upd()
end)
return setState
end
local function restoreCollision()
local c = P.Character
if c then
for _, p in ipairs(c:GetDescendants()) do
if p:IsA("BasePart") and (p.Name == "HumanoidRootPart" or p.Name:find("Torso") or p.Name == "Head") then
p.CanCollide = true
end
end
end
end
-- ==========================================
-- PHẦN 1: CÁC NÚT CHỈNH SỐ (PHÍA TRÊN)
-- ==========================================
adj("Tốc độ bay", spd, 25, 25, 500, function(d, mn, mx)
spd = math.clamp(spd + d, mn, mx)
return spd
end)
adj("Độ cao nhảy", jmp, 25, 50, 500, function(d, mn, mx)
jmp = math.clamp(jmp + d, mn, mx)
local h = P.Character and P.Character:FindFirstChildOfClass("Humanoid")
if jOn and h then
h.UseJumpPower = true
h.JumpPower = jmp
end
return jmp
end)
adj("Góc nhìn (FOV)", fov, 10, 40, 120, function(d, mn, mx)
fov = math.clamp(fov + d, mn, mx)
if workspace.CurrentCamera then
tw(workspace.CurrentCamera, {FieldOfView = fov}, 0.25)
end
return fov
end)
adj("Tốc độ Cam", camSpd, 15, 10, 300, function(d, mn, mx)
camSpd = math.clamp(camSpd + d, mn, mx)
return camSpd
end)
-- ==========================================
-- PHẦN 2: CÁC NÚT ẤN BẬT/TẮT (PHÍA DƯỚI)
-- ==========================================
local origProps = {}
local origShadows, origFog = L.GlobalShadows, L.FogEnd
btn("Giảm Lag (FPS)", function()
lagOn = not lagOn
if lagOn then
origShadows = L.GlobalShadows
origFog = L.FogEnd
L.GlobalShadows = false
L.FogEnd = 9e9
pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("BasePart") then
origProps[v] = {Material = v.Material, CastShadow = v.CastShadow}
v.Material = Enum.Material.SmoothPlastic
v.CastShadow = false
elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
origProps[v] = {Enabled = v.Enabled}
v.Enabled = false
elseif v:IsA("Decal") or v:IsA("Texture") then
origProps[v] = {Transparency = v.Transparency}
v.Transparency = 1
end
end
else
L.GlobalShadows = origShadows
L.FogEnd = origFog
pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
for obj, props in pairs(origProps) do
if obj and obj.Parent then
for k, val in pairs(props) do
pcall(function() obj[k] = val end)
end
end
end
table.clear(origProps)
end
return lagOn
end)
local function applyJump(char)
local h = char and char:FindFirstChildOfClass("Humanoid") or (char and char:WaitForChild("Humanoid", 5))
if h then
h.UseJumpPower = true
h.JumpPower = jOn and jmp or 50
end
end
btn("Nhảy cao", function()
jOn = not jOn
applyJump(P.Character)
return jOn
end)
-- ==========================================
-- CHỨC NĂNG BAY + XUYÊN TƯỜNG (ĐÃ FIX LỖI VẬT LÝ & ĐIỀU KHIỂN)
-- ==========================================
local flyAtt, flyVel, flyRot, fc, nc, setFlyUI
local stopFreecam -- Khai báo trước để gọi tắt nếu đang bật Freecam
local function stopFly()
fOn = false
if fc then fc:Disconnect(); fc = nil end
if nc then nc:Disconnect(); nc = nil end
if flyVel then flyVel:Destroy(); flyVel = nil end
if flyRot then flyRot:Destroy(); flyRot = nil end
if flyAtt then flyAtt:Destroy(); flyAtt = nil end
local c = P.Character
local h = c and c:FindFirstChildOfClass("Humanoid")
local r = c and c:FindFirstChild("HumanoidRootPart")
if r then
r.AssemblyLinearVelocity = V(0, 0, 0)
r.AssemblyAngularVelocity = V(0, 0, 0)
end
if h then
h.AutoRotate = true
h.PlatformStand = false
h:ChangeState(Enum.HumanoidStateType.GettingUp)
end
if not noclipOn then
restoreCollision()
end
if setFlyUI then setFlyUI(false) end
end
setFlyUI = btn("Bay + Xuyên tường", function(setSt)
setFlyUI = setSt
if fOn then stopFly(); return false end
-- Tự động tắt Freecam nếu đang bật để tránh nhân vật bị neo cứng (Anchored)
if fcOn and stopFreecam then stopFreecam() end
local c = P.Character
local h = c and c:FindFirstChildOfClass("Humanoid")
local r = c and c:FindFirstChild("HumanoidRootPart")
if not r or not h or h.Health <= 0 then return false end
fOn = true
r.Anchored = false
h.AutoRotate = false
h:ChangeState(Enum.HumanoidStateType.Physics)
-- Dùng Attachment + LinearVelocity + AlignOrientation chuẩn hệ thống vật lý mới
flyAtt = Instance.new("Attachment", r)
flyVel = Instance.new("LinearVelocity")
flyVel.Attachment0 = flyAtt
flyVel.MaxForce = math.huge
flyVel.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
flyVel.RelativeTo = Enum.ActuatorRelativeTo.World
flyVel.VectorVelocity = V(0, 0, 0)
flyVel.Parent = r
flyRot = Instance.new("AlignOrientation")
flyRot.Attachment0 = flyAtt
flyRot.Mode = Enum.OrientationAlignmentMode.OneAttachment
flyRot.MaxTorque = math.huge
flyRot.Responsiveness = 30
flyRot.CFrame = r.CFrame
flyRot.Parent = r
fc = RS.RenderStepped:Connect(function()
local cam = workspace.CurrentCamera
if not r or not r.Parent or not h or h.Health <= 0 then
stopFly()
return
end
-- Giữ trạng thái vật lý để trọng lực không kéo nhân vật rơi xuống
if h:GetState() ~= Enum.HumanoidStateType.Physics then
h:ChangeState(Enum.HumanoidStateType.Physics)
end
local cf = cam and cam.CFrame or r.CFrame
local lookVec = cf.LookVector
local rightVec = cf.RightVector
local moveDir = V(0, 0, 0)
-- Ưu tiên lấy hướng từ cần gạt/phím di chuyển của Humanoid (hỗ trợ tốt cả Mobile & PC)
local md = h.MoveDirection
if md.Magnitude > 0.01 then
local flatLook = V(lookVec.X, 0, lookVec.Z)
flatLook = flatLook.Magnitude > 0.01 and flatLook.Unit or lookVec
local flatRight = V(rightVec.X, 0, rightVec.Z)
flatRight = flatRight.Magnitude > 0.01 and flatRight.Unit or rightVec
local fwdAmount = md:Dot(flatLook)
local sideAmount = md:Dot(flatRight)
moveDir = (lookVec * fwdAmount) + (rightVec * sideAmount)
end
-- Hỗ trợ thêm phím nâng/hạ độ cao nhanh trên PC (Space / E / LeftControl)
if not UIS:GetFocusedTextBox() then
if UIS:IsKeyDown(Enum.KeyCode.Space) or UIS:IsKeyDown(Enum.KeyCode.E) then
moveDir = moveDir + V(0, 1, 0)
end
if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.Q) then
moveDir = moveDir - V(0, 1, 0)
end
end
if moveDir.Magnitude > 0.01 then
flyVel.VectorVelocity = moveDir.Unit * spd
local flatDir = V(moveDir.X, 0, moveDir.Z)
if flatDir.Magnitude > 0.01 then
flyRot.CFrame = CFrame.lookAt(r.Position, r.Position + flatDir.Unit)
end
else
flyVel.VectorVelocity = V(0, 0, 0)
local camFlat = V(lookVec.X, 0, lookVec.Z)
if camFlat.Magnitude > 0.01 then
flyRot.CFrame = CFrame.lookAt(r.Position, r.Position + camFlat.Unit)
end
end
end)
nc = RS.Stepped:Connect(function()
local char = P.Character
if char then
for _, p in ipairs(char:GetDescendants()) do
if p:IsA("BasePart") then p.CanCollide = false end
end
end
end)
return true
end)
-- ==========================================
-- FREECAM SIÊU MƯỢT (NỘI SUY GÓC XOAY & TỐC ĐỘ)
-- ==========================================
local camPos, targetPos = nil, nil
local camRotX, camRotY, targetRotX, targetRotY = 0, 0, 0, 0
local setFcUI
local fcBeganConn, fcChangedConn, fcEndedConn
local activeTouch, rmbDown = nil, false
local FC_STEP_NAME = "NKFreecamStep"
stopFreecam = function()
fcOn = false
pcall(function() RS:UnbindFromRenderStep(FC_STEP_NAME) end)
if fcBeganConn then fcBeganConn:Disconnect(); fcBeganConn = nil end
if fcChangedConn then fcChangedConn:Disconnect(); fcChangedConn = nil end
if fcEndedConn then fcEndedConn:Disconnect(); fcEndedConn = nil end
activeTouch = nil
rmbDown = false
UIS.MouseBehavior = Enum.MouseBehavior.Default
local cam = workspace.CurrentCamera
local c = P.Character
local h = c and c:FindFirstChildOfClass("Humanoid")
local r = c and c:FindFirstChild("HumanoidRootPart")
if r then r.Anchored = false end
if cam then
cam.CameraType = Enum.CameraType.Custom
if h then cam.CameraSubject = h end
end
if setFcUI then setFcUI(false) end
end
setFcUI = btn("Freecam (Tự do)", function(setSt)
setFcUI = setSt
if fcOn then stopFreecam(); return false end
if fOn then stopFly() end
local cam = workspace.CurrentCamera
local c = P.Character
local h = c and c:FindFirstChildOfClass("Humanoid")
local r = c and c:FindFirstChild("HumanoidRootPart")
if not cam then return false end
fcOn = true
camPos = cam.CFrame.Position
targetPos = camPos
local rx, ry, _ = cam.CFrame:ToEulerAnglesYXZ()
camRotX, camRotY = rx, ry
targetRotX, targetRotY = rx, ry
if r then r.Anchored = true end
fcBeganConn = UIS.InputBegan:Connect(function(inp, gp)
if gp or not fcOn then return end
if inp.UserInputType == Enum.UserInputType.MouseButton2 then
rmbDown = true
UIS.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
elseif inp.UserInputType == Enum.UserInputType.Touch and not activeTouch then
if inp.Position.X > cam.ViewportSize.X * 0.42 then
activeTouch = inp
end
end
end)
fcChangedConn = UIS.InputChanged:Connect(function(inp)
if not fcOn then return end
if inp == activeTouch and inp.UserInputType == Enum.UserInputType.Touch then
local d = inp.Delta
targetRotY = targetRotY - d.X * 0.0055
targetRotX = math.clamp(targetRotX - d.Y * 0.0055, -1.52, 1.52)
elseif rmbDown and inp.UserInputType == Enum.UserInputType.MouseMovement then
local d = inp.Delta
targetRotY = targetRotY - d.X * 0.0042
targetRotX = math.clamp(targetRotX - d.Y * 0.0042, -1.52, 1.52)
end
end)
fcEndedConn = UIS.InputEnded:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton2 then
rmbDown = false
UIS.MouseBehavior = Enum.MouseBehavior.Default
elseif inp == activeTouch then
activeTouch = nil
end
end)
RS:BindToRenderStep(FC_STEP_NAME, Enum.RenderPriority.Camera.Value + 5, function(dt)
if not fcOn then return end
if c and h and h.Health <= 0 then
stopFreecam()
return
end
local rotAlpha = 1 - math.exp(-26 * dt)
camRotX = camRotX + (targetRotX - camRotX) * rotAlpha
camRotY = camRotY + (targetRotY - camRotY) * rotAlpha
local rotCFrame = CFrame.fromEulerAnglesYXZ(camRotX, camRotY, 0)
local lookVec = rotCFrame.LookVector
local rightVec = rotCFrame.RightVector
local move = V(0, 0, 0)
if not UIS:GetFocusedTextBox() then
if UIS:IsKeyDown(Enum.KeyCode.W) or UIS:IsKeyDown(Enum.KeyCode.Up) then move = move + lookVec end
if UIS:IsKeyDown(Enum.KeyCode.S) or UIS:IsKeyDown(Enum.KeyCode.Down) then move = move - lookVec end
if UIS:IsKeyDown(Enum.KeyCode.D) or UIS:IsKeyDown(Enum.KeyCode.Right) then move = move + rightVec end
if UIS:IsKeyDown(Enum.KeyCode.A) or UIS:IsKeyDown(Enum.KeyCode.Left) then move = move - rightVec end
if UIS:IsKeyDown(Enum.KeyCode.E) or UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + V(0, 1, 0) end
if UIS:IsKeyDown(Enum.KeyCode.Q) or UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - V(0, 1, 0) end
end
if move.Magnitude == 0 and h and h.MoveDirection.Magnitude > 0.01 then
local md = h.MoveDirection
local flatLook = V(lookVec.X, 0, lookVec.Z)
flatLook = flatLook.Magnitude > 0.01 and flatLook.Unit or lookVec
local flatRight = V(rightVec.X, 0, rightVec.Z)
flatRight = flatRight.Magnitude > 0.01 and flatRight.Unit or rightVec
local fwdAmount = md:Dot(flatLook)
local sideAmount = md:Dot(flatRight)
move = (lookVec * fwdAmount) + (rightVec * sideAmount)
end
if move.Magnitude > 0.01 then
targetPos = targetPos + (move.Unit * camSpd * dt)
end
local moveAlpha = 1 - math.exp(-18 * dt)
camPos = camPos:Lerp(targetPos, moveAlpha)
cam.CFrame = CFrame.new(camPos) * rotCFrame
end)
return true
end)
local origAmb, origOutAmb = L.Ambient, L.OutdoorAmbient
btn("Sáng bản đồ", function()
fbOn = not fbOn
if fbOn then
origAmb = L.Ambient
origOutAmb = L.OutdoorAmbient
tw(L, {Ambient = Color3.new(1, 1, 1), OutdoorAmbient = Color3.new(1, 1, 1)}, 0.3)
else
tw(L, {Ambient = origAmb, OutdoorAmbient = origOutAmb}, 0.3)
end
return fbOn
end)
local noclipConn
btn("Xuyên tường", function()
noclipOn = not noclipOn
if noclipOn then
noclipConn = RS.Stepped:Connect(function()
local char = P.Character
if char then
for _, p in ipairs(char:GetDescendants()) do
if p:IsA("BasePart") then p.CanCollide = false end
end
end
end)
else
if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
if not fOn then
restoreCollision()
end
end
return noclipOn
end)
local charConn = P.CharacterAdded:Connect(function(newChar)
if fOn then stopFly() end
if fcOn then stopFreecam() end
if jOn then
task.wait(0.2)
applyJump(newChar)
end
end)
local frm, lt = 0, os.clock()
local statConn = RS.RenderStepped:Connect(function()
frm = frm + 1
local now = os.clock()
if now - lt >= 0.5 then
local fpsV = math.round(frm / (now - lt))
frm = 0
lt = now
local r = P.Character and P.Character:FindFirstChild("HumanoidRootPart")
stat.Text = r and string.format("%d FPS • %d,%d,%d", fpsV, r.Position.X, r.Position.Y, r.Position.Z) or (fpsV .. " FPS • ...")
end
end)
_G.NKCleanup = function()
if fOn then stopFly() end
if fcOn then stopFreecam() end
if noclipConn then noclipConn:Disconnect() end
if charConn then charConn:Disconnect() end
if statConn then statConn:Disconnect() end
if sg then sg:Destroy() end
end
