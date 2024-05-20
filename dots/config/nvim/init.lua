local function get_os()
    if jit and jit.os == "Linux" then
        return "linux"
    elseif jit and jit.os == "OSX" then
        return "mac"
    elseif vim.fn.has("win32") == 1 then
        local uname_result = vim.fn.system('uname -r')
        if uname_result:match("Microsoft") then
            return "wsl"
        else
            return "windows"
        end
    else
        return "unknown"
    end
end

vim.g.os = get_os()

if vim.g.os == 'windows' then
    vim.o.shell = vim.fn.executable('pwsh') and 'pwsh' or 'powershell'
    vim.o.shellcmdflag =
        '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();'
    vim.o.shellredir = [[2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode]]
    vim.o.shellpipe = [[2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode]]
    vim.o.shellquote = ''
    vim.o.shellxquote = ''
end

if vim.g.os == 'linux' then
  vim.g.python3_host_prog = "/home/user/.local/nvim_venv/bin/python3"
end

-- vim.loader = false
if vim.loader then
    vim.loader.enable()
    vim.schedule(function()
        vim.notify("nvim loader is enabled")
    end)
end

-- require("util.profiler").start()

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        vim.schedule(function()
            -- require("util.profiler").stop()
        end)
    end
})

require("config.lazy")
require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.ft_content")