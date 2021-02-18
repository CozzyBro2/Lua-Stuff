
local storeService = game:GetService("DataStoreService")

local Get = function(self)
	local status, result = xpcall(self.Store.UpdateAsync, self.OnError, self.Store, self.Key, function(gotData)
		if gotData then
			if os.clock() - gotData[1] < self.LockTime then
				gotData.S[1] = os.clock()
			end
			
			return gotData
		end
		
		gotData = {}
	end)
end

return {
	Save = function(self)
		if self.Locked then return end
		
		self.Store:SetAsync(self.Key, self.Data) 
	end,
	
	NewStore = function(storeParams)
		local createdStore = {
			Store = storeService:GetDataStore(storeParams.StoreName),
			SessionLockTimeout = storeParams.LockTime or 30,
			OnError = storeParams.OnError or warn,
			Key = storeParams.APIKey,
		}
		
		createdStore.Data = Get(createdStore)
		
		return createdStore
	end
}
