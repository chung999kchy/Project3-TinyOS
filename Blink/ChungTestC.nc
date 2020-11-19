#include <Timer.h>
#include <UserButton.h>

module ChungTestC {
    uses {
        interface Boot;
        interface Get<button_state_t>;
        interface Notify<button_state_t>;
        interface Timer<TMilli> as MoodTimer;
        interface Timer<TMilli> as MoodTimer2;
        interface Timer<TMilli> as Timer0;
        interface Timer<TMilli> as Timer1;
        interface Timer<TMilli> as Timer2;
        interface Leds;
    }
}

implementation {
    uint8_t mood;
    uint8_t redVar;     //Led0
    uint8_t yellowVar;  //Led1
    uint8_t blueVar;    //Led2

    event void Boot.booted(){
        call Notify.enable();
        mood = 0;
        redVar = 0;
        yellowVar = 0;
        blueVar = 0;
    }

    event void Notify.notify(button_state_t value){
        if (value == BUTTON_PRESSED && mood == 0){
            mood = 1;
        }else if (value == BUTTON_PRESSED && mood == 1){
            mood = 2;
        }else if (value == BUTTON_PRESSED && mood == 2){
            mood = 3;
        }else if (value == BUTTON_PRESSED && mood == 3){
            call MoodTimer.stop();
            mood = 4;
        }else if (value == BUTTON_PRESSED && mood == 4){
            mood = 0;
            call MoodTimer2.stop();
        }


        if(mood == 0){
            call Leds.led0On();
            call Leds.led1Off();
            call Leds.led2Off();
            call MoodTimer.stop();
        }else if(mood == 1){
            call Leds.led1On();
            call Leds.led0Off();
            call Leds.led2Off();
        }else if(mood == 2){
            call Leds.led2On();
            call Leds.led0Off();
            call Leds.led1Off();
        }else if (mood == 3){
            call MoodTimer.startPeriodic(1000);
        }else {
            call MoodTimer2.startPeriodic(2000);
        }

    }

    event void Timer0.fired(){
        call Leds.led0On();
        call Leds.led1Off();
        call Leds.led2Off();
    }
  
    event void Timer1.fired(){
        //call Leds.led1Toggle();
        call Leds.led1On();
        call Leds.led2Off();
        call Leds.led0Off();
    }
  
    event void Timer2.fired(){
        //call Leds.led2Toggle();
        call Leds.led2On();
        call Leds.led1Off();
        call Leds.led0Off();
    }

    event void MoodTimer.fired(){
        call Timer0.startOneShot( 250 );  
        call Timer1.startOneShot( 500 );	
        call Timer2.startOneShot( 750 );        
    }

    event void MoodTimer2.fired(){
        call Timer2.startOneShot( 500 );  
        call Timer1.startOneShot( 1000 );	
        call Timer0.startOneShot( 1500 );        
    }
}
    