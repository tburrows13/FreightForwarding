--[[ >>>eNpjZGBksGYAgwY7BoYDDlwsyfmJOUCuPRA7AEXsuZLzCwpSi
3Tzi1KRhTmTi0pTUnXzM1EVp+al5lbqJiUWAxU32MMwR2ZRfh66C
Rw5qYkp6IKsxSX5eSgiPCWZJYl5maW5GEpLilJTi5Gt4S4twqqSg
fHwKkWbhhY5BhD+X8+g8P8/CANZD4BqQJiBsQFsCiNQDAoYZZPz8
0qK8nN0i1NLSjLz0q1y8zOLS0qLUq2SMhOLOQz0jAxAgDU5JzMtj
YFBwRGInUCmMDIyVousc39YNcWeEWKWngOU8QEqciAJJuIJY/g54
JRSgTFMkMwxBoPPSAyIpSVAK6CqOBwQDIhkC0iSkbH37dYF349ds
GP8s/LjJd+kBHtGQ1eRdx+M1tkBJdlBnmeCE7NmgsBOmFcYYGY+s
IdK3bRnPHsGBN7YM7KCdIiACAcLIHHAm5mBUYAPyFrQAyQUZBhgT
rODGSPiwJgGBt9gPnkMY1y2R/cHMCBsQIbLgYgTIAJsIdxljBCmQ
78Do4M8TFYSoQSo34gB2Q0pCB+ehFl7GMl+NIdgRgSyP9BEVBywR
AMXyMIUOPGCGe4aYHheYIfxHOY7MDKDGCBVX4BiEB4kRUOMgtACD
uDghslC0gYDY2ScBwB22bRb<<<

>>>eNpjZGBksGYAgtWrVtkxMDQ4cLEk5yfmAAXsgdiBgeGAPVdyf
kFBapFuflEqsjBnclFpSqpufiaq4tS81NxK3aTEYqDiBnsY5sgsy
s9DN4EjJzUxBV2QtbgkPw9FhKcksyQxL7M0F0NpSVFqajGyNdylR
VhVMjAeXqVo09AixwDC/+sZFP7/B2Eg6wFQDQgzMDaATWEEikEBo
2xyfl5JUX6ObnFqSUlmXrpVbn5mcUlpUapVUmZiMYeBnpEBCLAm5
2SmpTEwKDgCsRPIFEZGxmqRde4Pq6bYM0LM0nOAMj5ARQ4kwUQ8Y
Qw/B5xSKjCGCZI5xmDwGYkBsbQEaAVUFYcDggGRbAFJMjL2vt264
PuxC3aMf1Z+vOSblGDPaOgq8u6D0To7oCQ7yPNMcGLWTBDYCfMKA
8zMB/ZQqZv2jGfPgMAbe0ZWkA4REOFgASQOeDMzMArwAVkLeoCEg
gwDzGl2MGNEHBjTwOAbzCePYYzL9uj+AAaEDchwORBxAkSALYS7j
BHCdOh3YHSQh8lKIpQA9RsxILshBeHDkzBrDyPZj+YQzIhA9geai
IoDlmjgAlmYAideMMNdAwzPC+wwnsN8B0ZmEAOk6gtQDMKDpGiIU
RBawAEc3DBZSNpg4J5mUAgAPD+13A==<<<]]

script.on_event(defines.events.on_player_created, function(event)
  game.get_player(event.player_index).remove_item{name = "jag-seeds", count = 1}
end)

script.on_event(defines.events.on_cutscene_cancelled, function(event)
  game.get_player(event.player_index).remove_item{name = "jag-seeds", count = 1}
end)


script.on_nth_tick(600,
  function()
    if game.tick ~= 0 then
      if game.default_map_gen_settings.property_expression_names.elevation ~= "IS_0_17-islands+continents" then
        game.print({"x-mod.warn-nondefault-mapgen", {"map-gen-preset-name.x-default"}})
      end
      script.on_nth_tick(600, nil)
    end
  end
)
