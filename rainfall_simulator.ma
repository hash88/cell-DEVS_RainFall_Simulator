#include(rainfall.inc)
[top]
components : rainfall

[rainfall]
type : cell
dim : (10,10,3)
delay : transport
defaultDelayTime : 1
border : nowrapped
initialvalue : 0
initialcellsvalue : rainfall.val

neighbors : rainfall(-1,-1,-1) rainfall(-1,0,-1) rainfall(-1,1,-1)
neighbors : rainfall(0,-1,-1) rainfall(0,0,-1) rainfall(0,1,-1)
neighbors : rainfall(1,-1,-1) rainfall(1,0,-1) rainfall(1,1,-1)
neighbors : rainfall(-1,-1,0) rainfall(-1,0,0) rainfall(-1,1,0)
neighbors : rainfall(0,-1,0) rainfall(0,0,0) rainfall(0,1,0)
neighbors : rainfall(1,-1,0) rainfall(1,0,0) rainfall(1,1,0)

localtransition : nothing-rule
#Zone : terrain { (1,1,1)..(8,8,1) }
Zone : waterflow{ (1,1,2)..(8,8,1) }
Zone : waterlevel { (1,1,3)..(8,8,2) }


[waterflow]

rule : { 

rule : { (-1,-1,0) } 1 { ( ( 1 - ( abs( (0,0,-1) - (-1,-1,-1) ) / #macro( maxI ) ) ) * (-1,-1,1) ) > #macro( threshold ) }
rule : { (0,-1,0) } 1 { ( ( 1 - ( abs( (0,0,-1) - (0,-1,-1) ) / #macro( maxI ) ) ) * (0,-1,1) ) > #macro( threshold ) }
rule : { (1,-1,0) } 1 { ( ( 1 - ( abs( (0,0,-1) - (1,-1,-1) ) / #macro( maxI ) ) ) * (1,-1,1) ) > #macro( threshold ) }
rule : { (-1,0,0) } 1 { ( ( 1 - ( abs( (0,0,-1) - (-1,0,-1) ) / #macro( maxI ) ) ) * (-1,0,1) ) > #macro( threshold ) }
rule : { (1,0,0) } 1 { ( ( 1 - ( abs( (0,0,-1) - (1,0,-1) ) / #macro( maxI ) ) ) * (1,0,1) ) > #macro( threshold ) }
rule : { (-1,1,0) } 1 { ( ( 1 - ( abs( (0,0,-1) - (-1,1,-1) ) / #macro( maxI ) ) ) * (-1,1,1) ) > #macro( threshold ) }
rule : { (0,1,0) } 1 { ( ( 1 - ( abs( (0,0,-1) - (0,1,-1) ) / #macro( maxI ) ) ) * (0,1,1) ) > #macro( threshold ) }
rule : { (1,1,0) } 1 { ( ( 1 - ( abs( (0,0,-1) - (1,1,-1) ) / #macro( maxI ) ) ) * (1,1,1) ) > #macro( threshold ) }
rule : { (0,0,0) } 1 { t }

[waterlevel]
rule : { ( 1 - ( abs( (0,0,-2) - (-1,-1,-2) ) / #macro( maxI ) ) ) * (-1,-1,0) } 1 { ( ( 1 - ( abs( (0,0,-2) - (-1,-1,-2) ) / #macro( maxI ) ) ) * (-1,-1,0) ) > #macro( threshold ) }
rule : { ( 1 - ( abs( (0,0,-2) - (0,-1,-2) ) / #macro( maxI ) ) ) * (0,-1,0) } 1 { ( ( 1 - ( abs( (0,0,-2) - (0,-1,-2) ) / #macro( maxI ) ) ) * (0,-1,0) ) > #macro( threshold ) }
rule : { ( 1 - ( abs( (0,0,-2) - (1,-1,-2) ) / #macro( maxI ) ) ) * (1,-1,0) } 1 { ( ( 1 - ( abs( (0,0,-2) - (1,-1,-2) ) / #macro( maxI ) ) ) * (1,-1,0) ) > #macro( threshold ) }
rule : { ( 1 - ( abs( (0,0,-2) - (-1,0,-2) ) / #macro( maxI ) ) ) * (-1,0,0) } 1 { ( ( 1 - ( abs( (0,0,-2) - (-1,0,-2) ) / #macro( maxI ) ) ) * (-1,0,0) ) > #macro( threshold ) }
rule : { ( 1 - ( abs( (0,0,-2) - (1,0,-2) ) / #macro( maxI ) ) ) * (1,0,0) } 1 { ( ( 1 - ( abs( (0,0,-2) - (1,0,-2) ) / #macro( maxI ) ) ) * (1,0,0) ) > #macro( threshold ) }
rule : { ( 1 - ( abs( (0,0,-2) - (-1,1,-2) ) / #macro( maxI ) ) ) * (-1,1,0) } 1 { ( ( 1 - ( abs( (0,0,-2) - (-1,1,-2) ) / #macro( maxI ) ) ) * (-1,1,0) ) > #macro( threshold ) }
rule : { ( 1 - ( abs( (0,0,-2) - (0,1,-2) ) / #macro( maxI ) ) ) * (0,1,0) } 1 { ( ( 1 - ( abs( (0,0,-2) - (0,1,-2) ) / #macro( maxI ) ) ) * (0,1,0) ) > #macro( threshold ) }
rule : { ( 1 - ( abs( (0,0,-2) - (1,1,-2) ) / #macro( maxI ) ) ) * (1,1,0) } 1 { ( ( 1 - ( abs( (0,0,-2) - (1,1,-2) ) / #macro( maxI ) ) ) * (1,1,0) ) > #macro( threshold ) }
rule : { (0,0,0) } 1 {t}

[nothing-rule]
rule : { (0,0,0) } 1 {t}
