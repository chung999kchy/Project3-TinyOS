configuration ChungTestAppC {
}
implementation {
    components ChungTestC;

    components MainC;
    ChungTestC.Boot -> MainC;

    components UserButtonC;
    ChungTestC.Get -> UserButtonC;
    ChungTestC.Notify -> UserButtonC;

    components new TimerMilliC() as Timer0;
    components new TimerMilliC() as Timer1;
    components new TimerMilliC() as Timer2;
    ChungTestC.Timer0 -> Timer0;
    ChungTestC.Timer1 -> Timer1;
    ChungTestC.Timer2 -> Timer2;

    components new TimerMilliC() as MoodTimerC;
    components new TimerMilliC() as MoodTimer2C;
    ChungTestC.MoodTimer -> MoodTimerC;
    ChungTestC.MoodTimer2 -> MoodTimer2C;

    components LedsC;
    ChungTestC.Leds -> LedsC;
 
 
}
