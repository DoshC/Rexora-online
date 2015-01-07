function onStartup()
 
        local Dia = os.date("%A")
        if Dia == "Monday" then
                RashidPos = {x = 32207, y = 31155, z = 7}
        elseif Dia == "Tuesday" then -- Martes
                RashidPos = {x = 32207, y = 31155, z = 7} 
        elseif Dia == "Wednesday" then -- Miercoles
                RashidPos = {x = 32577, y = 32753, z = 7} 
        elseif Dia == "Thursday" then -- Jueves
                RashidPos = {x = 32300, y = 32837, z = 7} 
        elseif Dia == "Friday" then -- Viernes
                RashidPos = {x = 33235, y = 32483, z = 7} 
        elseif Dia == "Saturday" then -- Sabado
                RashidPos = {x = 33166, y = 31810, z = 6} 
        elseif Dia == "Sunday" then
                RashidPos = {x = 32328, y = 31782, z = 6} 
        end
 
        doCreateNpc("Rashid", RashidPos)
 
end