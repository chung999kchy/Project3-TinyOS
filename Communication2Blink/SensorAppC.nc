configuration SensorAppC{

} 

implementation {
    components SensorC as App;
    components MainC; // Boot
    components LedsC; //Led

    App.Boot -> MainC;
    App.Leds -> LedsC;

    components UserButtonC;
    App.Get -> UserButtonC;
    App.Notify -> UserButtonC;

    // Radio Communication
    components ActiveMessageC;
    components new AMSenderC(AM_RADIO);
    components new AMReceiverC(AM_RADIO);

    App.Packet -> AMSenderC;
    App.AMPacket -> AMSenderC;
    App.AMSend -> AMSenderC;
    App.AMControl -> ActiveMessageC;
    App.Receive -> AMReceiverC; 
}