# Reaction-timer

Description: 
The goal of this project is to build a circuit that tests a user's reaction time. This is done through utilizing a state machine in VHDL. The idea of the state machine is that there are three states: an idle state that the user is in when the reset button is pressed, a wait state that the user is in when the start button is pressed and a counting state that the user enters after being in the wait state for a short period of time. In the wait state a red led lights up followed by a green led. When this happens you enter the count state where the clock cycles it takes the user to press the react button is counted. Once the react button is pressed the cycles stops and then the reset button can be pressed to restart the reaction timer. If react is pressed before the green led lights up the cycle count never starts.
