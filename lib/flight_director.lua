------------------------------------------------ 
-- Flight Director 
------------------------------------------------ 

function init_flight_director_lib() 

   local img_fd = img_add("flightdirector.png" , 370 , 285 , 180 , 35) 
   visible(img_fd, false) 
   function show_fd(condition) 
      visible(img_fd, condition) 
   end 
   local function new_fd_data(FDmode, pitch, roll)
      -- flight director mode = 0 is off, 1 is on, 2 is on with autopilot servos 
      if FDmode > 0 then 
         visible(img_fd, true) 
         local dAttX = 460 
         local dAttY = 285 
         local roll = var_cap(roll , -60 , 60) 
         -- Roll horizon 
         img_rotate(img_fd , roll) 
         -- Move horizon pitch 
         local pitch = var_cap(pitch , -55 , 55) 
         move(img_fd, nil, (dAttY - pitch * 6.35) , nil , nil) 
      else 
         visible(img_fd, false) 
      end 
   end 
   xpl_dataref_subscribe(   "sim/cockpit2/autopilot/flight_director_mode", "INT", 
                     "sim/cockpit2/autopilot/flight_director_pitch_deg", "FLOAT", 
                     "sim/cockpit2/autopilot/flight_director_roll", "FLOAT", 
                     new_fd_data) 
end 
