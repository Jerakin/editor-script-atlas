local M = {}

M.name_dialog = editor.ui.component(function(props)
	local name, set_name = editor.ui.use_state("")

	return editor.ui.dialog({
		title = props.title,
		content = editor.ui.vertical({
			padding = editor.ui.PADDING_LARGE,
			children = {
				editor.ui.string_field({
					value = name,
					on_value_changed = set_name
				})
			}
		}),
		buttons = {
			editor.ui.dialog_button({
				text = "Cancel",
				cancel = true
			}),
			editor.ui.dialog_button({
				text = "Add",
				enabled = name ~= "",
				default = true,
				result = name
			}),
		}
	})
end)


M.yes_no_dialog = editor.ui.component(function(props)
	return editor.ui.dialog({
		title = props.title,
		content = editor.ui.vertical({
			padding = editor.ui.PADDING_LARGE,
			children = {
				editor.ui.label({
					text = props.text,
					alignment = editor.ui.ALIGNMENT.CENTER
				})
			}
		}),
		buttons = {
			editor.ui.dialog_button({
				text = "Cancel",
				cancel = true,
				result = false
			}),
			editor.ui.dialog_button({
				text = "Ok",
				default = true,
				result = true
			}),
		}
	})
end)


M.sub_directories_dialog = editor.ui.component(function(props)
	return editor.ui.dialog({
		title = props.title,
		content = editor.ui.vertical({
			padding = editor.ui.PADDING_LARGE,
			children = {
				editor.ui.label({
					text = props.text,
					alignment = editor.ui.ALIGNMENT.CENTER
				})
			}
		}),
		buttons = {
			editor.ui.dialog_button({
				text = "Top most only",
				default = true,
				result = 1
			}),
			editor.ui.dialog_button({
				text = "Folders as animations",
				default = true,
				result = 2
			}),
			editor.ui.dialog_button({
				text = "Flat recursive",
				default = true,
				result = 3
			}),
		}
	})
end)

return M