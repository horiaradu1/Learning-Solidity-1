pragma solidity >=0.5.0 <=0.8.3;

contract paylock {

    uint disc;
    enum State { Working, Completed, Done_1, Delay, Done_2, Forfeit }
    State st;
    
    constructor() public {
        st = State.Working;
        disc = 0;
    }

    function signal() external {
        require( st == State.Working );
        st = State.Completed;
        disc = 10;
    }

    function collect_1_Y() external {
        require( st == State.Completed );
        st = State.Done_1;
        disc = 10;
    }

    function collect_1_N() external {
        require( st == State.Completed );
        st = State.Delay;
        disc = 5;
    }

    function collect_2_Y() external {
        require( st == State.Delay );
        st = State.Done_2;
        disc = 5;
    }

    function collect_2_N() external {
        require( st == State.Delay );
        st = State.Forfeit;
        disc = 0;
    }

}