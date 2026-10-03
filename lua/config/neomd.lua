local map = vim.keymap.set

local state = {
    buf = nil,
    win = nil,
    prev_win = nil,
}

local function alive()
    return state.buf ~= nil and vim.api.nvim_buf_is_valid(state.buf)
end

local function float_opts()
    local avail_w = vim.o.columns
    local avail_h = vim.o.lines - vim.o.cmdheight

    local box_w = math.max(math.min(math.floor(avail_w * 0.9), avail_w), math.min(42, avail_w), 3)
    local box_h = math.max(math.min(math.floor(avail_h * 0.9), avail_h), math.min(12, avail_h), 3)

    return {
        relative = "editor",
        width = box_w - 2,
        height = box_h - 2,
        row = math.floor((avail_h - box_h) / 2),
        col = math.floor((avail_w - box_w) / 2),
        style = "minimal",
        border = "single",
        focusable = true,
    }
end

local function focus(win)
    if vim.api.nvim_get_current_win() ~= win then
        state.prev_win = vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(win)
    end
    vim.cmd("startinsert")
end

local function hide(win)
    if vim.api.nvim_get_current_buf() == state.buf then
        vim.cmd("stopinsert")
    end
    if #vim.api.nvim_list_wins() > 1 and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
    end
    local prev = state.prev_win
    if prev and prev ~= win and vim.api.nvim_win_is_valid(prev) then
        vim.api.nvim_set_current_win(prev)
    end
end

local function cleanup(buf, win)
    if state.buf == buf then
        state.buf = nil
        state.win = nil
    end
    if vim.api.nvim_get_current_buf() == buf then
        vim.cmd("stopinsert")
    end
    if #vim.api.nvim_list_wins() > 1
        and vim.api.nvim_win_is_valid(win)
        and vim.api.nvim_win_get_buf(win) == buf
    then
        vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
    end
end

local function show()
    local prev = vim.api.nvim_get_current_win()
    local win = vim.api.nvim_open_win(state.buf, true, float_opts())

    state.win = win
    state.prev_win = prev
    vim.cmd("startinsert")
end

local function open()
    local prev = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, float_opts())

    state.buf = buf
    state.win = win
    state.prev_win = prev

    vim.fn.termopen({ "neomd" }, {
        on_exit = function()
            vim.schedule(function()
                cleanup(buf, win)
            end)
        end,
    })

    vim.cmd("startinsert")
end

local function toggle()
    if not alive() then
        open()
        return
    end

    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == state.buf then
            if win == vim.api.nvim_get_current_win() then
                hide(win)
            else
                focus(win)
            end
            return
        end
    end

    show()
end

map("n", "<leader>ms", toggle, {
    desc = "Toggle neomd",
    silent = true,
})
