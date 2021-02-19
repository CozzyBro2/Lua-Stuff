local storeService = game:GetService("DataStoreService")

local Get = function(self)
	local status, result = xpcall(self.Store.UpdateAsync, self.OnError, self.Store, self.Key, function(gotData)
		gotData = gotData or {
			[1] = os.clock() - self.SessionLockTimeout
		}
		
		if self.SessionLockTimeout < os.clock() - gotData[1] then
			gotData[1] = os.clock()
		
			print("allowed"); return gotData
		end
		
		self.Locked = true
	end)
end

return {
	Save = function(self)
		if self.Locked then return warn("locked") end
		
		local dataToSave = self.Data
		dataToSave[1] = 0
		
		self.Store:SetAsync(self.Key, dataToSave)
	end,

	NewStore = function(storeParams)
		local createdStore = {
			Store = storeService:GetDataStore(storeParams.StoreName),
			SessionLockTimeout = storeParams.LockTime or 30,
			OnError = storeParams.OnError or warn,
			Key = storeParams.APIKey,
		}

		createdStore.Data = select(2, Get(createdStore))

		return createdStore
	end
}
