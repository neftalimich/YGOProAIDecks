function ZoodiacBeastStartup(deck)
  print("ZoodiacBeast v2.0.0 by neftalimich.")
  deck.Init					= ZoodiacBeastInit
  deck.Card					= ZoodiacBeastCard
  deck.Chain				= ZoodiacBeastChain
  deck.EffectYesNo			= ZoodiacBeastEffectYesNo
  deck.YesNo				= ZoodiacBeastYesNo
  deck.Position				= ZoodiacBeastPosition
  deck.Option				= ZoodiacBeastOption
  deck.BattleCommand		= ZoodiacBeastBattleCommand
  --[[
  deck.Sum 
  deck.Tribute
  deck.BattleCommand
  deck.AttackTarget
  deck.AttackBoost
  deck.Tribute
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  
  deck.ActivateBlacklist    = ZoodiacBeastActivateBlacklist
  deck.SummonBlacklist      = ZoodiacBeastSummonBlacklist
  deck.SetBlacklist			= ZoodiacBeastSetBlacklist
  deck.Unchainable			= ZoodiacBeastUnchainable
  --[[
  deck.RepositionBlacklist
  ]]
  
  deck.PriorityList         = ZoodiacBeastPriorityList
  
  -- Debug Mode
  --[[]]
  local e0=Effect.GlobalEffect()
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_CHAIN_SOLVED)
	e0:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetFieldGroup(player_ai,LOCATION_HAND,0)
	end)
	Duel.RegisterEffect(e0,0)
	local e1=e0:Clone()
	e1:SetCode(EVENT_TO_HAND)
	Duel.RegisterEffect(e1,0)
	local e2=e0:Clone()
	e2:SetCode(EVENT_PHASE_START+PHASE_MAIN1)
	Duel.RegisterEffect(e2,0)
  local e3=Effect.GlobalEffect()
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetCode(EFFECT_PUBLIC)
  e3:SetTargetRange(LOCATION_HAND,0)
  Duel.RegisterEffect(e3,player_ai)
  --]]
end

ZoodiacBeastIdentifier = {73881652} -- add the card(s) identifying your deck here

DECK_ZoodiacBeast = NewDeck("ZoodiacBeast",ZoodiacBeastIdentifier,ZoodiacBeastStartup) 

------------------------
--------- LIST ---------
------------------------

ZoodiacBeastActivateBlacklist={
77150143, -- ZBThroughblade
31755044, -- ZBViper
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMarmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBTriangle
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrancia
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigress
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
}
ZoodiacBeastSummonBlacklist={
77150143, -- ZBThroughblade
31755044, -- ZBViper
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMarmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

48905153, -- ZBDrancia
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigress
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
}
ZoodiacBeastSetBlacklist={
46060017, -- ZBTriangle
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice
}
ZoodiacBeastUnchainable={
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice
}

------------------------
--------- COND ---------
------------------------

function ZBThroughbladeCond(loc,c)
  if loc == PRIO_TOHAND then
    if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  if (
	    NormalSummonCheck() 
		or HasID(AIHand(),10719350,true) and OPTCheck(10719350) -- ZBTensu
	  )
	  and (
	    not HasID(AIHand(),c.id,true)
	    or PriorityCheck(AIHand(),PRIO_DISCARD,2,ZBFilter) > 2
	  )
	  and #AIMon() < 5
	  then
	    return true
	  else
	    return false
	  end
	end
  end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	 return PriorityCheck(AIHand(),PRIO_DISCARD,1) > 2
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return PriorityCheck(AIHand(),PRIO_DISCARD,1) > 2
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if Negated(c) then
	    return 6
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 4
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBViperCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  if GlobalZBEffectId == 41375811 then -- ZBLayca
	    return 10
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if Negated(c) then
	    return 5
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 3
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBCluckleCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if Negated(c) then
	    return 10
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 5
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBRabbinaCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if Negated(c) then
	    return 9
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 5
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBRamCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if Negated(c) then
	    return 8
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 5
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBMarmoratCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return CardsMatchingFilter(AIMon(),ZBXyzFilter) == 0
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return false
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return 10
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if Negated(c) then
	    return 7
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 2
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBBearmanCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) then
	  local bwMon = SubGroup(AIMon(),FilterRace,RACE_BEASTWARRIOR)
	  if CardsMatchingFilter(bwMon,FilterLevel,4) == 2
	  and not BattlePhaseCheck() 
	  --and Duel.GetCurrentPhase == PHASE_MAIN1
	  and (
	    not NormalSummonCheck()
	    or HasID(UseLists({AIHand(),AIST()}),10719350,true) -- ZBTensu
	  )
	  then
	    return 10
	  end
	end
  end
  return true
end

function ZBTriangleCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBTenkiCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return not HasID(UseLists({AIHand(),AIST()}),c.id,true)
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) 
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) 
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) 
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
  end
  return true
end

function ZBTensuCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  local zbMonHand = SubGroup(AIHand(),ZBMonFilter)
	  return 
	    not HasID(UseLists({AIHand(),AIST()}),c.id,true)
		and CardsMatchingFilter(zbMonHand,FilterLevelMax,4) > 0
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) 
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) 
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) 
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
  end
  return true
end

function ZBDranciaCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBBoarbowCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBLaycaCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBBroadbullCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBTigressCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBHammerkongCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

ZoodiacBeastPriorityList={                      
[77150143] = {8,1,8,1,3,1,3,1,1,1,ZBThroughbladeCond},	-- ZBThroughblade
[31755044] = {7,1,7,1,3,1,4,1,1,1,ZBViperCond},			-- ZBViper
[20155904] = {6,1,6,1,2,1,2,1,1,1,ZBCluckleCond},		-- ZBCluckle
[04367330] = {6,1,6,1,2,1,2,1,1,1,ZBRabbinaCond},		-- ZBRabbina
[04145852] = {6,1,6,1,2,1,2,1,1,1,ZBRamCond},			-- ZBRam
[78872731] = {9,1,9,1,4,1,5,1,1,1,ZBMarmoratCond},		-- ZBMarmorat
[67136033] = {1,1,1,1,1,1,3,1,1,1,ZBBearmanCond},		-- ZBBearman

[46060017] = {1,1,1,1,1,1,1,1,1,1,ZBTriangleCond},		-- ZBTriangle
[57103969] = {8,1,1,1,1,1,1,1,1,1,ZBTenkiCond},			-- ZBTenki
[10719350] = {9,1,1,1,1,1,1,1,1,1,ZBTensuCond},			-- ZBTensu
[73881652] = {1,1,1,1,1,1,1,1,1,1,nil},					-- ZBDirection
[98918572] = {1,1,1,1,1,1,1,1,1,1,nil},					-- ZBXiangke

[48905153] = {1,1,1,1,9,1,9,1,1,1,ZBDranciaCond},		-- ZBDrancia
[74393852] = {1,1,1,1,8,1,6,1,1,1,ZBBoarbowCond},		-- ZBBoarbow
[41375811] = {1,1,1,1,7,1,8,1,1,1,ZBLaycaCond},			-- ZBLayca
[85115440] = {1,1,1,1,6,1,5,1,1,1,ZBBroadbullCond},		-- ZBBroadbull
[11510448] = {1,1,1,1,5,1,7,1,1,1,ZBTigressCond},		-- ZBTigress
[14970113] = {1,1,1,1,4,1,4,1,1,1,ZBHammerkongCond},	-- ZBHammerkong

[00581014] = {1,1,1,1,1,1,1,1,1,1,nil},				-- ZBDaigusto
}
--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBViper
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMarmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBTriangle
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrancia
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigress
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
function ZoodiacBeastInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  
  -- GLOBAL RESET
  GlobalZBSummonId = 0
  GlobalZBTriangle = 0
  GlobalZodiacSign = 0
  GlobalZBEffectId = 0
  
  -- ACTIVE 0
  if HasIDNotNegated(Act,43898403,UseTwinTwister) then -- TwinTwisters
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,17626381) then -- Supply Squad
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,73628505) then -- Terraforming
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,00675319) -- ZodiacSign
  and not HasID(AIST(),00675319,true)
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,00581014,UseZBDaigusto) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,04423206,UseZBInvoker) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,96381979,false,(96381979*16+1),UseZBTigerKing) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- ZBMolmorat EFFECT
  if CardsMatchingFilter(AIMon(),FilterType,TYPE_XYZ) <= 3 then
    for i=1, #Act do
      local c = Act[i]
	  if NotNegated(c) and c.description == (78872731*16+1)
	  then
	    return {COMMAND_ACTIVATE,i}
	  end
    end
  end
  
  -- Tensu
  if HasIDNotNegated(Act,10719350) then -- Tensu
    OPTSet(10719350)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  
  -- ACTIVE 1
  if HasIDNotNegated(Act,48905153,false,(48905153*16+1),UseZBDrancia) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,41375811,false,(41375811*16+1),UseZBLayca) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,85115440,false,(85115440*16+1),UseZBBullhorn) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,11510448,false,(11510448*16+1),UseZBTigress) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- ACTIVE 2
  if HasIDNotNegated(Act,67136033) then -- ZBBearman
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,30741334) then -- ZBGiantrainer
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  
  if MaxxCheck() then
    -- ZBTerrortop
    if HasIDNotNegated(SpSum,81275020,SummonZBTerrortop) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	if HasIDNotNegated(Sum,81275020,SummonZBTerrortop) then
      return {COMMAND_SUMMON,CurrentIndex}
    end
	if HasIDNotNegated(SpSum,53932291,SummonZBTaketomborg) then -- STaketomborg
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBInvoker
    if HasIDNotNegated(SpSum,04423206) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	
	-- ZB SPECIAL SUMMON
	if HasIDNotNegated(Sum,78872731,SummonZBMarmorat) then
      return {COMMAND_SUMMON,CurrentIndex}
    end
	-- ZBHammerkong
	if HasIDNotNegated(SpSum,14970113,SummonZBHammerkong) then 
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBTigress
    if HasIDNotNegated(SpSum,11510448,SummonZBTigress) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBBullhorn
    if HasIDNotNegated(SpSum,85115440,SummonZBBroadbull) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBTenki
    if HasIDNotNegated(Act,57103969) then -- Tenki
      OPTSet(57103969)
      return {COMMAND_ACTIVATE,CurrentIndex}
    end
	-- ZBGiantrainer
    if HasIDNotNegated(Sum,67136033,SummonZBBearman) then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    if HasIDNotNegated(SpSum,30741334,SummonZBGiantrainer) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
    if HasIDNotNegated(Sum,77150143,SummonZBThroughblade) then
      return {COMMAND_SUMMON,CurrentIndex}
    end
	-- ZBTigerKing
    if HasIDNotNegated(SpSum,96381979,SummonZBTigerKing) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBTriangle
    if HasIDNotNegated(Act,46060017,nil,nil,LOCATION_HAND,ActiveZBTriangle)
    and MaxxCheck()
    then
      return {COMMAND_ACTIVATE,CurrentIndex}
    end
    if HasIDNotNegated(Act,46060017,nil,nil,LOCATION_SZONE,UseZBTriangle)
    and MaxxCheck()
    then
      GlobalZBTriangle = 1
      return {COMMAND_ACTIVATE,CurrentIndex}
    end
	if HasIDNotNegated(SpSum,00581014,SummonZBDaigusto) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBLayca
    if HasIDNotNegated(SpSum,41375811,SummonZBLayca) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBBoarbow
    if HasIDNotNegated(SpSum,74393852,SummonZBBoarbow) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	 -- ZBDrancia
    if HasIDNotNegated(SpSum,48905153,SummonZBDrancia) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
  end
  
  -- ZBDaigusto
  if HasIDNotNegated(SpSum,00581014,SummonZBDaigusto) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  -- ZBTenki
  if HasIDNotNegated(Act,57103969) then -- Tenki
    OPTSet(57103969)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- ZBTriangle
  if HasIDNotNegated(Act,46060017,nil,nil,LOCATION_HAND,ActiveZBTriangle)
  and MaxxCheck()
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,46060017,nil,nil,LOCATION_SZONE,UseZBTriangle)
  and MaxxCheck()
  then
    GlobalZBTriangle = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- SUMMON
  if HasIDNotNegated(Sum,77150143,SummonZBThroughblade) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  
  -- ZBMarmorat EFFECT
  for i=1, #Act do
    local c = Act[i]
	if NotNegated(c) and c.description == (78872731*16+1)
	then
	  return {COMMAND_ACTIVATE,i}
	end
  end
  
  return nil
end
------------------------
-------- FILTER --------
------------------------
function ZBFilter(c, exceptId)
  if exceptId == nil then exceptId = 0 end
  return 
    FilterSet(c,0xf1)
	and c.id ~= exceptId
end
function ZBMonFilter(c,exceptId)
  if exceptId == nil then exceptId = 0 end
  return 
    FilterSet(c,0xf1)
	and FilterType(c,TYPE_MONSTER)
	and c.id ~= exceptId
end
function ZBXyzFilter(c)
  if c == nil then return false end
  return
    FilterSet(c,0xf1)
	and FilterType(c,TYPE_XYZ)
end
function ZBNonXyzFilter(c,exceptId)
  if exceptId == nil then exceptId = 0 end
  return 
    IsSetCode(c.setcode,0xf1)
	and not FilterType(c,TYPE_XYZ)
end

function ZBBestDetachFilter(c)
  return
    not ZBFilter(c)
	or c.base_attack <= 0
end

function ZBTriangleFilter(c)
  return
    c.id == 57103969 -- ZBTenki
	and FilterLocation(c,LOCATION_SZONE)
	and FilterPosition(c,POS_FACEUP)
	or
	(
	  c.id == 04367330 -- ZBRabbina
	  or c.id == 20155904 -- ZBCluckle
	  or c.id == 04145852 -- ZBRam
	  or c.id == 81275020 -- STerrotop
	  or c.id == 53932291 -- STaketomborg
	)
	and FilterLocation(c,LOCATION_MZONE)
end

function ZBDranciaDestroyFilter(c)
  return (
    Targetable(c,TYPE_MONSTER)
    and Affected(c,TYPE_MONSTER)
	and DestroyFilterIgnore(c)
  )
end

------------------------
--------- USE ----------
------------------------
function UseZBThroughblade(c)
  return true
end
function UseZBViper(c)
  return false
end

function UseZBDrancia(c)
  return false
end
function UseZBLayca(c)
  OPTSet(c.id)
  return true
end
function UseZBBroadbull(c)
  OPTSet(c.id)
  return true
end
function UseZBTigress(c)
  OPTSet(c.id)
  return true
end

function ActiveZBTriangle(c)
  if OPTCheck(c.id)
  and not HasIDNotNegated(AIST(),c.id,true)
  then
    return true
  end
  return false
end
function UseZBTriangle(c)
  if CardsMatchingFilter(AIField(),ZBTriangleFilter) > 0
  and OPTCheck(c.id)
  then
    OPTSet(c.id)
    return true
  elseif #AIMon() <= 4
  and OPTCheck(c.id)
  then
    OPTSet(c.id)
    return true
  end
  return false
end

function UseZBDaigusto(c)
  OPTSet(c.id)
  return true
end
function UseZBInvoker(c)
  OPTSet(c.id)
  return true
end
function UseZBTigerKing(c)
  local testcontinuous = CardsMatchingFilter(OppMon(),FilterAffected,EFFECT_TYPE_FIELD)
  --print("testcontinuous",testcontinuous)
  local oppMonFaceUp = SubGroup(OppMon(),FilterPosition,POS_FACEUP)
  if #oppMonFaceUp > CardsMatchingFilter(oppMonFaceUp,FilterRace,RACE_BEASTWARRIOR)
  then
    OPTSet(c.id)
    return true
  end
  return false
end

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBViper
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMarmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBTriangle
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrancia
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigress
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
function ZoodiacBeastEffectYesNo(id,card)
  print("EffectYesNo",id)
  local result = nil
  if id == 81275020 then -- STerrotop
    result = 1
  end
  
  if id == 77150143 then -- ZBThroughblade
    result = 1
  end
  if id == 04367330 then -- ZBRabbina
    result = 1
  end
  if id == 04145852 then -- ZBRam
    result = 1
  end
  if id == 78872731 then -- ZBMarmorat
    result = 1
  end
  
  if id == 96381979 then -- ZBTigerKing
    result = 1
  end
  
  if id == 46060017 then -- ZBTriangle
    GlobalZBTriangle = 2
    result = 1
  end
  
  if result then
    if result == 1 then
      OPTSet(id)
	end
  end
  
  return result
end

function ZoodiacBeastYesNo(description_id)
  -- Example implementation: continue attacking, let the ai decide otherwise
  if (description_id/16) > 99999 then
    print("YesNo - id: "..(description_id/16).." - desc: "..description_id)
    if description_id/16 == 00675319 then -- ZodiacSign
	  if GlobalZBTriangle == 0 then
	    GlobalZodiacSign = 1
	    return 1
	  else
	    return 0
	  end
	end
  else
    print("YesNo - desc: "..description_id)
  end
end

function ZoodiacBeastOption(options)
  print("Options:")
  for i=1,#options do
    if options[i] == (67136033*16) then -- ZBBearman
	  return i
	end
  end
  return nil
end

------------------------
-------- SUMMON --------
------------------------
function SummonZBThroughblade(c)
  if PriorityCheck(AIHand(),PRIO_DISCARD,1,ZBFilter) > 2
  then
    OPTSet(c.id)
	return true
  end
  return false
end
function SummonZBMarmorat(c)  
  if HasID(AIDeck(),c.id,true)
  and not HasID(AIMon(),c.id,true)
  and CardsMatchingFilter(AIMon(),ZBXyzFilter) == 0
  then
    return true
  end
  return false
end
function SummonZBTerrortop(c)
  if CardsMatchingFilter(AIExtra(),FilterRank,3) > 0 -- ZBInvoker
  and (
    HasID(UseLists({AIDeck(),AIHand()}),53932291,true) -- ZBTaketomborg
	or CardsMatchingFilter(AIMon(),FilterLevel,3) > 0
  )
  then
    return true
  end
  return false
end
function SummonZBTaketomborg(c)
  if CardsMatchingFilter(AIExtra(),FilterRank,3) > 0 -- ZBInvoker
  then
    return true
  end
  return false
end

function SummonZBHammerkong(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) == 0
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end
function SummonZBTigress(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and OPTCheck(c.id + 1)
  and not HasID(AIMon(),c.id,true)
  and HasID(AIGrave(),78872731,true)
  and HasID(UseLists({AIHand(),AIDeck()}),78872731,true)
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end
function SummonZBTigress2(c)
  local zbMon = SubGroup(AIGrave(),ZBMonFilter)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and OPTCheck(c.id)
  and CardsMatchingFilter(zbMon,FilterAttackMin,0) > 0
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end
function SummonZBTigress3(c)
  return false
end
function SummonZBBroadbull(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and not HasID(AIMon(),c.id,true)
  and OPTCheck(c.id + 1)
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end
function SummonZBLayca(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and not HasID(AIMon(),c.id,true)
  and OPTCheck(c.id + 1)
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end
function SummonZBBoarbow(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and not HasID(AIMon(),c.id,true)
  and OPTCheck(c.id + 1)
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end
function SummonZBBoarbow2(c)
  return false
end
function SummonZBDrancia(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and not HasID(AIMon(),c.id,true)
  and OPTCheck(c.id + 1)
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id + 1)
    return true
  end
  return false
end

function SummonZBBearman(c)
  local bwMon = SubGroup(AIMon(),FilterRace,RACE_BEASTWARRIOR)
  return 
    CardsMatchingFilter(bwMon,FilterLevel,4) == 2
    and not BattlePhaseCheck()
	and #AIMon() < 5
end

function SummonZBGiantrainer(c)
  return not BattlePhaseCheck()
end

function SummonZBTigerKing(c)
  return 
    OPTCheck(57103969) -- ZBTenki
	and not HasID(UseLists({AIHand(),AIST()}),57103969,true)
	or 
	OPTCheck(10719350) -- ZBTensu
	and not HasID(UseLists({AIHand(),AIST()}),10719350,true)
end
function SummonZBDaigusto(c)
  return
    not HasIDNotNegated(AIMon(),c.id,true)
	and CardsMatchingFilter(AIGrave(),FilterType,TYPE_MONSTER) >= 3
	and (
	  not BattlePhaseCheck() 
	  or CardsMatchingFilter(AIMon(),FilterPosition,POS_FACEUP_DEFENSE) > 0
	  or TotalATK(AIMon(),2,FilterLevel,4) < 1800
	)
end

------------------------
-------- TARGET --------
------------------------
function ZBCluckleTarget(cards,min,max)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TOHAND,max)
  end
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
end
function ZBRabbinaTarget(cards,min,max)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TOHAND,max)
  end
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
end
function ZBRamTarget(cards,min,max)
  if LocCheck(cards,LOCATION_GRAVE) then
    --CountPrioTarget(cards,PRIO_TOFIELD,1,nil,nil,nil,"ZBRamTarget")
    return Add(cards,PRIO_TOFIELD,max,ZBNonXyzFilter)
  end
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
end
function ZBMarmoratTarget(cards,min,max)
  if LocCheck(cards,LOCATION_DECK) then
    --print("ZBMarmorat - DECK TO FIELD")
    return Add(cards,PRIO_TOGRAVE,max)
  end
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBMarmorat - OVERLAY TO GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
end

function ZBMaterialTarget(cards,min,max)
  print("ZBMaterialTarget: "..GlobalZBSummonId)
  local result = Add(cards,PRIO_TOGRAVE,max,ZBXyzFilter)
  local xyzmat = cards[1].xyz_materials
  local ZBMon = SubGroup(xyzmat,ZBFilter)
  GlobalZBAttackSum = 0
  for i=1,#ZBMon do
    local c = ZBMon[i]
	--print(c.id.." - attack: "..c.base_attack)
	if c.base_attack > 0 then
      GlobalZBAttackSum = GlobalZBAttackSum + c.base_attack
	end
  end
  return result
end
function ZBAttachTarget(cards,min,max)
  if LocCheck(cards,LOCATION_GRAVE) then
    --CountPrioTarget(cards,PRIO_TOFIELD,1,nil,nil,nil,"ZBAttachTarget")
	if OPTCheck(00581014) 
	and HasIDNotNegated(cards,00581014)
	then -- ZBDaigusto
	  return {CurrentIndex}
	end
    return Add(cards,PRIO_TOFIELD,max)
  end
end

-- ZBXyzTarget
function ZBHammerkongTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBHammerkong - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
end
function ZBTigressTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBTigressTarget - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
  if LocCheck(cards,LOCATION_GRAVE) then
    --print("ZBTigressTarget - GRAVE to OVERLAY")
    return ZBAttachTarget(cards,min,max)
  end
  if LocCheck(cards,LOCATION_MZONE) then
    --print("ZBTigressTarget - MON")
    return FindID(11510448,cards,true) -- Own
  end
end
function ZBBroadbullTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBBroadbullTarget - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
  if LocCheck(cards,LOCATION_DECK) then
    --CountPrioTarget(cards,PRIO_TOHAND,1,nil,nil,nil,"ZBBroadbullTarget")
    return Add(cards,PRIO_TOHAND,max)
  end
end
function ZBLaycaTarget(cards,min,max,c)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBLayca - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
  if LocCheck(cards,LOCATION_GRAVE) then
    --print("ZBLayca - GRAVE to FIELD")
	GlobalZBEffectId = c.id
    return Add(cards,PRIO_TOFIELD,max)
  end
end
function ZBBoarbowTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBBoarbow - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
end
function ZBDranciaTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
  return BestTargets(cards,max,TARGET_DESTROY,ZBDranciaDestroyFilter,nil,nil,c)
end

GlobalZodiacSign = 0
function ZodiacSignTarget(cards,min,max,c)
  return Add(cards,PRIO_TOGRAVE,max)
end
GlobalZBTriangle = 0
function ZBTriangleTarget(cards,min,max)
  if LocCheck(cards,LOCATION_DECK)
  then
    print("ZBTriangleTarget - DECK to FIELD")
    return Add(cards,PRIO_TOFIELD,max)
  end
  if GlobalZBTriangle == 1 then
    print("ZBTriangleTarget - DESTROY")	
	if HasID(cards,57103969,true) -- Tenki
	then
      return FindID(57103969,cards,true)
	elseif HasID(cards,53932291,true) -- STaketomborg
	then
	  return FindID(53932291,cards,true) 
	elseif HasID(cards,81275020,true) -- STerrotop
	then
	  return FindID(81275020,cards,true)
	elseif HasID(cards,78872731,true) -- ZBMolmorat
	then
	  return FindID(78872731,cards,true)
	elseif HasID(cards,20155904,true) -- ZBCluckle
	and CardsMatchingFilter(AIGrave(),ZBFilter,20155904) > 0
	then
	  return FindID(20155904,cards,true)
	elseif HasID(cards,04367330,true) -- ZBRabbina
	and CardsMatchingFilter(AIGrave(),ZBFilter,04367330) > 0
	then
	  return FindID(04367330,cards,true)
	elseif HasID(cards,04145852,true) -- ZBRam
	and CardsMatchingFilter(AIGrave(),ZBMonFilter,04145852) > 0
	then
	  return FindID(04145852,cards,true)
	elseif HasID(cards,46060017,true) -- ZBTriangle
	then
	  return FindID(46060017,cards,true)
	else
	  return Add(cards,PRIO_TOGRAVE,1,ZBNonXyzFilter)
	end
  end
  if GlobalZBTriangle == 2 then
    print("ZBTriangleTarget - to MON")
    return Add(cards,PRIO_TOGRAVE,max)
  end
end
function ZBDirectionTarget(cards,min,max,source)
  return Add(cards,PRIO_TOHAND,max)
end
-- ZBOther
function ZBInvokerTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
  return Add(cards,PRIO_TOFIELD,max)
end

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBViper
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMarmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBTriangle
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrancia
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigress
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]

GlobalZBSummonId = 0
function ZoodiacBeastCard(cards,min,max,id,c)
  if c then 
    --print("Card - CardId: ".. c.id .." - cards: "..#cards.." - min: "..min.." - max: "..max)
  end
  if id == 77150143 then -- ZBThroughblade
    return Add(cards,PRIO_DISCARD,min)
  end
  if id == 31755044 then -- ZBViper
    return Add(cards,PRIO_TOGRAVE,min)
  end
   if id == 20155904 then -- ZBCluckle
    return ZBCluckleTarget(cards,min,max)
  end
  if id == 04367330 then -- ZBRabbina
    return ZBRabbinaTarget(cards,min,max)
  end
  if id == 04145852 then -- ZBRam
    return ZBRamTarget(cards,min,max)
  end
  if id == 78872731 then -- ZBMarmorat
    return ZBMarmoratTarget(cards,min,max)
  end
  
  if id == 14970113 then -- ZBHammerkong
    return ZBHammerkongTarget(cards,min,max)
  end
  if id == 11510448 then -- ZBTigress
    return ZBTigressTarget(cards,min,max)
  end
  if id == 85115440 then -- ZBBroadbull
    return ZBBroadbullTarget(cards,min,max)
  end
  if id == 41375811 then -- ZBHammerkong
    return ZBLaycaTarget(cards,min,max,c)
  end
  if id == 74393852 then -- ZBBoarbow
    return ZBBoarbowTarget(cards,min,max)
  end
  if id == 48905153 then -- ZBDrancia
    return ZBDranciaTarget(cards,min,max,c)
  end
  
  if id == 04423206 then -- ZBInvoker
    return ZBInvokerTarget(cards,min,max)
  end
  if id == 96381979 then -- ZBTigerKing
    return Add(cards,PRIO_TOHAND,max)
  end
  if id == 00581014 then -- ZBDaigusto
    return Add(cards,PRIO_TODECK,max)
  end
  
  if id == 46060017 then -- ZBTriangle
    return ZBTriangleTarget(cards,min,max,c)
  end
  if id == 73881652 then -- ZBDirection
    return ZBDirectionTarget(cards,min,max,c)
  end
  
  if id == 57103969 then -- ZBTenki
    return Add(cards,PRIO_TOHAND,max)
  end
  
  if id == 98954106 then -- ZBJAvarice
    return Add(cards,PRIO_TODECK,max)
  end
  
  if not c 
  and GlobalZBSummonId ~= 0 then
    local result = ZBMaterialTarget(cards,min,max)
	GlobalZBSummonId = 0
    return result 
  end
  
  return nil
end
------------------------
-------- CHAIN ---------
------------------------
function ChainZBViper(c,aiTurn)
  return false
end
function ChainZBDrancia(c,aiTurn)
  return false
end

function ChainZBDirection(c)
  return false
end

function ChainZBJAvarice(c,aiTurn)
  return false
end

function ZBRemovalCheckCard(c)
  return 
    RemovalCheckCard(c,CATEGORY_DESTROY)
    or RemovalCheckCard(c,CATEGORY_REMOVE)
	or RemovalCheckCard(c,CATEGORY_TOGRAVE)
	or RemovalCheckCard(c,CATEGORY_TOHAND)
	or RemovalCheckCard(c,CATEGORY_REMOVE)
end

GlobalRabbinaRam = 0
function ChainZBRabbinaRam(target)
  local result = false
  return result
end

function ZoodiacBeastChain(cards)  
  return nil
end
------------------------
-------- BATTLE --------
------------------------

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBViper
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMarmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBTriangle
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrancia
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigress
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
ZoodiacBeastAtt={
48905153, -- ZBDrancia
85115440, -- ZBBroadbull
11510448, -- ZBTigress
74393852, -- ZBBoarbow
}
ZoodiacBeastDef={
31755044, -- ZBViper
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMarmorat
}
function ZoodiacBeastPosition(id,available)
  result = nil
  for i=1,#ZoodiacBeastAtt do
    if ZoodiacBeastAtt[i]==id 
    then 
      result=1
    end
  end
  for i=1,#ZoodiacBeastDef do
    if ZoodiacBeastDef[i]==id 
    then 
      result=4
    end
  end
  return result
end

function ZoodiacBeastBattleCommand(cards, activatable) 
  local targets = OppMon()
  local attackable = {}
  local mustattack = {}
  for i=1,#targets do
    if targets[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then
      attackable[#attackable+1]=targets[i]
    end
    if targets[i]:is_affected_by(EFFECT_MUST_BE_ATTACKED)>0 then
      mustattack[#mustattack+1]=targets[i]
    end
  end
  if #mustattack>0 then
    targets = mustattack
  else
    targets = attackable
  end
  
  if HasIDNotNegated(cards,48905153) -- ZBDrancia
  and CanWinBattle(cards[CurrentIndex],targets) 
  then
    return Attack(CurrentIndex)
  end

  return nil
end

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBViper
20155904, -- ZBCluckle
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMarmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBTriangle
00675319, -- ZBSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98918572, -- ZBXiangke
98954106, -- ZBJAvarice

48905153, -- ZBDrancia
74393852, -- ZBBoarbow
41375811, -- ZBLayca
85115440, -- ZBBroadbull
11510448, -- ZBTigress
14970113, -- ZBHammerkong

30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
