pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
game={}

transition=0


function _init()
 --set up the variables
 show_menu()
 items=init_items()
end

function _update()
 game.upd() -- game update
 collect_vase()
end

function _draw()
 game.drw() -- game draw
end
-->8
--menu


function show_menu()
 game.upd=menu_update
 game.drw=menu_draw
end

function menu_update()
 
 if btn(4) then
 --move to next stage
 show_game()
 end
 
end

function menu_draw()
	cls()
	map(0,56,0,0,16,16)
	spr(3,30,40,2,2)
	print('orange 🐱',10,70,9)
	--printh('orange')
	print('press z to start the mayhem',10,80,4)
	print('press x to jump',10,89,4)
end
-->8
--game

purrs=0 --score
map_1=0 --player speed
map_purrs=0 



function show_game()
 game.upd=game_update
 game.drw=game_draw
end


function game_update()
	
		map_1-=1
		map_purrs+=0.5
	    cat_update()
		if map_1<(-128*8) then
			map_1=0
		end
		update_vp()
		--if cat on knitting ball then show_gover
		


end



function game_draw()
	cls()
	map(0,50,map_1,0,128,16)
	map(0,50,map_1+(128*8),0,128,16)
 draw_items()
 draw_balls()
--	print("purrs:"..player.score,2,2,7)
-- player.score+=player.speed
 cat_draw()
--	print("purrs:"..flr(time()),2,117,13)
 print(debug,56,117,13)
	print("purrs:"..purrs+flr(map_purrs),2,117,13)
end
-->8
--cat
cat=3 --cat sprite
cat_dy=0 --fall speed
cat_rise=39 --jump sprites
cat_x=30
cat_y=80
cat_anim_time=0
cat_anim_wait=.08
running=false
jumping=false
landed=false

jumps=2
jumps_made=0

function cat_update()
 if time() - cat_anim_time>
	 cat_anim_wait then
		cat+=2
		cat_anim_time=time()
		
		if cat>7 then
			cat=3
		end
	end
		 --add gravity
 cat_dy+=0.5
 
	 --jump
	if (btnp(5)and
	 jumps_made<jumps) then
	 
	  jumps_made+=1
	  cat_dy-=4
	  sfx(00)
	end
	 
 --move to new position
 cat_y+=cat_dy
 


	--collision detection
	
	local x1=flr((cat_x-map_1)/8)
 local y1=flr(cat_y/8)
 local x2=flr((cat_x+7-map_1)/8)
-- local x3=flr((cat_x+4)/8)
-- local y2=flr((cat_y+8)/8)
 
 local a=fget(mget(x1,y1+52),0)
 local d=fget(mget(x2,y1+52),0)
 
-- local b=fget(mget(x3,y2+52),0)

 if (a or d) then
	 jumps_made=0
	 cat_dy=0
	 cat_y=flr(cat_y/8)*8
	  
 end
 
 if (cat_y>=80 and cat_dy>0) then
  cat_dy=0
  landed=true
 else
  landed=false
 end
 
end


function cat_draw()
	spr(cat,cat_x,cat_y,2,2)


end
-->8
--items


function init_items()
	local items={}
	
	for i=1,40 do 
		local item={}
		 item.type="vase"
			item.x=flr(rnd(128*8*8))
			item.y=96 --why 96? acolo e pozitia in pixeli a podelei
			item.b_spr=33
			item.spr=32
		 item.broken=false
		add(items,item)
	end
	
	for i=1,20 do 
		local item={}
		 item.type="mug"
			item.x=flr(rnd(128*8*8))
			item.y=96
			item.spr=34
		 item.b_spr=35
		 item.broken=false
		add(items,item)
	end
	--ball
	for i=1,50 do  
		local item={}
			item.type="ball"
			item.x=flr(rnd(128*8*8))
			item.y=96
			item.spr=38
		 item.broken=false
		add(items,item)
	end

	
	 	local item={}
			item.type="flowers"
			item.x=37*8
			item.y=(59-50)*8
			item.spr=48
			item.b_spr=49
		 item.broken=false
		add(items,item)
		
			local item={}
			item.type="flowers"
			item.x=64*8
			item.y=(60-50)*8
			item.spr=48
			item.b_spr=49
		 item.broken=false
		add(items,item)
		
	return items
end
--42 e xul pisicii(40 e fix tile-ul 5)
function collect_vase()
	for item in all(items) do
	 
		if (item.x<=42 and item.x>=28)
			and cat_y==item.y-8
			
			and item.broken==false
			then item.broken=true
		printh()
			--	elseif item.x==28 and cat_y+8==item.y 
			--then item.broken=true
		
			if item.type=="vase" then
				purrs+=100
				sfx(01)
			end
		
			if item.type=="mug" then
				purrs+=1000
				sfx(02)
			end
		
			if item.type=="flowers" then
				purrs+=1666
				sfx(01)
			end
			
			--if item.type=="ball" then
			
				--show_gover()
				--sfx(03)
		--	end 
		end
	end
end

function draw_items()
	
	for item in all(items) do
	
		if item.broken then
			spr(item.b_spr, item.x, item.y)
		else 
		 spr(item.spr, item.x, item.y)
		end
	end
end


function update_vp() -- update vase position
	for item in all(items) do
		item.x-=1
	end
end
-->8
--game over
function show_gover()--gover=game over
 game.upd=gover_update
 game.drw=gover_draw
end


function gover_update()
	if btn(5) then
		--move to next stage
		show_menu()
	end
end



function gover_draw()
	cls()
	map(0,56,0,0,16,16)
	spr(72,40,10,4,4)
	print('You failed',10,70,9)
	print('press x to restart the mayhem',10,80,4)
end

function init_ball()
	local balls={}
	
	for i=1,30 do 
		local ball={}
			ball.x=flr(rnd(128*8*8))
			ball.y=96
			ball.sprite=38
		 ball.play=false
		add(balls,ball)
	end
end

function draw_balls()
	for ball in all(balls) do
		spr(ball.sprite, ball.x, ball,y)
	end
end


__gfx__
00000000000000000000999000099990000000000000999000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000990000099990000000000099999000000000000999900000000000000000000000000000000000000000000000000000000000000000
00700700000000000000990009999900000000000999999000000000009999900090009000000000000000000000000000000000000000000000000000000000
00077000090009000000099009990000090000900999990000900900009990000999999000000000000000000000000000000000000000000000000000000000
00077000099099000000099999000000099999909900000009999990099900009999999900000000000000000000000000000000000000000000000000000000
0070070099999990000000999900000099999999900000009999e999099900009999999900000000000000000000000000000000000000000000000000000000
0000000099e9999000000009990000009999e9999000000099999999090000009999e99900000000000000000000000000000000000000000000000000000000
00000000999999900099999909999000999999999999900099999999099900998899999000000000000000000000000000000000000000000000000000000000
00000000099998899999999909999999889999909999999988999990999999999888888000000000000000000000000000000000000000000000000000000000
00000000008888999999999999999999988888009999999998888800999999999999a90000000000000000000000000000000000000000000000000000000000
00000000009a999999999999999999999999a900999999999999a900999999999999990000000000000000000000000000000000000000000000000000000000
00000000009999999999999999999999999999009999999999999900099999999999999000000000000000000000000000000000000000000000000000000000
00000000000999999999999999999999999994000999999999999400099999999999999000000000000000000000000000000000000000000000000000000000
00000000000499999994999909994999999994004999999999999440999999400499999900000000000000000000000000000000000000000000000000000000
00000000000449990044499009944400099944004499900009990440990044400440099900000000000000000000000000000000000000000000000000000000
00000000000440990044099009904400099044004409990009900040900004400440009900000000000000000000000000000000000000000000000000000000
00eeee00000000000000000000000000007770000000000000000000000000000000000000000000000000000009000000090000000000000000000000000000
000ee000000000000000000000000000007070000000000000000000000000000000000009999990999000000999900000099000000000000000000000000000
000ee000000000000000000000000000007070000000000000088880000000000000000099999e99999000099999999000099000000000000000000000000000
00eeee00000000006666600000000000070007000000000000828888000000000000000009999999990000009999e99099999000000000000000000000000000
0eeeeee0000000e06666666000000000072727000700000000882888000000000000999998889998990000009999999099990000000000000000000000000000
0ceccec0000000e066666060000060000772270007700000008882280000000000099999999888a899000000889a990090000000000000000000000000000000
0eeeeee00eeeeeee6666666000066000072227000722270000288882000000000999999999999999990000099888800099990000900900000000000000000000
00eeee000ceeedce66666000cc666660077777002777772788022880000000000999999999999999090009999999900099999000099990000000000000000000
00e0e000000000007777700000000000dddddddddddddddd00000000000000009999999999999990099999999999900099999990099999900000000000000000
0eaeeae0000000007ddd700000000000dddddddddddddddd0000000000000000900999990499990009999999999999009999999988999e900000000000000000
00e5eeae000000007d7d700000000000dd777777dddddddd00000000000000009049999004499000099999999449999099999999988999900000000000000000
0e5e55e00000000077cc700070000000d7777878dddddddd0000000000000000904499000409900000999990004440999999999999a888000000000000000000
00656600000000007ccc70007cc000007d777888dddddddd00000000000000009040990000090000009999999004440099999999999999000000000000000000
006666006000e0ee7ccc70007c7c0000d7777787dddddddd00000000000000009900000000000000000999999900000009994000449999000000000000000000
0066660066000eae7ccc70007ccc7000dd777777dddddddd00000000000000009999000000000000000044009990000000999440004499900000000000000000
00566500566ecce67777700077777cccddd7777ddddddddd00000000000000000999900000000000000004400000000000009944000040990000000000000000
222222222222222222222222dddddddddddddddddddddddd2222222222222222dddddddddddddddddddddddddddddddd00000000000000000000000000000000
eeeeeeeeeeeeeeeeeeee22eedd6ddddddddddddddddddddd2cccccc22cccccc2dddddddddddddddddddddddddddddddd00000000000000000000000000000000
22222e222222e222ee222222d6d6ddddddddddddddddd6dd2cc667c22cccccc2dddddddddddddddddddddddddddddddd00000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeedd6ddddddddddddddddd6d6d2cccccc22cccccc2dddddddddddddddddddddddddddddddd00000000000000000000000000000000
eeeeeee22ee222222ee22222dddddddddd6dddddddddd6dd277cc7722cccc772dddddddddddddddddddddddddddddddd00000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeddddddddd6d6dddddddddddd2766ccc22ccc6662ddddd99ddddddddddddddddd999ddddd00000000000000000000000000000000
ee222222e222222ee2222222dddddddddd6ddddddddddddd2cccccc22cccccc2dddd9999ddddddddddddddd9999ddddd00000000000000000000000000000000
eeeeeee22eeeeeeeeeeeeeeedddddddddddddddddddddddd2222222222222222dddd99999dddddddddddddd99999dddd00000000000000000000000000000000
2333333333333333333333322222222200000000000000000000000000000000dddd99999d9999999999d9999999dddd00000000000000000000000000000000
33555555555555555555553344dddd4400000000000000000000000000000000dddd999999999999999999999999dddd00000000000000000000000000000000
ee55333333333333333355e24dddddd400000000000000000000000000000000dddd999999999999999999999999dddd00000000000000000000000000000000
335335555555555555533533dddd6ddd00000000000000000000000000000000dddd999999999999999999999999dddd00000000000000000000000000000000
2e53355555555555555335eeddd6d6dd00000000000000000000000000000000dddd9999999999999999999999999ddd00000000000000000000000000000000
335533333333333333335533dddd6ddd00000000000000000000000000000000ddd99999999999999999999999999ddd00000000000000000000000000000000
ee55555555555555555555e2dddddddd00000000000000000000000000000000ddd999990999999999999909999999dd00000000000000000000008882800000
333333333333333333333333dddddddd00000000000000000000000000000000dd9999999999999999999999999999dd00000000000000000000888822880000
2222220000022222000000000000000000000000000000000000000000000000dd999999c9999999999999c9999999dd00000000000000000002288828222000
eeeeeee000eeeeee000000000000000000000000000000000000000000000000dd9999999999999ee9999999999999dd00000000000000000008228828282800
2eeeee000000eee2000000000000000000000000000000000000000000000000dd9999999999999ee9999999999999dd00000000000000000022822228282800
222222000000eeee000000000000000000000000000000000000000000000000dd999999c9999999999999c9999999dd00000000000000000882282282822880
eeee000000002222000000000000000000000000000000000000000000000000dd9999999999999999999999999999dd00000000000000000888228222828880
eeeee00000eeeeee000000000000000000000000000000000000000000000000ddd999999999999999999999999999dd00000000000000000888822882228880
2222ee000eeeeee2000000000000000000000000000000000000000000000000ddd99999c999999999999999999999dd00000000000000000088882228222880
eeeee2e000222222000000000000000000000000000000000000000000000000ddd99999999999999999999999999ddd00000000000000000082888822222200
0000000000000000000000000000000000000000000000000000000000000000dddd9999999999999999999999999ddd00000000000000000082288888822800
0000000000000000000000000000000000000000000000000000000000000000dddd9999999999999999999999999ddd00000000000000000008222888888000
0000000000000000000000000000000000000000000000000000000000000000ddddd99999999999999999999999dddd00000000000000000880882288800000
0000000000000000000000000000000000000000000000000000000000000000dddddd999999999999999999999ddddd00000000000000008800000000000000
0000000000000000000000000000000000000000000000000000000000000000dddddd888888888888888888888ddddd00000000000000088000000000000000
0000000000000000000000000000000000000000000000000000000000000000dddddd88888888aaaaa88888888ddddd00000000008888880000000000000000
0000000000000000000000000000000000000000000000000000000000000000ddddddddd88888aaaaa8888888dddddd00000000088000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000dddddddddddddddaaadddddddddddddd00000000880000000000000000000000
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454543434343434343434343434343434343434343434343434343434343434343434344444444444444444444444444444
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454543434343434343434343434343434343434343434343434343434343434343434344444444444444444343434444444
54543434343434343454343434543434343434343434343434343454543454345454343434343434343434444434443434343434343434343434343434343454
54545454545454545454545454545454543434343434343434343434343434343434343434343434345454545454545454545454545454545454545454545454
34343434543434345434545434343434543434343434543434343454545434343454543434343434343444343434343434343434343454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
54545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454
34343434343434343434343434343444343434343444545434544444545454444454343434343434343434343454445444343434344434544444345454343444
54545454444444444444444444445454543434343434343434343434343434443444444444444444445454545454545454545454545454545454545454545454
54343434343434344434345434343434343434345454445444544444444434443434343444345434543434445434545434343454344454545454545434343454
54545454544444444444444454545454544434343434343434444444343434343444343434343434343434343434343434343434343434343434444434343434
54543454344434444444343434343444443454543434343434544444444434343454543434343434543444344434545434343434344454345434343434545454
54545454545454545454544454545454543444444434443434343444444444444434343434343434343434343434343434343434343434343434344444343434
34545434343434344444445444344454443434343454345434343444444434445434545434343434343444345454543434543454344454544434343454345454
44545454545454445454444454545454543434344444443434343434343434343434444444444444343434344444343434343434444434343434344444444434
34345444343434344434343444444454443434343434443434543434545434343434343434343434344434343444543434344444445454544434345434443454
44445454545444445444444444344454444444444444443444444444443434343434343434343434344444444434343434343434443434343434343434343434
34343434344434444444444444444444444444344444444444544434444434443454344454544434343444344444543444344444544444445454543434343454
54445454545454545454445454545454543434343434343434343434343434343434344444343434444434343434343434343434343434343434343434343434
44344444344434344444346464444444544434343434343454444444343444344434344434444434343434343535353535353535343434345434345454545454
54544454545454545454445454545454543434343434343434343434343434343434444444444434343434343434343434343444343434343434343434344444
44344444343444444444547464444444445434545444343454445434343434344434443434544434343444443434343464644434343434344434345454344454
54545454545454545454445464745454543444444434343434443444443434343434443434353534343434746464444434443444343434444454545434344434
44443444343434444444446474444444343535354434343444443444444464647464647454344444343535353454344474644434543434343454346454445454
54545454545454545454445474645454543434343434443434343434444444343434353434444444343444646474444434443434343434444474745444343434
44344434444444444454346464344444444434343434343434443444444444344444343454345434545444445444544464745434543434545434443454343454
54445454545454545454545464644444544444353544343434343434444434343444444434343434444434646474343444444434343434443444343454343434
44433444344434444434544444444444443444444434444434353535443434544444444454353535343434343444443434343454343434343535353535443454
44445454545454544454545454444444444444444444344444443434343435354444344444343434343434343434443535353444444454343444345454343535
35354444343434443444544444444434344444444444444444443444343444543434353534443444344444445444543434343444344434343434343444343454
35353554545454545454545454444444444444444444343434444444353434444434343434344444444444353534444434343434344444444444343434343434
44444434443434343444344434344444444434444444443444443434343444343434343444344444343434343444344454344444343434343444343434343454
54545454545454545454545454545454543434443434343434343434343434443434343444343434343434344434444444443434344434343434343434343444
24142414142414041414141404140515251414142414040424142414051515151515152514140424140414240414241414140515151525042424142424240424
14242424241414142424240424240404242424241424142424242424240515151515151525042424042424042404041404042424241424141424051525242424
__gff__
0000000000000000000000000000000000000000000000000000000000000000020002000202000000000000000000000200020204000000000000000000000001010100000000000000000000000000010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4343434343434543434345444344434345454443434445434443434545434543434443434543434344434543434345434344454345444500454545434343434343454543434545454545454444444443434343434343434343434343434343434343434343434343434345454545454545454545454545454545454545454545
4343454545454544434545434343434343434343444443434543434344454343444543454543444343434343454344444344434344454400434345434343434345454543434344454545444445454545444343434444444444434343434343434343434343434343434345454545454545454545454545454545454545454545
4343454444434343434345444345454445454444444543434344434345454544454444444443444343434343434343434343444544444500454343434343454545454545434345454543454545454544444343434343434343444444434343434343434344444444444445454545454545454545454545454545454545454545
4343434344434443454445454443434343434343454343434545434345434345444543454343444443434545434345434343434545444400454545454545434343454343454543454543454545444444454343434343434343434444444343434344434344434343434345454545454545454545454545454545454545454545
4343444345434343454545434443444443444343434344434345454345434444444343444344434343444543444343434343434445444400454543434344444444454545444545454543434343434343434545434545454543434444434444434343434444434343434345454545454545454545454545454545454545454545
4345444345434343444545434344454345434543434343434345454343454343434343434343434345454343434343454343454545454500454445454343434544434343434544454545434545454345454543434344444343434343454544444444444443434343434345454545454545454545454545454545454545454545
4343444343434345454343434443434343434344434344434344434545454546474344434443434343434443454545454345454544454400454543454343434343434443434544454545454545454544434343434343434443434343434545434343434343434343434343434343434343434545454545454545454545454545
4343434544454343464645454545434343434343434543444545454343444347464445434543454545434344434343454545454544454400454345454647454545454443444746454545454544444445454343434343434343434343464746474745434444444443434343434343434343434545454545454545454545454545
4343434344434543464645444443434543444443444343454445454343434446464444434543434543454344434344464746474646444500454344434746434545454343444647444444444444454545454643434343434343434343434343434343434343434445454543434343434343434545454545454545454545454545
4343454545454345434443434443454344454545454543444445444544434343444443444343434544434343434343434343434444444400454343434343434545434345454545454545454545454545454343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434345454544454345434443454343434545434545454444454543454344454543444343454443444345434345434344434343434300434343454343444545454545454545454545454545454545454343434343434343434343434344444443434343434343434343434343434343434545454545454545454545454545
4443454545454544434345454345454343434543444345444444444445454544444445454543434345434544434343454443434344434300444543434345434545454545454545454545454545454545454343434344444443434343434343434343434343444443434343434343434343434545454545454545454545454545
4242414242424241424242424242424142424242424142424242414242424242414242424242414241424242424241424242424242424200424242424242414242424242414242424242414242414242424242424142424241424242424242414242414242424242424243434343434343434545454545454545454545454545
4444444444444444444444444444444444444444444444444444444444444444444444444444444544444444444444444444444444444400424242424242414242424242414242424242414242414242424242424142424241424242424242414242414242424242424343434343434343434545454545454545454545454545
4444444444444444444444444444444444444444444444444444444444444444444444444444444544444444444444444444444444444444444444444444444443434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343444444444444444443434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343444444444444444443434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343454545454545454543434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343454545454545454543434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343454545454545454543434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343454545454545454543434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343454545454545454543434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343454545454545454543434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343454545454545454543434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343454545454545454543434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343454545454545454543434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343454545454545454543434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343454545454545454543434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434545454545454545454545454545
4545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454343434343454545454545454543434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434444444444444444444444444444
4545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434444444444444444444444444444
4545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434444444343444444444444444444
4545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434444444444444444444444444444
__sfx__
00010000000000000000000000001705000000000000000000000000000c050000000000000000000000000025050000000000000000000000000000000000000505000000000000000000000000000000000000
0010000031050300502f0502f050130000e0000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000000000290502a0501b0502a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000180501e050220502505026050260502305018050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
