local games = {
  [72515936648142] = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hassan1889hassin1988-blip/cautious-octo-journey/refs/heads/main/Dolly's%20factory.lua"))()
    end,
[76069420360298] = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/hassan1889hassin1988-blip/cautious-octo-journey/refs/heads/main/Sugary%20District.lua"))()
  end,
    [16552821455] = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/hassan1889hassin1988-blip/cautious-octo-journey/refs/heads/main/Dandy's%20world.lua"))()
      end,
    [107717448640907] = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/hassan1889hassin1988-blip/cautious-octo-journey/refs/heads/main/Night%20of%20domations.lua"))()
      end,
    [122845430206222] = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/hassan1889hassin1988-blip/cautious-octo-journey/refs/heads/main/Twilight%20zone.lua"))()
      end,
    [100519426937560] = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/hassan1889hassin1988-blip/cautious-octo-journey/refs/heads/main/The%20hybrid%20cafe.lua"))()
      end,
  [109192267964542] = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hassan1889hassin1988-blip/cautious-octo-journey/refs/heads/main/Toons%20universe.lua"))()
    end,
  [104522435597696] = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hassan1889hassin1988-blip/cautious-octo-journey/refs/heads/main/Animal%20hospital.lua"))()
    end
}

if games[game.PlaceId] then
    games[game.PlaceId]()
else
    warn("Game not supported")
end