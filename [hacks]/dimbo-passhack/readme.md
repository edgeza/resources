To Use:

```lua
TriggerEvent("DimboPassHack:StartHack", difficulty, cb)

TriggerEvent("DimboPassHack:StartHack", 5, function(passed)
    if passed then
        print("PASSED")
    else
        print("FAILED")
    end
end)
```

- Difficulty can be 1-10 (1 being the easiest and 10 being super hard, if not impossible)
    - You can add more difficulties in `ui/ui.js` - This will be cleaned up in a future version.
    
- You can change the speed of the progress bar in `ui/ui.js` by changing the `ProgressSpeed` variable.
    - This will automatically scale with difficulty in a future version.
