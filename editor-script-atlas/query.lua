local utils = require "editor-script-atlas.utils"


local M = {}


function M.images_and_atlas_are_selected(opts)
	-- Return true if both images and an atlas are selected, however it only allows for 1 atlas.
	-- if there is multiple we would have to add it to all selected atlases and that sounds,
	-- like it would be easy to mess up for the user.

	local atlas = false
	local png = false
	for _, id in pairs(opts.selection) do
		local path = editor.get(id, "path")
		if utils.ends_with(path, ".atlas") then
			if atlas == true then -- Only allow one atlas selected
				return false
			end
			atlas = true
		elseif utils.ends_with(path, ".png") then
			png = true
		end
	end
	return atlas and png
end


function M.images_but_no_atlas_are_selected(opts)
	-- Return true if images are selected, but no altas.
	local atlas = false
	local png = false
	for _, id in pairs(opts.selection) do
		local path = editor.get(id, "path")
		if utils.ends_with(path, ".png") then
			png = true
		elseif utils.ends_with(path, ".atlas") then
			atlas = true
		end
	end
	return png and not atlas
end


function M.directory_with_images_selected(opts)
	-- Return true an directory that contains images are selected.
	local children = editor.get(opts.selection, "children")
	for i = 1, #children do
		local resource_path = editor.get(children[i], "path")
		if utils.ends_with(resource_path, ".png") then
			return true
		end
	end
end


function M.directory_contains_image_subdirectories(opts)
	-- Return true an directory that contains images are selected.
	local children = editor.get(opts.selection, "children")
	for i = 1, #children do
		local resource_path = editor.get(children[i], "path")
		if editor.resource_attributes(resource_path).is_directory then
			local grand_children = editor.get(opts.selection, "children")
			for j = 1, #grand_children do
				resource_path = editor.get(grand_children[j], "path")
				if editor.resource_attributes(resource_path).is_directory then
					return true
				end
			end
		end
	end
end

return M 