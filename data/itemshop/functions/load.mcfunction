scoreboard objectives add test_command trigger
scoreboard objectives add objd_join dummy
tag @a add OP
execute as @a[scores={objd_join=1..}] run tag @s add OP
execute as @a[scores={objd_join=1..}] run scoreboard players set @s objd_join 0
scoreboard players set @a test_command 0
################################################
execute as @a[tag=perms.OP,scores={test_command=1..}] at @s run function itemshop:customcmd/customcmd1
################################################
execute as @a[tag=perms.OP,scores={test_command=1..}] at @s run function itemshop:customcmd/customcmd1
################################################
execute as @a[tag=OP,scores={test_command=1..}] at @s run function itemshop:customcmd/customcmd1
################################################
execute as @a[tag=perms.OP,scores={test_command=1..}] at @s run function itemshop:customcmd/customcmd1
################################################
execute as @a[tag=perms.OP,scores={test_command=1..}] at @s run function itemshop:customcmd/customcmd1
################################################
execute as @a[scores={test_command=1..}] at @s run tellraw @s [{"text":"Sorry, you don't have enough permissions.","color":"red"}]
execute as @a[scores={test_command=1..}] at @s run scoreboard players set @s test_command 0
################################################
execute as @a run scoreboard players enable @s test_command
setblock 0 64 0 minecraft:oak_sign{Text2:"{\"text\":\"test\",\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/say test\"}}"}
tellraw @a [{"text":"[CONSOLE] ","color":"dark_aqua"},{"text":"itemshop loaded."}]
