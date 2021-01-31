local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local assert = _tl_compat and _tl_compat.assert or assert; local io = _tl_compat and _tl_compat.io or io; local os = _tl_compat and _tl_compat.os or os; local pairs = _tl_compat and _tl_compat.pairs or pairs; local pcall = _tl_compat and _tl_compat.pcall or pcall; local table = _tl_compat and _tl_compat.table or table
local json = require("dkjson")
local util = {}

function util.keys(t)
   local ks = {}
   for k in pairs(t) do
      table.insert(ks, k)
   end
   return ks
end

function util.map(t, fn)
   local new = {}
   for k, v in pairs(t) do
      new[k] = fn(v)
   end
   return new
end

function util.imap(t, fn, start, finish)
   local new = {}
   for i = start or 1, finish or #t do
      new[i] = fn(t[i])
   end
   return new
end

local req = require
local _inspect
do
   local ok, actual_inspect = pcall(req, "inspect")
   if ok then
      _inspect = actual_inspect
   else
      _inspect = tostring
   end
end

local function inspect(x)

   return type(x) == "string" and
   x or
   _inspect(x)
end

local logfile = "teal-language-server.log"
function util.log(...)
   local fh = assert(io.open(logfile, "a"))
   fh:write("[", os.date("%X"), "] ")
   for i = 1, select("#", ...) do
      local x = select(i, ...)
      fh:write(inspect(x))
   end
   fh:write("\n")
   fh:close()
end

function util.assert(val, msg)
   if not val then
      util.log("ASSERTION FAILED: ", msg)
      error(msg)
   end
   return val
end

function util.json_nullable(x)
   if x == nil then
      return json.null
   end
   return x
end

return util