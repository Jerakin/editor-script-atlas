local M = {}


function M.path_segments(path)
	return string.match(path, "(.-)([^\\/]-%.?([^%.\\/]*))$")
end


function M.ends_with(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end


function M.get_atlas(opts)
	-- Get the first selected atlas, because of our `is_active*` doesn't allow multiple
	-- the first one is also the only one.
	for _, id in pairs(opts.selection) do
		local path = editor.get(id, "path")
		if M.ends_with(path, ".atlas") then
			return path
		end
	end
end


return M