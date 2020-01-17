totalGuld = 0
amountAccepts = 0
standardTier = {}
midTier = {}
highTier = {}

function sortTip ()
	amountAccepts = amountAccepts + 1
	
	if amountAccepts ~= 2 then
		return
	end
	
	tip = GetTargetTradeMoney() 
	tipInG = (tip/10000)
	totalGuld = totalGuld + tipInG
	print("Tip: "..tipInG.."")
	print("Total: " ..totalGuld.."")

	if tipInG >= 0 and tipInG <= 2 then
		   table.insert(standardTier, tipInG)
	elseif tipInG > 2 and tipInG <= 5 then
		 table.insert(midTier, tipInG)
	elseif tipInG > 5 then
		table.insert(highTier, tipInG)
	end
	
	amountAccepts = 0
end

function GetAverage(arrayet)
	local sum = 0
	local ave = 0
	local elements = 0
	 
	for k,v in pairs( arrayet ) do
		sum = sum + v
		elements = elements + 1
	end
	
	ave = sum / elements
	return ave;
end

osteframe = CreateFrame("Frame")
osteframe:SetScript("OnEvent", sortTip)
osteframe:RegisterEvent("TRADE_ACCEPT_UPDATE")
osteframe:RegisterEvent("PLAYER_LOGOUT")

function osteframe:OnEvent(event)
	if event == "PLAYER_LOGOUT" then
	totalGuldSession = totalGuldSession + totalGuld
	end
end

function MessageAverage()
	if UnitExists("target") then
	SendChatMessage("Average tip for standard-tier enchants is "..GetAverage(standardTier).."" , "WHISPER", "Common", UnitName("target"));
	SendChatMessage("Average tip for medium-tier enchants is "..GetAverage(midTier).."" , "WHISPER", "Common", UnitName("target"));
	SendChatMessage("Average tip for epic-tier enchants is "..GetAverage(highTier).."" , "WHISPER", "Common", UnitName("target"));
	else 	
	SendChatMessage("Average tip for standard-tier enchants is "..GetAverage(standardTier).."" , "PARTY", "Common");
	SendChatMessage("Average tip for medium-tier enchants is "..GetAverage(midTier).."" , "PARTY", "Common");
	SendChatMessage("Average tip for epic-tier enchants is "..GetAverage(highTier).."" , "PARTY", "Common");
	end
end

SetBindingMacro('f7', "MessageAverage")