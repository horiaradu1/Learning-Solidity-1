pragma solidity >=0.5.0 <=0.8.3;

contract paylock {
    
    enum State { Working, Completed, Done_1, Delay, Done_2, Forfeit }

    struct States {
        uint disc;
        State st;
        uint clock;
        address timeAdd;
    }
    
    States variables;
    
    constructor() public {
        variables.st = State.Working;
        variables.disc = 0;
        variables.clock = 0;
        variables.timeAdd = 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C;
    }
    
    function tick() external {
        require( variables.timeAdd == msg.sender );
        if (variables.clock < 4) {
            variables.clock = variables.clock + 1;
        }
    }

    function signal() external {
        require( variables.st == State.Working );
        variables.st = State.Completed;
        variables.disc = 10;
        variables.clock = 0;
    }

    function collect_1_Y() external {
        require( variables.st == State.Completed );
        require( variables.clock < 4 );
        variables.st = State.Done_1;
        variables.disc = 10;
    }

    function collect_1_N() external {
        require( variables.st == State.Completed );
        require( variables.clock == 4 );
        variables.st = State.Delay;
        variables.disc = 5;
        variables.clock = 0;
    }

    function collect_2_Y() external {
        require( variables.st == State.Delay );
        require( variables.clock < 4 );
        variables.st = State.Done_2;
        variables.disc = 5;
    }

    function collect_2_N() external {
        require( variables.st == State.Delay );
        require( variables.clock == 4 );
        variables.st = State.Forfeit;
        variables.disc = 0;
    }

}