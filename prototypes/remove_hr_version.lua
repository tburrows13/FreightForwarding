-- process_lua.lua
local mlc = require("metalua.compiler").new()

-- Function to check if a table contains 'filename' and 'hr_version' keys
local function has_filename_and_hr_version(table_node)
    if table_node.tag ~= 'Table' then return false end
    local has_filename = false
    local has_hr_version = false
    for _, field in ipairs(table_node) do
        if field.tag == 'Pair' then
            local key = field[1]
            if key.tag == 'String' and key[1] == 'filename' then
                has_filename = true
            elseif key.tag == 'String' and key[1] == 'hr_version' then
                has_hr_version = true
            end
        end
    end
    return has_filename and has_hr_version
end

-- Recursive function to process the AST nodes
local function process_node(node)
    if type(node) ~= 'table' then return end

    -- Check if the node is a table constructor with 'filename' and 'hr_version'
    if has_filename_and_hr_version(node) then
        local hr_version_value = nil
        -- Find the 'hr_version' field
        for _, field in ipairs(node) do
            if field.tag == 'Pair' then
                local key = field[1]
                local value = field[2]
                if key.tag == 'String' and key[1] == 'hr_version' then
                    hr_version_value = value
                    break
                end
            end
        end

        if hr_version_value and hr_version_value.tag == 'Table' then
            -- Replace the current table's fields with those from 'hr_version'
            -- Clear the current table fields
            for i = #node, 1, -1 do
                table.remove(node, i)
            end
            -- Copy fields from 'hr_version' table
            for _, field in ipairs(hr_version_value) do
                table.insert(node, field)
            end
        end
    else
        -- Recurse into child nodes
        for _, child in pairs(node) do
            process_node(child)
        end
    end
end

-- Function to process a single Lua file
local function process_file(file_name)
    local input_file = io.open(file_name, "r")
    if not input_file then
        print("Could not open file: " .. file_name)
        return
    end
    local code = input_file:read("*all")
    input_file:close()

    -- Parse the code into an AST
    local ast = mlc:src_to_ast(code)

    -- Process the AST
    process_node(ast)

    -- Convert the AST back to Lua code
    local new_code = mlc:ast_to_src(ast)

    -- Write the modified code back to the file
    local output_file = io.open(file_name, "w")
    if not output_file then
        print("Could not write to file: " .. file_name)
        return
    end
    output_file:write(new_code)
    output_file:close()

    print("Processed file: " .. file_name)
end

-- Main script execution
local lfs = require("lfs")

for file in lfs.dir(".") do
    if file:match("dredg%.lua$") then
        process_file(file)
    end
end
