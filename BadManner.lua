function OnRecvPacket(p)
	if p.header == 200 then
		if p:DecodeF() == myHero.networkID then
			local p = CLoLPacket(0x69)
			p.vTable = 0xDD9364
			p:EncodeF(myHero.networkID)
			p:Encode4(0x85858585)
			p:Encode4(0xEBA00664)
			SendPacket(p)
		end
	end
end