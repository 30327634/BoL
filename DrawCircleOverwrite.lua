function _G.DrawCircle(x, y, z, radius, col)
		local vPos1 = Vector(x, y, z)
		local vPos2 = Vector(cameraPos.x, cameraPos.y, cameraPos.z)
		local tPos = vPos1 - (vPos1 - vPos2):normalized() * radius
		local sPos = WorldToScreen(D3DXVECTOR3(tPos.x, tPos.y, tPos.z))
		if OnScreen({ x = sPos.x, y = sPos.y }, { x = sPos.x, y = sPos.y }) then
			quality = 2 * math.pi / math.floor(radius / 10)
			local points = {}
			for theta = 0, 2 * math.pi + quality, quality do
				local c = WorldToScreen(D3DXVECTOR3(x + radius * math.sin(theta), y, z + radius * math.cos(theta)))
				points[#points + 1] = D3DXVECTOR2(c.x, c.y)
			end
			DrawLines2(points, width or 1, color or 4294967295)
		end
end
