#include <UserButton.h>
#include <Timer.h>
#include "Sensor.h"

module SensorC
{
    // general interface
    uses {
        interface Boot;
        interface Leds;
    }

    //UserButton
    uses {
        interface Get<button_state_t>;
        interface Notify<button_state_t>;
    }

    //Radio
    uses {
        interface Packet;
        interface AMPacket;
        interface AMSend;
        interface SplitControl as AMControl;
        interface Receive;
    }
}

implementation {

    bool _radioBusy = FALSE;
    message_t _packet;

    event void Boot.booted(){
        call Notify.enable();
        call AMControl.start();
    }

    event void Notify.notify(button_state_t val){
        if (_radioBusy == FALSE){
            // Create packet
            SensorMsg_t* msg = call Packet.getPayload(& _packet, sizeof(SensorMsg_t));
            msg -> NodeId = TOS_NODE_ID;
            msg -> Data = (uint8_t) val;

            // Sending packet
            if(call AMSend.send(AM_BROADCAST_ADDR, & _packet, sizeof(SensorMsg_t)) == SUCCESS){
                _radioBusy = TRUE;
            }
        }
        
    }

    event void AMSend.sendDone(message_t *msg, error_t error){
        if (msg == & _packet){
            _radioBusy = FALSE;
        }
    }

    event void AMControl.startDone(error_t error){
        if (error == SUCCESS){
            call Leds.led0On();

        }else{
            call AMControl.start();

        }
    }

    event void AMControl.stopDone(error_t error){

    }

    event message_t * Receive.receive(message_t * msg, void * payload, uint8_t len){
        return msg;
    }
}