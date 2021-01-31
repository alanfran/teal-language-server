
local assert = require("luassert")
local document = require("tealls.document")

describe("uri parsing", function()
   it("should return nil on an invalid uri", function()
      local parsed = document.parse_uri("aaaaaaaaa")
      assert.is["nil"](parsed)
   end)

   it("should extract the scheme", function()
      local parsed = document.parse_uri("thescheme:///")
      assert.is_not["nil"](parsed)
      assert.are.same("thescheme", parsed.scheme)
   end)

   it("should extract the authority if present", function()
      local parsed = document.parse_uri("thescheme://the-stuff/")
      assert.is_not["nil"](parsed)
      assert.are.same("the-stuff", parsed.authority)
   end)

   it("should extract the path", function()
      local parsed = document.parse_uri("thescheme:///foo/bar")
      assert.is_not["nil"](parsed)
      assert.are.same("/foo/bar", parsed.path)
   end)

   it("should extract the query if present", function()
      local parsed = document.parse_uri("thescheme:///foo/bar?thing=stuff")
      assert.is_not["nil"](parsed)
      assert.are.same("thing=stuff", parsed.query)
   end)

   it("should extract the fragment if present", function()
      local parsed = document.parse_uri("thescheme:///foo/bar?thing=stuff#aaaa")
      assert.is_not["nil"](parsed)
      assert.are.same("aaaa", parsed.fragment)
   end)
end)