## Oystercard Challenge
-------------------------

Modelling an oyster travel card
- Cards have a balance
- Insufficient funds scenarios are accounted for with error raising
- Cards store a list of past journeys
- Double touch-in/touch-out scenarios are accounted for with a penalty charge
- Station can be initialised with different names and zones

#### Implementation
-------------------
```
2.4.2 :002 > Aldgate = Station.new("Aldgate", 1)
 => #<Station:0x00007feab5834ad0 @name="Aldgate", @zone=1>
2.4.2 :003 > Barking = Station.new("Barking", 4)
 => #<Station:0x00007feab5a0c600 @name="Barking", @zone=4>
2.4.2 :004 > card = Oystercard.new
 => #<Oystercard:0x00007feab59ff8d8 @balance=0, @journey_log=#<JourneyLog:0x00007feab59ff838 @journey_class=Journey, @journeys=[]>>
2.4.2 :005 > card.topup(50)
 => 50
2.4.2 :006 > card.touch_in(Aldgate)
 => #<Journey:0x00007feab59eed30 @fare=0, @start_point="Aldgate", @start_zone=1, @complete=false>
2.4.2 :007 > card.touch_out(Barking)
 => 46
2.4.2 :008 > card.balance
 => 46
2.4.2 :009 > card.read_journeys
 => [#<Journey:0x00007feab59eed30 @fare=4, @start_point="Aldgate", @start_zone=1, @complete=true, @end_point="Barking", @end_zone=4>]
```
